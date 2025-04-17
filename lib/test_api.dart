import 'package:http/http.dart' as http;

Future<void> fetchTribeOfNoiseData(String query) async {
  final url = Uri.parse(
    'https://prosearch.tribeofnoise.com/api/search?q=$query'
  );
  
  final response = await http.get(url, headers: {
    'Authorization': 'Bearer YOUR_ACCESS_TOKEN', // Cần xác thực
    'Accept': 'application/json',
  });

  print(response.body);
}