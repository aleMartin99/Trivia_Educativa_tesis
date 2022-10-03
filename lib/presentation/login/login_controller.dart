import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/repositories/login_repository.dart';
import 'package:trivia_educativa/data/models/user_model.dart';
import 'login_state.dart';

//TODO separate controllers

class LoginController {
  final ValueNotifier<LoginState> stateNotifier =
      ValueNotifier<LoginState>(LoginState.empty);
  set state(LoginState state) => stateNotifier.value = state;
  LoginState get state => stateNotifier.value;

  List<User>? users;

  final repository = LoginRepository();

  Future getUser() async {
    state = LoginState.loading;

    final response = (await repository.getUsers());
    if (response.isRight()) {
      users = ((response as Right).value as List<User>).cast<User>();
      state = LoginState.success;
      return users;
    } else {
      state = LoginState.error;
    }
  }
}






//TODO make the logic for authentication and move to controller out of presentation 



// import 'dart:developer';

// import 'package:educational_quiz_app/view/login/authentication.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class LoginController {
//   final ValueNotifier<bool> loadingNotifier = ValueNotifier<bool>(false);
//   bool get isLoading => loadingNotifier.value;
//   set isLoading(bool value) => loadingNotifier.value = value;

//   final ValueNotifier<bool> loginNotifier = ValueNotifier<bool>(false);
//   bool get isLoggedIn => loginNotifier.value;
//   set isLoggedIn(bool value) => loginNotifier.value = value;

//   String? name;
//   String? profileUrl;

//   Future<bool> signIn({required BuildContext context}) async {
//     isLoading = true;

//     try {
//       await Authentication.initializeFirebase();

//       User? user = await Authentication.signInWithGoogle(context);

//       if (user != null) {
//         name = user.displayName;
//         profileUrl = user.photoURL;
//       }

//       log("user name on authentication: ${user!.displayName}");

//       isLoggedIn = true;
//       isLoading = false;
//       return true;
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         Authentication.messageSnackBar(
//           message: "Um erro ocorreu. Tente novamente.",
//         ),
//       );
//     }

//     isLoading = false;
//     return false;
//   }

//   Future<bool> signOut({required BuildContext context}) async {
//     isLoading = true;

//     try {
//       Authentication.signOut(context: context);
//       name = null;
//       profileUrl = null;
//       isLoggedIn = false;
//       isLoading = false;
//       return true;
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         Authentication.messageSnackBar(
//           message: "Um erro ocorreu. Tente novamente.",
//         ),
//       );
//     }

//     isLoading = false;
//     return false;
//   }
// }
