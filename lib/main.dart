import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_media_apps/bloc/Authentication/bloc/login_bloc.dart';
import 'package:social_media_apps/bloc/Authentication/bloc/register_bloc.dart';
import 'package:social_media_apps/bloc/Post/bloc/post_bloc.dart';
import 'package:social_media_apps/repository/auth_repository.dart';
import 'package:social_media_apps/pages/Auth/welcome.dart';

import 'dart:async';

import 'package:social_media_apps/repository/post_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => AuthRepository()),
          RepositoryProvider(create: (context) => PostRepository()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LoginBloc(loginRepository: context.read<AuthRepository>())..add(InitLogin()),
            ),
            BlocProvider(create: (context) => RegisterBloc(repository: context.read<AuthRepository>())),
            BlocProvider(create: (context) => PostBloc(repository: context.read<PostRepository>())),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          ),
        ));
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(InitLogin());
    Timer(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Welcome(),
          ),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/splash_screen.png', fit: BoxFit.fill),
      ),
    );
  }
}
