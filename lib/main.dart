import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_learning/firebase_messaging_service.dart';
import 'package:firebase_learning/firebase_options.dart';
import 'package:firebase_learning/student_details.dart';
import 'package:flutter/material.dart';



Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
await FirebaseMessagingService().initialise();
await FirebaseMessagingService().getFCMToken();
await FirebaseMessagingService().subscribeToTopic('The-New-Saudi');
await FirebaseMessagingService().onRefresh((token) {
  //TODO - send to API
});
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StudentDetails(),
    );
  }
}


