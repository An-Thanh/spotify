import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity {
  final String id;
  final String title;
  final String artist;
  final String cover;
  final String url;
  final num duration;
  final Timestamp releaseDate;

  SongEntity({
    required this.id,
    required this.title,
    required this.artist,
    required this.cover,
    required this.url,
    required this.duration,
    required this.releaseDate,
  });
}