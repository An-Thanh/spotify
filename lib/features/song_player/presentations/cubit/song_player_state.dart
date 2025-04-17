import 'package:spotify_clone/features/home_page/domain/entities/song/song.dart';

abstract class SongPlayerState {}

class SongPlayerLoading extends SongPlayerState{}

class SongPlayerLoaded extends SongPlayerState{
  final Duration duration;
  final Duration position;
  final SongEntity currentSong;
  final bool isPlaying;

  SongPlayerLoaded({
    required this.duration,
    required this.position,
    required this.currentSong,
    required this.isPlaying,
  });
}

class SongPlayerFailure extends SongPlayerState{}