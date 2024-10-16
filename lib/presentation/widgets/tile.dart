import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Tile extends StatelessWidget {
  final String leading;
  final String title;
  final String subTitle;

  const Tile({required this.leading, required this.title, required this.subTitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          leading,
          width: 45,
        ),
        const Gap(15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w200),
            ),
            Text(
              subTitle,
              style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        )
      ],
    );
  }
}
