import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({required this.controller, Key? key}) : super(key: key);

  final TextEditingController controller;

  @override
  TextField build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(labelText: 'メールアドレス'),
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({required this.controller, Key? key}) : super(key: key);

  final TextEditingController controller;
  @override
  TextField build(BuildContext context) {
    return const TextField();
  }
}
