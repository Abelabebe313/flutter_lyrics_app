import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lyrics_app/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  enableDatabasePersistence();
  runApp(const MyApp());
}

void enableDatabasePersistence() {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  database.setPersistenceEnabled(true);
  FirebaseDatabase.instance.setPersistenceEnabled(true);

  database.setPersistenceCacheSizeBytes(10000000); // 10MB
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lyrics App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}