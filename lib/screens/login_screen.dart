import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          } else if (state.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid credentials!')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return TextField(
                    onChanged: (value) =>
                        context.read<LoginBloc>().add(EmailChanged(value)),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: state.isEmailValid ? null : 'Invalid email',
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return TextField(
                    onChanged: (value) =>
                        context.read<LoginBloc>().add(PasswordChanged(value)),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText:
                      state.isPasswordValid ? null : 'Password too weak',
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.isSubmitting
                        ? null
                        : () {
                      context.read<LoginBloc>().add(LoginSubmitted());
                    },
                    child: const Text('Login'),
                  );
                },
              ),
              const SizedBox(height: 16),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state.isSubmitting) {
                    return const CircularProgressIndicator();
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
