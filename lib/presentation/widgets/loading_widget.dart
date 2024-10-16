import 'package:flutter/material.dart';
import 'package:weather/core/constants/images.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 90,
        width: 90,
        child: Image.asset(UIImages.compass),
      ),
    );
  }
}
