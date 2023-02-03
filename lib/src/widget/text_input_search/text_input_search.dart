import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

class TextInputSearch extends StatelessWidget {
  const TextInputSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        hintText: 'Pesquise aqui...',
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 14,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: CustomColors.customContrastColor,
          size: 21,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}
