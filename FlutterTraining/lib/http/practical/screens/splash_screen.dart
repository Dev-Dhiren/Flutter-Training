import 'package:flutter/material.dart';
import 'package:flutter_training/http/practical/screens/home_screen.dart';
import 'package:flutter_training/http/practical/storage/secured_storage_service.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SecuredStorageService _storage = SecuredStorageService();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () async {
      var result = await _storage.getLoginStatus();

      if (result) {
        // navigate to home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        // navigate to login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset('assets/images/logo.png', width: 150),
            const SizedBox(height: 20),
            // App Name
            const Text(
              'Flutter Application',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
