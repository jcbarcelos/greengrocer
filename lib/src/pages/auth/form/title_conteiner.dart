import 'package:flutter/material.dart';

class TitleContainer extends StatelessWidget {
  final String nameTitle;
  const TitleContainer({super.key, required this.nameTitle});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          nameTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 35,
          ),
        ),
      ),
    );
  }
}
