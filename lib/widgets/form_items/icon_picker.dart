import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';

final newIconPathProvider = StateProvider((ref) => '');

class IconPicker extends ConsumerStatefulWidget {
  const IconPicker({Key? key}) : super(key: key);

  @override
  createState() => IconPickerState();
}

class IconPickerState extends ConsumerState<IconPicker> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return PictureField(
      builder: myBuilder,
      validator: _iconPickerValidator,
    );
  }

  Widget myBuilder(FormFieldState<String> state) {
    String _imagePath = ref.watch(newIconPathProvider);
    return Column(
      children: [
        _imagePath != ''
            ? _buttonWithSelectedImage(_imagePath, state)
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
    String? message;
    if (value == null) {
      message = 'アイコン画像を選択してください';
    }

    setState(() {
      _errorText = message;
    });
    return message;
  }

  void _selectImage(FormFieldState<String> state) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      String path = result.files.single.path!;

      state.didChange(path);
      ref.read(newIconPathProvider.notifier).state = path;
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
