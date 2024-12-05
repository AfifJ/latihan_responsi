import 'package:flutter/material.dart';
import 'package:latihan_responsi/screens/home_page.dart';
import 'package:latihan_responsi/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();

    print('///// LOGIN ' + _isLoggedIn.toString());
  }

  Future<void> _checkLoginStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      setState(() {
        _isLoggedIn = (prefs.getString('userId') ?? '').isNotEmpty;
        _isLoading = false; // Corrected assignment
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isLoggedIn = false;
      });
      print('Error check login');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return _isLoggedIn ? HomePage() : LoginPage();
  }
}
