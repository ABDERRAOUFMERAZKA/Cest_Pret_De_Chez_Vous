import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> firebaseSignIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return "OK";
  } catch (e) {
    return e.code;
  }
}

Future<String> firebaseSignUp(
    String email, String password, String displayName) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    var currentUser = await FirebaseAuth.instance.currentUser();
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = displayName;
    currentUser.updateProfile(userUpdateInfo);
    currentUser.sendEmailVerification();
    Firestore()
        .collection("users")
        .document(currentUser.uid)
        .setData({"userId": currentUser.uid, "favorites": []});
    return 'OK';
  } catch (e) {
    return e.code;
  }
}

Future<String> firebaseSignOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    return "OK";
  } catch (e) {
    return e.code;
  }
}
