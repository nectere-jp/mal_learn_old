import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class IconPicker extends StatefulWidget {
  const IconPicker({Key? key}) : super(key: key);

  @override
  createState() => IconPickerState();
}

class IconPickerState extends State<IconPicker> {
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
