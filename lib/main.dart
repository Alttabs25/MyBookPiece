import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Using Web configuration keys to run on Mobile/Web
  await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: "AIzaSyC5KX7Kth...",            // Copy from 'apiKey' in screenshot
    appId: "1:967772621083:web:dfa...",     // Copy from 'appId' in screenshot
    messagingSenderId: "967772621083",      // Copy from 'messagingSenderId'
    projectId: "mybindpiece",               // Copy from 'projectId'
    authDomain: "mybindpiece.firebaseapp.com",
    storageBucket: "mybindpiece.firebasestorage.app", // Note: use .app as seen in your image
  ),
);
  
  runApp(const MyBookPiece());
}

class MyBookPiece extends StatelessWidget {
  const MyBookPiece({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyBookPiece',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const SplashScreen(),
    );
  }
}