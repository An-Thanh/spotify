import 'package:spotify_clone/features/home_page/domain/entities/song/song.dart';

abstract class NewsSongState {
  const NewsSongState();
}

class NewsSongLoadingState extends NewsSongState {
  const NewsSongLoadingState();
}

class NewsSongLoadedState extends NewsSongState {
  final List<SongEntity> songs;
  const NewsSongLoadedState(this.songs);
}

class NewsSongErrorState extends NewsSongState {
  final String errorMessage;
  const NewsSongErrorState(this.errorMessage);
}