import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedBirthDayProvider = StateProvider<DateTime?>((ref) => null);

class BirthDayField extends ConsumerStatefulWidget {
  const BirthDayField({Key? key}) : super(key: key);

  @override
  createState() => BirthDayFieldState();
}

class BirthDayFieldState extends ConsumerState<BirthDayField> {
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
    String? _message;
    if (value == null) {
      _message = '誕生日を入力してください';
    }

    setState(() {
      _errorText = _message;
    });
    return _message;
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
      ref.watch(selectedBirthDayProvider.notifier).state = birthDay;
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
