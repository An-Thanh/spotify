import 'package:get_it/get_it.dart';
import 'package:spotify_clone/features/auth/data/repository/auth_repository_impl.dart';
import 'package:spotify_clone/features/auth/data/sources/auth_firebase_service.dart';
import 'package:spotify_clone/features/auth/domain/repository/authRepository.dart';
import 'package:spotify_clone/features/auth/domain/usecases/signin_usecase.dart';
import 'package:spotify_clone/features/auth/domain/usecases/signup_usecase.dart';
import 'package:spotify_clone/features/home_page/data/repository/song/song.dart';
import 'package:spotify_clone/features/home_page/data/sources/song/song.dart';
import 'package:spotify_clone/features/home_page/domain/repository/song/song.dart';
import 'package:spotify_clone/features/home_page/domain/usecases/song/get_new_songs.dart';
import 'package:spotify_clone/features/home_page/domain/usecases/song/get_play_list.dart';

GetIt sl=GetIt.instance;

Future<void> initializeDependencies() async {
  // Services
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());

  // Repositories
  sl.registerSingleton<Authrepository>(AuthRepositoryImpl());
  sl.registerSingleton<SongsRepository>(SongsRepositoryImpl());


  // Use Cases
  sl.registerSingleton<SighupUsecase>(SighupUsecase());
  sl.registerSingleton<SighinUsecase>(SighinUsecase());
  sl.registerSingleton<GetNewSongsUseCase>(GetNewSongsUseCase());
  sl.registerSingleton<GetPlayListUseCase>(GetPlayListUseCase());
}