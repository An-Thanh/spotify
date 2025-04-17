import 'package:dartz/dartz.dart';
import 'package:spotify_clone/features/home_page/data/sources/song/song.dart';
import 'package:spotify_clone/features/home_page/domain/repository/song/song.dart';
import 'package:spotify_clone/service_locator.dart';

class SongsRepositoryImpl implements SongsRepository {
  @override
  Future<Either> getNewsSongs() async {
    return await sl<SongFirebaseService>().getNewsSongs();
  }

  @override
  Future<Either> getPlayList() async {
    return await sl<SongFirebaseService>().getPlayList();
  }
  
}