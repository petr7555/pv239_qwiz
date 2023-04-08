import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pv239_qwiz/common/service/ioc_container.dart';
import 'package:pv239_qwiz/common/widget/app_root.dart';
import 'package:pv239_qwiz/firebase_options.dart';

late final FirebaseApp app;
late final FirebaseAuth auth;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  app = await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  auth = FirebaseAuth.instanceFor(app: app);

  IoCContainer.initialize();

  runApp(AppRoot());
}
