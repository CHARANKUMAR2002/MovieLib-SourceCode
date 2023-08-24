import 'package:flutter/material.dart';
import 'mainScreen.dart';
import 'package:firebase_core/firebase_core.dart';

  
void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCwMjcE36UNOdRahgdK7VMsapIVFp8Wohk",
      appId: "1:756611738858:web:73fa41c07892e33346fb93", 
      messagingSenderId: "756611738858", 
      projectId: "moviestreaming-c4563"
      ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(brightness:Brightness.light, scaffoldBackgroundColor: Colors.white, useMaterial3: true),
      darkTheme: ThemeData(brightness: Brightness.dark, scaffoldBackgroundColor: Colors.black, useMaterial3: true),
      home: const MainScreen(),
    );
  }
}