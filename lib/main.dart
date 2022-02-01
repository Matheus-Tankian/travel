import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel/screens/home_page/home.dart';
import 'package:travel/screens/initial_page/initial.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel.com',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      // home: const InitialPage(), flutter_native_splash 2.0.0 usar esse
      home: InitialPage(),
      //home: HomePage(),
    );
  }
}
