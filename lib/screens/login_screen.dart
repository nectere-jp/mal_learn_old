import 'package:flutter/material.dart';
import 'package:mal_learn/widgets/space.dart';
import 'package:mal_learn/widgets/text_fields.dart';
import 'package:mal_learn/widgets/full_wide_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext contxt) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: formInner(),
          ),
        ),
      ),
    );
  }

  Widget formInner() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('ログイン', style: Theme.of(context).textTheme.headline4),
        const Space(height: 16),
        EmailField(controller: _emailController),
        const Space(height: 16),
        PasswordField(controller: _passwordController),
        const Space(height: 16),
        FullWideButton(onPressed: () => _onSingIn(), text: 'ログイン'),
      ],
    );
  }

  Future<void> _onSingIn() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    print('sing in!');
  }
}
