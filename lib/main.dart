import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pv239_qwiz/common/widget/app_root.dart';
import 'package:pv239_qwiz/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // IoCContainer.initialize();

  runApp(const AppRoot());
}
