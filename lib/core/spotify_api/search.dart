import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:spotify_clone/core/spotify_api/enum.dart';
import 'package:spotify_clone/secrets.dart';

class Search {
  // 🔁 Singleton setup
  static final Search _instance = Search._internal();
  factory Search() => _instance;
  Search._internal();

  String? _accessToken;
  DateTime? _tokenExpiration;

  // Lấy access token nếu đã hết hạn hoặc chưa có
  Future<String> getAccessToken() async {
    // Kiểm tra xem token còn hợp lệ không
    if (_accessToken != null && _tokenExpiration != null && DateTime.now().isBefore(_tokenExpiration!)) {
      return _accessToken!;
    }

    // Nếu token hết hạn, request token mới
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Authorization': 'Basic ${base64Encode(utf8.encode(
            '${SpotifySecrets.clientId}:${SpotifySecrets.clientSecret}'))}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {'grant_type': 'client_credentials'},
    );

    final json = jsonDecode(response.body);
    _accessToken = json['access_token'];
    _tokenExpiration = DateTime.now().add(Duration(seconds: json['expires_in'])); // Token hết hạn sau expires_in giây

    return _accessToken!;
  }

  Future<void> searchTrack(String keyword, SearchType type, int limit) async {
    final token = await getAccessToken();

    final response = await http.get(
      Uri.parse(
          'https://api.spotify.com/v1/search?q=$keyword&type=${type.name}&limit=$limit'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    final json = jsonDecode(response.body);
    final tracks = json['tracks']['items'];

    for (var track in tracks) {
      print('${track['name']} - ${track['artists'][0]['name']}');
    }
  }

  Future<void> searchRandomTrack(String keyword) async {
    final token = await getAccessToken();

    final response = await http.get(
      Uri.parse(
          'https://api.spotify.com/v1/search?q=$keyword&type=track&limit=20'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    final json = jsonDecode(response.body);
    final tracks = json['tracks']['items'];

    if (tracks.isEmpty) {
      print("Không tìm thấy bài nào.");
      return;
    }

    final random = Random();
    final randomTrack = tracks[random.nextInt(tracks.length)];

    final name = randomTrack['name'];
    final artist = randomTrack['artists'][0]['name'];
    final previewUrl = randomTrack['external_urls']['spotify'];
    final imageUrl = randomTrack['album']['images'][0]['url'];

    print("🎵 Bài ngẫu nhiên:");
    print("Tên: $name");
    print("Nghệ sĩ: $artist");
    print("Ảnh: $imageUrl");
    print("Preview (30s): $previewUrl");
  }
}
