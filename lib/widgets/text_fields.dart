import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class EmailField extends StatelessWidget {
  const EmailField({required this.controller, Key? key}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(labelText: 'メールアドレス'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: emailValidator,
    );
  }

  String? emailValidator(String? value) {
    if (value == null) {
      return 'メールアドレスを入力してください';
    } else if (EmailValidator.validate(value) != true) {
      return 'メールアドレスを正しい形式で入力してください';
    } else {
      return null;
    }
  }
}

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

    if (value == null) {
      return 'パスワードを入力してください';
    } else if (value.length < 6){
      return '6文字以上入力してください。';
    }  else {
      return null;
    }
  }
}
