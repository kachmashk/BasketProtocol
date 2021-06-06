import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:basketprotocol/core/models/service_response.dart';

import 'package:basketprotocol/core/repositories/user_repository.dart';

class AuthService {
  Future<ServiceResponse<User>> signInAnon() async {
    try {
      User user = (await FirebaseAuth.instance.signInAnonymously()).user!;

      bool _doesUserExists = await UserRepository.doesUserExists(user.uid);

      if (!_doesUserExists) {
        await UserRepository.createUserDocument(user);
      }

      return ServiceResponse(response: user);
    } catch (error) {
      return ServiceResponse(errorMessage: error.toString());
    }
  }

  Future<ServiceResponse<User>> signUpWithCredentials(
      String email, String password) async {
    try {
      User user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password))
          .user!;

      bool _doesUserExists = await UserRepository.doesUserExists(user.uid);

      if (!_doesUserExists) {
        await UserRepository.createUserDocument(user);
      }

      verifyUserEmail(user);

      return ServiceResponse(response: user);
    } catch (error) {
      return ServiceResponse(errorMessage: error.toString());
    }
  }

  Future<ServiceResponse<User>> signInWithCredentials(
      String email, String password) async {
    try {
      User user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user!;

      bool _doesUserExists = await UserRepository.doesUserExists(user.uid);

      if (!_doesUserExists) {
        await UserRepository.createUserDocument(user);
      }

      return ServiceResponse(response: user);
    } catch (error) {
      return ServiceResponse(errorMessage: error.toString());
    }
  }

  Future<ServiceResponse<User>> signWithGoogle() async {
    try {
      GoogleSignInAccount googleAccount = (await GoogleSignIn().signIn())!;

      GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;

      AuthCredential credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      User user =
          (await FirebaseAuth.instance.signInWithCredential(credentials)).user!;

      bool _doesUserExists = await UserRepository.doesUserExists(user.uid);

      if (!_doesUserExists) {
        await UserRepository.createUserDocument(user);
      }

      return ServiceResponse(response: user);
    } catch (error) {
      return ServiceResponse(errorMessage: error.toString());
    }
  }

  // Future<void> updateUserName(User user, String _name) async {
  //   try {
  //     Update userUpdateInfo = UserUpdateInfo();

  //     userUpdateInfo.displayName = _name;

  //     user.updateProfile(userUpdateInfo);
  //     await user.reload();
  //   } catch (error) {
  //     throw Exception(error);
  //   }
  // }

  // Future<void> updateUserEmail(User user, String email) async {
  //   try {
  //     UserRepository.updateUserEmail(user, email);

  //     user.updateEmail(email);

  //     await user.reload();
  //   } catch (error) {
  //     throw Exception(error);
  //   }
  // }

  Future<ServiceResponse<bool>> verifyUserEmail(User user) async {
    try {
      await user.sendEmailVerification();

      return ServiceResponse(response: true);
    } catch (error) {
      return ServiceResponse(errorMessage: error.toString());
    }
  }

  Future<ServiceResponse<bool>> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      return ServiceResponse(response: true);
    } catch (error) {
      return ServiceResponse(errorMessage: error.toString());
    }
  }

  Future<ServiceResponse<bool>> deleteAccount(User user) async {
    try {
      await UserRepository.deleteUserDocument(user.uid);

      await user.delete();

      return ServiceResponse(response: true);
    } catch (error) {
      return ServiceResponse(errorMessage: error.toString());
    }
  }

  Future<ServiceResponse<bool>> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();

      return ServiceResponse(response: true);
    } catch (error) {
      return ServiceResponse(errorMessage: error.toString());
    }
  }
}
