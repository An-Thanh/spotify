import 'package:dartz/dartz.dart';
import 'package:spotify_clone/features/auth/data/models/create_user_req.dart';
import 'package:spotify_clone/features/auth/data/models/signin_user_req.dart';
import 'package:spotify_clone/features/auth/data/sources/auth_firebase_service.dart';
import 'package:spotify_clone/features/auth/domain/repository/authRepository.dart';
import 'package:spotify_clone/service_locator.dart';

class AuthRepositoryImpl extends Authrepository {
  @override
  Future<Either> signInWithEmailAndPassword(SigninUserReq signInUserReq) async {
    return await sl<AuthFirebaseService>().signIn(signInUserReq);
  }

  @override
  Future<Either> signUpWithEmailAndPassword(CreateUserReq createUserReq) async {
    return await sl<AuthFirebaseService>().signUp(createUserReq);
  }
}