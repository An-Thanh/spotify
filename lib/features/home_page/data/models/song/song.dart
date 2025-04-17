import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_clone/features/home_page/domain/entities/song/song.dart';

class SongModel {
  final String id;
  final String title;
  final String artist;
  final String cover;
  final String url;
  final num duration;
  final Timestamp releaseDate;

  SongModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.cover,
    required this.url,
    required this.duration,
    required this.releaseDate,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json['id'] as String,
      title: json['title'] as String,
      artist: json['artist'] as String,
      cover: json['cover'] as String,
      url: json['url'] as String,
      duration: json['duration'] as num,
      releaseDate: json['releaseDate'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'cover': cover,
      'url': url,
      'duration': duration,
      'releaseDate': releaseDate,
    };
  }
}

// Convert a SongModel instance to a SongEntity instance
extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      id: id,
      title: title,
      artist: artist,
      cover: cover,
      url: url,
      duration: duration,
      releaseDate: releaseDate,
    );
  }
}
