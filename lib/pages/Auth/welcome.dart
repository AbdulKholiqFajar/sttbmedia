import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_apps/bloc/Authentication/bloc/login_bloc.dart';
import 'package:social_media_apps/home.dart';
import 'package:social_media_apps/pages/Auth/auth.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginInitial) {
          return const AuthScreen();
        } else if (state is LoginLoading) {
          return const LoadingScreen();
        } else if (state is LoginSuccess) {
          return HomePage();
        } else if (state is LoginFailure) {
          return ResponError(messageError: state.error);
        } else {
          return Container();
        }
      },
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class ResponError extends StatelessWidget {
  final String? messageError;
  const ResponError({super.key, this.messageError});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(messageError!, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            TextButton(
                onPressed: () {
                  context.read<LoginBloc>().add(InitLogin());
                },
                child: const Text("Ulangi"))
          ],
        ),
      ),
    );
  }
}
