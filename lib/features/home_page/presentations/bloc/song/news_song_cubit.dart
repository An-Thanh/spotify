import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/features/home_page/domain/usecases/song/get_new_songs.dart';
import 'package:spotify_clone/features/home_page/presentations/bloc/song/news_song_state.dart';
import 'package:spotify_clone/service_locator.dart';

class NewsSongCubit extends Cubit<NewsSongState> {
  NewsSongCubit() : super(const NewsSongLoadingState()) ;
  void getNewsSong() async {
    var returnedSongs = await sl<GetNewSongsUseCase>().call();
    returnedSongs.fold(
      (error) => emit(NewsSongErrorState(error.message)),
      (songs) => emit(NewsSongLoadedState(songs)),
    );
  }

}