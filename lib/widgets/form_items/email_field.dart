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
