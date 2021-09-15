// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

// class UserRepository with ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   late final User _user;
//   Status _status = Status.Uninitialized;

//   UserRepository.instance() : _auth = FirebaseAuth.instance {
//     _auth.authStateChanges().listen(_onAuthStateChanged);
//   }

//   Status get status => _status;
//   User get user => _user;

//   Future<bool> signIn(String email, String password) async {
//     try {
//       _status = Status.Authenticating;
//       notifyListeners();
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return true;
//     } catch (e) {
//       _status = Status.Unauthenticated;
//       notifyListeners();
//       return false;
//     }
//   }

//   Future<bool> signInAnonymously() async {
//     try {
//       _auth.signInAnonymously().then((result) {
//         _user = result.user!;
//         notifyListeners();
//       });
//       return true;
//     } catch (e) {
//       _status = Status.Unauthenticated;
//       notifyListeners();
//       return false;
//     }
//   }

//   Future signOut() async {
//     _auth.signOut();
//     _status = Status.Unauthenticated;
//     notifyListeners();
//     return Future.delayed(Duration.zero);
//   }

//   Future<void> _onAuthStateChanged(User? firebaseUser) async {
//     if (firebaseUser == null) {
//       _status = Status.Unauthenticated;
//     } else {
//       _user = firebaseUser;
//       _status = Status.Authenticated;
//     }
//     notifyListeners();
//   }
// }
