import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone/database/local_db/database_helper.dart';
import 'package:spotify_clone/features/auth/data/models/create_user_req.dart';
import 'package:spotify_clone/features/auth/data/models/signin_user_req.dart';

abstract class AuthFirebaseService {
  Future<Either> signIn(SigninUserReq signInUserReq);
  Future<Either> signUp(CreateUserReq createUserReq);
}

class AuthFirebaseServiceImpl implements AuthFirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<Either> signIn(SigninUserReq signInUserReq) async {
    try { 
      var result = await _firebaseAuth.signInWithEmailAndPassword(
        email: signInUserReq.email, 
        password: signInUserReq.password
      );

      var userSignin = result.user;
      String uid = "";
      if (userSignin != null) {
        uid = userSignin.uid;
        print("User ID: $uid");        
      } else {
        print("Đăng nhập thất bại");
      }

      // Check if the user exists in Firestore
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(signInUserReq.email).get();
      if (!userDoc.exists) {
        return const Left('User not found in Firestore');
      }

      // User exists, proceed with sign-in
      CreateUserReq user = CreateUserReq(
        email: signInUserReq.email,
        password: signInUserReq.password,
        fullName: userDoc['name'] // Assuming 'name' is the field in Firestore
      );

      final db = await DatabaseHelper().database;

      List<Map<String, dynamic>> existingUsers = await db.query(
        'User',
        where: 'id = ? OR email = ?',
        whereArgs: [uid, signInUserReq.email],
      );

      if (existingUsers.isEmpty) {
        // B3: Nếu chưa có thì thêm vào DB
        await db.insert('User', {
          'id': uid,
          'email': signInUserReq.email,
          'full_name': userDoc['name'],
          'url_avatar': '',
        });
        print("Đã thêm user mới vào database.");
      } else {
        print("User đã tồn tại trong database.");
      }


      return Right("Signin was Successful, Welcome ${user.fullName}"); // Return success
    } catch (e) {
      // Handle error and return failure
      if (e is FirebaseAuthException) {
        switch (e.code.toString().toLowerCase()) {
          case 'user-not-found':
            return const Left('User not found');
          case 'wrong-password':
            return const Left('Wrong password');
          case 'invalid-email':
            return const Left('Invalid email address');
          default:
            return Left(e.code.toString().toLowerCase());
        }
      }
      return const Left('An unknown error occurred');
    }
  }

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    try { 
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: createUserReq.email, 
        password: createUserReq.password
      );

      // Save user data to Firestore
      await _firestore.collection('users').doc(createUserReq.email).set({
        'email': createUserReq.email,
        'name': createUserReq.fullName,
      });
    
      return const Right("Signup was Successful"); // Return success
    } catch (e) {
      // Handle error and return failure
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            return const Left('Email already in use');
          case 'weak-password':
            return const Left('Weak password');
          case 'invalid-email':
            return const Left('Invalid email address');
          default:
            return const Left('An unknown error occurred');
        }
      }
      return const Left('An unknown error occurred');
    }
  }
}