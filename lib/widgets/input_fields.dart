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

    if (value == null || value.isEmpty) {
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

class BirthDayField extends StatefulWidget {
  const BirthDayField({Key? key}) : super(key: key);

  @override
  createState() => BirthDayFieldState();
}

class BirthDayFieldState extends State<BirthDayField> {
  final _controller = TextEditingController();
  String? _errorText;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DateField(
      builder: myBuilder,
      validator: birthDayValidator,
    );
  }

  Widget myBuilder(FormFieldState<DateTime> state) {
    return TextField(
      controller: _controller,
      readOnly: true,
      onTap: () => _selectDate(),
      decoration: InputDecoration(labelText: '生年月日', errorText: _errorText),
    );
  }

  String? birthDayValidator(DateTime? value) {
    if (value == null) {
      String _message = '誕生日を入力してください';
      setState(() {
        _errorText = _message;
      });
      return _message;
    }
    return null;
  }

  void _selectDate() async {
    final DateTime? birthDay = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: DateTime(DateTime.now().year - 16),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (birthDay != null) {
      _controller.value = _controller.value.copyWith(
        text: '${birthDay.year}年${birthDay.month}月${birthDay.day}日',
      );
    }

    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}

@immutable
class DateField extends FormField<DateTime> {
  const DateField({
    Key? key,
    FormFieldValidator<DateTime>? validator,
    required Widget Function(FormFieldState<DateTime>) builder,
  }) : super(
          key: key,
          validator: validator,
          builder: builder,
        );
}
