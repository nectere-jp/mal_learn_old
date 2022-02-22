import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';

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
  String? _errorText;
  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    return PictureField(
      builder: myBuilder,
      validator: _iconPickerValidator,
    );
  }

  Widget myBuilder(FormFieldState<String> state) {
    return Column(
      children: [
        _imagePath != null
            ? _buttonWithSelectedImage(_imagePath!, state)
            : _defaultButton(state),
        Text(
          _errorText ?? '',
          style: TextStyle(color: Theme.of(context).errorColor),
        ),
      ],
    );
  }

  Widget _defaultButton(FormFieldState<String> state) {
    return MaterialButton(
      onPressed: () => _selectImage(state),
      child: const Icon(Icons.person, size: 60),
      height: 100,
      color: Colors.blueGrey,
      textColor: Colors.orange,
      shape: const CircleBorder(),
    );
  }

  MaterialButton _buttonWithSelectedImage(
      String imagePath, FormFieldState<String> state) {
    return MaterialButton(
      onPressed: () => _selectImage(state),
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

  String? _iconPickerValidator(String? value) {
    if (value == null) {
      String message = 'アイコン画像を選択してください';
      setState(() {
        _errorText = message;
      });
      return message;
    } else {
      setState(() {
        _errorText = null;
      });
      return null;
    }
  }

  void _selectImage(FormFieldState<String> state) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      String path = result.files.single.path!;

      state.didChange(path);
      setState(() {
        _imagePath = path;
      });
    }
  }
}

class PictureField extends FormField<String> {
  const PictureField({
    Key? key,
    FormFieldValidator<String>? validator,
    required Widget Function(FormFieldState<String>) builder,
  }) : super(
          key: key,
          validator: validator,
          builder: builder,
        );
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
      onTap: () => _selectDate(state),
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
    setState(() {
      _errorText = null;
    });
    return null;
  }

  void _selectDate(FormFieldState<DateTime> state) async {
    final DateTime? birthDay = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: DateTime(DateTime.now().year - 16),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (birthDay != null) {
      state.didChange(birthDay);
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
