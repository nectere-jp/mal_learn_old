import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mal_learn/provider.dart';

class NameField extends StatelessWidget {
  const NameField({required this.controller, Key? key}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'ニックネーム'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: emailValidator,
    );
  }

  String? emailValidator(String? value) {
    if (value == null) {
      return 'ニックネームを入力してください';
    } else if (value.length > 30) {
      return 'ニックネームは30文字以下で設定してください';
    } else {
      return null;
    }
  }
}

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
    } else if (value.length < 6) {
      return '6文字以上入力してください。';
    } else {
      return null;
    }
  }
}

class IconPicker extends ConsumerStatefulWidget {
  const IconPicker({Key? key}) : super(key: key);

  @override
  createState() => IconPickerState();
}

class IconPickerState extends ConsumerState<IconPicker> {
  @override
  Widget build(BuildContext context) {
    final String? imagePath = ref.watch(selectedIconPathProvider);
    return imagePath != null
        ? buttonWithSelectedImage(imagePath)
        : defaultButton();
  }

  Widget defaultButton() {
    return MaterialButton(
      onPressed: () => _onSelectImage(),
      child: const Icon(Icons.person, size: 60),
      height: 100,
      color: Colors.blueGrey,
      textColor: Colors.orange,
      shape: const CircleBorder(),
    );
  }

  MaterialButton buttonWithSelectedImage(String imagePath) {
    return MaterialButton(
      onPressed: () => _onSelectImage(),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
          shape: BoxShape.circle,
        ),
      ),
      shape: const CircleBorder(),
    );
  }

  void _onSelectImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result == null) {
      return;
    }

    ref.read(selectedIconPathProvider.notifier).state =
        result.files.single.path!;
  }
}
