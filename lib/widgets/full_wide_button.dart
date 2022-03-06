import 'package:flutter/material.dart';

class FullWideButton extends StatelessWidget {
  const FullWideButton({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
