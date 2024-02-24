import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hw4/controllers/auth_controller.dart';
import 'package:hw4/firebase_options.dart';
import 'package:hw4/pages/opening_page.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final stream = AuthController().loggedInStream;

    return MaterialApp(
        title: 'Todo',
        themeMode: ThemeMode.dark,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark().copyWith(
            brightness: Brightness.dark,
            primaryColor: const Color.fromARGB(255, 2, 5, 58)),
        home: StreamBuilder(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == true) {
                return const HomePage();
              }

              return const OpeningPage();
            }));
  }
}
