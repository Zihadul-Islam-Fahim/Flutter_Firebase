import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_learning/firebase_options.dart';
import 'package:firebase_learning/match_list.dart';
import 'package:flutter/material.dart';



Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const MatchList(),
    );
  }
}


