import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pv239_qwiz/auth/model/auth_user.dart';
import 'package:pv239_qwiz/main.dart';

bool mockAuth = true;
AuthUser mockedUser = AuthUser(uid: '123', displayName: 'John Doe', email: 'john@gmail.com');

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

  String get userId => state!.uid;

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
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
