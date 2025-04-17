import 'package:dartz/dartz.dart';
import 'package:spotify_clone/features/auth/data/models/create_user_req.dart';
import 'package:spotify_clone/features/auth/data/models/signin_user_req.dart';

abstract class Authrepository {
  Future<Either> signInWithEmailAndPassword(SigninUserReq signInUserReq);
  Future<Either> signUpWithEmailAndPassword(CreateUserReq createUserReq);
}