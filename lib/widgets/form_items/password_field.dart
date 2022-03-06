import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({required this.controller, Key? key}) : super(key: key);

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: const InputDecoration(labelText: 'パスワード'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: passwordValidator,
    );
  }

  String? passwordValidator(String? value) {
    // TODO: flutter_pw_validatorを使用

    if (value == null || value.isEmpty) {
      return 'パスワードを入力してください';
    } else if (value.length < 6) {
      return '6文字以上入力してください。';
    } else {
      return null;
    }
  }
}