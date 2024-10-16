import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.white.withOpacity(0.05),
      height: 40,
      thickness: 1.5,
    );
  }
}
