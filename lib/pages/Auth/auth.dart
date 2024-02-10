import 'package:flutter/material.dart';
import 'package:social_media_apps/pages/Auth/login.dart';
import 'package:social_media_apps/pages/Auth/register.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int selectedScreenIndex = 0;
  final List screens = [RegisterScreen(), LoginScreen()];

  void selectScreen(int index) {
    setState(() {
      selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Register',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
        ],
        currentIndex: selectedScreenIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          selectScreen(index);
        },
      ),
    );
  }
}
