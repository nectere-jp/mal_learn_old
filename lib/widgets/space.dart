import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  const Space({required this.height, Key? key}) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
