import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/configs/usecases/usecase.dart';
import 'package:spotify_clone/features/auth/data/models/signin_user_req.dart';
import 'package:spotify_clone/features/auth/data/sources/auth_firebase_service.dart';
import 'package:spotify_clone/service_locator.dart';

class SighinUsecase extends UseCase<Either<dynamic, dynamic>, SigninUserReq> {
  final AuthFirebaseService authFirebaseService = sl<AuthFirebaseService>();

  @override
  Future<Either<dynamic, dynamic>> call({SigninUserReq? params}) async {
    // handle null if needed
    if (params == null) {
      return const Left("Missing params");
    }
    return await authFirebaseService.signIn(params);
  }
}
