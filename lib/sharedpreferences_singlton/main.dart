import 'package:flutter/material.dart';
import 'package:flutter_training/sharedpreferences_singlton/preferences/pref_manager.dart';
import 'package:flutter_training/sharedpreferences_singlton/screens/form_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefManager().init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: FormScreen(),
    );
  }
}
