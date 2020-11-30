import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:restaurant/controllers/authController.dart';
import 'package:restaurant/models/userModel.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  var user = Get.find<AuthController>().user;

  // sing Up with email and password
  Future<bool> signUpWithEmailAndPassword(
      UserModel userModel, String password) async {
    try {
      var response = await _firebaseAuth.createUserWithEmailAndPassword(
          email: userModel.email, password: password);
      if (response.user != null) {
        await createUser(userModel.toJson(), response.user.uid);
        return true;
      } else
        return false;
    } catch (e) {
      print(e.message);
      Get.snackbar("Error creating acconut ", e.message);
      return false;
    }
  }

  // sign in with email and password
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      var response = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (response.user != null) {
        return true;
      } else
        return false;
    } catch (e) {
      print(e.message);
      Get.snackbar("Error Sign in ", e.message);
      return false;
    }
  }

  // create user in firestore
  Future createUser(Map<String, dynamic> userData, String uid) async {
    DocumentReference reference = instance.collection("Users").doc(uid);
    DocumentSnapshot data = await reference.get();
    if (!data.exists) {
      reference.set(userData);
    }
  }

  Future updateUser(UserModel userModel) async {
    await instance.collection("Users").doc(user.uid).update(userModel.toJson());
  }

  Stream<UserModel> streamUser() {
    return instance
        .collection("Users")
        .doc(user.uid)
        .snapshots()
        .map((details) {
      if (details.exists) {
        return UserModel.fromDocumentSnapshot(details);
      } else
        return null;
    });
  }

  void signOut() async {
    await _firebaseAuth.signOut();
    Get.reset();
    Get.put(AuthController());
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    if (googleSignInAuthentication != null) {
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      var response = await _firebaseAuth.signInWithCredential(authCredential);
      if (response.user != null) {
        UserModel userModel = UserModel(
          firstName: response.user.displayName,
          lastName: response.user.displayName,
          email: response.user.email,
          phoneNumber: response.user.phoneNumber,
          profilePicture: response.user.photoURL,
        );
        createUser(userModel.toJson(), response.user.uid);
      }
    }
  }
}
