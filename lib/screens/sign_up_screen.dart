import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mal_learn/screens/chat_list_screen.dart';
import 'package:mal_learn/widgets/space.dart';
import 'package:mal_learn/widgets/input_fields.dart';
import 'package:mal_learn/widgets/full_wide_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
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
        Text('新規登録', style: Theme.of(context).textTheme.headline4),
        const Space(height: 16),
        const IconPicker(), //TODO: コントローラーを使って制御
        const Space(height: 16),
        NameField(controller: _nameController),
        const Space(height: 16),
        EmailField(controller: _emailController),
        const Space(height: 16),
        PasswordField(controller: _passwordController),
        const Space(height: 16),
        const BirthDayField(),
        const Space(height: 16),
        FullWideButton(onPressed: () => _onSignUp(), text: 'ログイン'),
      ],
    );
  }

  Future<void> _onSignUp() async {
    try {
      if (_formKey.currentState?.validate() != true) {
        return;
      }

      final String email = _emailController.text;
      final String password = _passwordController.text;

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const ChatListScreen(),
        ),
      );
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('エラー'),
            content: Text(e.toString()),
          );
        },
      );
    }
  }
}
