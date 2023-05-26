import 'package:dio/dio.dart';
import 'package:exopets/common/config/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));
  bool isPasswordVisible = false;

  Future<String?> signUp(
    String name,
    String email,
    String password,
    String phone,
  ) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final response = await _dio.post('/users/register', data: {
        "uid": userCredential.user!.uid,
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "address": null,
        "profile_picture": null
      });
      if (response.statusCode == 201) {
        signIn(email, password);
        return null;
      } else {
        return 'Something went wrong.';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return 'Something went wrong.';
      }
    }
  }

  togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  Future<String?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final response = await _dio.post('/users/login', data: {
        "uid": userCredential.user!.uid,
      });
      if (response.statusCode == 200) {
        return null;
      } else {
        return 'Something went wrong.';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return 'Something went wrong.';
      }
    }
  }

  forgotPassword(String email) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }

  Future<String?> adminLogin(String email, String password) async {
    try {
      final response = await _dio.post('/admins/login', data: {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 200) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return null;
      } else {
        return 'Something went wrong.';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return 'Something went wrong.';
      }
    }
  }
}
