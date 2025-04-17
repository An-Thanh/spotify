import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/features/home_page/domain/usecases/song/get_new_songs.dart';
import 'package:spotify_clone/features/home_page/domain/usecases/song/get_play_list.dart';
import 'package:spotify_clone/features/home_page/presentations/bloc/play_list/play_list_state.dart';
import 'package:spotify_clone/service_locator.dart';

class PlayListCubit extends Cubit<PlayListState>{
  PlayListCubit() : super(const PlayListLoadingState()) ;

  void getPlayList() async {
    var returnedSongs = await sl<GetPlayListUseCase>().call();
    returnedSongs.fold(
      (error) => emit(PlayListErrorState(error.message)),
      (songs) => emit(PlayListLoadedState(songs)),
    );
  }
}