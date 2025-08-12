import 'package:flutter/material.dart';
import 'package:project_iti_2025/core/utils/firebase_options.dart';
import 'package:project_iti_2025/my_app.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((_) => runApp(const MyApp()));
}
