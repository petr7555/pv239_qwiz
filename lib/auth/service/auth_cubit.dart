import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pv239_qwiz/main.dart';

class AuthCubit extends Cubit<User?> {
  AuthCubit() : super(null) {
    auth.authStateChanges().listen((user) {
      emit(user);
    });
  }

  bool isSignedIn() {
    return state != null;
  }

  Future<void> signInWithGoogle() async {
    await auth.signInWithProvider(GoogleAuthProvider());
  }

  // TODO remove
  Future<void> signInAnonymously() async {
    await auth.signInAnonymously();
  }

  Future<void> signInWithEmail() async {
    await auth.signInWithEmailAndPassword(email: 'demo@example.com', password: 'password');
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
