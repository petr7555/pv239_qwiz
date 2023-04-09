import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pv239_qwiz/auth/model/auth_user.dart';
import 'package:pv239_qwiz/main.dart';

const mockAuth = true;
const mockedUser = AuthUser(
  uid: 'user123',
  displayName: 'John Doe',
  email: 'john@gmail.com',
);

class AuthCubit extends Cubit<AuthUser?> {
  AuthCubit() : super(mockAuth ? mockedUser : null) {
    if (mockAuth) {
      return;
    }

    auth.authStateChanges().listen((user) {
      if (user == null) {
        emit(null);
        return;
      }

      emit(AuthUser(
        uid: user.uid,
        displayName: user.displayName,
        email: user.email,
        photoURL: user.photoURL,
      ));
    });
  }

  String get userId {
    final uid = state?.uid;
    if (uid == null) {
      throw Exception('User is not signed in');
    }
    return uid;
  }

  bool isSignedIn() {
    return state != null;
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() {
    return auth.signOut();
  }
}
