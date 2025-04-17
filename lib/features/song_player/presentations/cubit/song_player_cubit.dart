import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:spotify_clone/features/home_page/domain/entities/song/song.dart';
import 'package:spotify_clone/features/song_player/presentations/cubit/song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  final AudioPlayer player = AudioPlayer(
    androidApplyAudioAttributes: true,
    handleInterruptions: true,
    handleAudioSessionActivation: true,
  );

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;
  SongEntity? _currentSong;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    player.positionStream.listen((position) {
      songPosition = position;
      _updateSongPlayer();
    });

    player.durationStream.listen((duration) {
      if (duration != null) {
        songDuration = duration;
        _updateSongPlayer();
      }
    });

    player.playerStateStream.listen((_) {
      _updateSongPlayer();
    });
  }

  void _updateSongPlayer() {
    if (_currentSong == null) return;

    emit(SongPlayerLoaded(
      duration: songDuration,
      position: songPosition,
      currentSong: _currentSong!,
      isPlaying: player.playing,
    ));
  }

  Future<void> loadSong(SongEntity song) async {
    try {
      _currentSong = song;

      await player.setAudioSource(
        ProgressiveAudioSource(
          Uri.parse(song.url),
          tag: MediaItem(
            id: song.id,
            title: song.title,
            artist: song.artist,
            artUri: Uri.parse(song.cover),
          ),
        ),
      );

      await player.setLoopMode(LoopMode.one);
      await player.play();

      _updateSongPlayer();
    } catch (e) {
      print("Lỗi khi load bài hát: $e");
      emit(SongPlayerFailure());
    }
  }

  Future<void> playOrPauseSong() async {
    if (player.playing) {
      await player.pause();
    } else {
      await player.play();
    }

    _updateSongPlayer();
  }

  Future<void> stopSong() async {
    try {
      await player.stop();
      _updateSongPlayer();
    } catch (e) {
      emit(SongPlayerFailure());
    }
  }

  Future<void> seekTo(Duration position) async {
    await player.seek(position);
  }

  Future<void> setLoop(LoopMode loop) async {
    await player.setLoopMode(loop);
    _updateSongPlayer();
  }

  @override
  Future<void> close() async {
    await player.dispose();
    return super.close();
  }
}
