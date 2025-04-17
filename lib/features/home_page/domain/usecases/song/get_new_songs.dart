import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/configs/usecases/usecase.dart';
import 'package:spotify_clone/features/home_page/domain/repository/song/song.dart';
import 'package:spotify_clone/service_locator.dart';

class GetNewSongsUseCase implements UseCase<Either,dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongsRepository>().getNewsSongs();
  }
}