import 'package:etaxi/cubits/signup/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/repositories.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignupScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signup')),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: BlocProvider<SignupCubit>(
          create: (_) => SignupCubit(context.read<AuthRepository>()),
          child: SignupForm(),
        ),
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state.status == SignupStatus.error) {}
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _EmailInput(),
          const SizedBox(height: 8),
          _PasswordInput(),
          const SizedBox(height: 8),
          _SignupButton(),
          const SizedBox(height: 8),
          _SignupButton(),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) {
            context.read<SignupCubit>().emailChanged(email);
          },
          decoration: const InputDecoration(labelText: 'Email'),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          obscureText: true,
          onChanged: (password) {
            context.read<SignupCubit>().passwordChanged(password);
          },
          decoration: const InputDecoration(labelText: 'Password'),
        );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == SignupStatus.submitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 40),
                ),
                onPressed: () {
                  context.read<SignupCubit>().SignUpFormSubmitted();
                },
                child: const Text(
                  'SIGN UP',
                  style: TextStyle(color: Colors.white),
                ),
              );
      },
    );
  }
}
