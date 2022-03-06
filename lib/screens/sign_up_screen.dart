import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:mal_learn/screens/chat_list_screen.dart';
import 'package:mal_learn/widgets/space.dart';
import 'package:mal_learn/widgets/form_items/birthday_field.dart';
import 'package:mal_learn/widgets/form_items/email_field.dart';
import 'package:mal_learn/widgets/form_items/icon_picker.dart';
import 'package:mal_learn/widgets/form_items/name_field.dart';
import 'package:mal_learn/widgets/form_items/password_field.dart';
import 'package:mal_learn/widgets/full_wide_button.dart';
import 'package:mal_learn/repositories/auth_repository.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignupScreen> {
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
        const IconPicker(),
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

      final String nickname = _nameController.text;
      final String email = _emailController.text;
      final String password = _passwordController.text;
      final String iconPath = ref.read(newIconPathProvider)!;
      final File icon = File(iconPath);
      final DateTime birthday = ref.read(selectedBirthDayProvider)!;

      await userRepository.addUser(
        nickname: nickname,
        email: email,
        password: password,
        icon: icon,
        birthday: birthday,
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const ChatListScreen(),
        ),
      );
    } catch (e) {
      //TODO: 中途半端なアカウントを消す
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
