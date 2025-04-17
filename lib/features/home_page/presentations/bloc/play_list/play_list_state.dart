import 'package:spotify_clone/features/home_page/domain/entities/song/song.dart';

abstract class PlayListState {
  const PlayListState();
}
class PlayListLoadingState extends PlayListState {
  const PlayListLoadingState();
}
class PlayListLoadedState extends PlayListState {
  final List<SongEntity> songs;
  const PlayListLoadedState(this.songs);
}
class PlayListErrorState extends PlayListState {
  final String errorMessage;
  const PlayListErrorState(this.errorMessage);
}
