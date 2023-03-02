// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/pages/tabs/home/controller/home_controller.dart';

class TextInputSearch extends StatelessWidget {
  final Function(String) onChanged;

  final HomeController getController;
  final TextEditingController searchController;

  const TextInputSearch({
    super.key,
    required this.onChanged,
    required this.searchController,
    required this.getController,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchController,
      onChanged: onChanged,
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
        suffixIcon: searchController.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  searchController.clear();
                  getController.searchTitle.value = '';
                  FocusScope.of(context).unfocus();
                },
                icon: Icon(
                  Icons.close,
                  color: CustomColors.customContrastColor,
                  size: 21,
                ),
              )
            : null,
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
