import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  const NameField({required this.controller, Key? key}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'ニックネーム'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: nameValidator,
    );
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'ニックネームを入力してください';
    } else if (value.length > 30) {
      return 'ニックネームは30文字以下で設定してください';
    } else {
      return null;
    }
  }
}
