// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class TextFormInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  late bool secret;
  final Icon icon;
  final String nameField;
  final List<TextInputFormatter>? inputFormats;
  // ignore: prefer_const_constructors_in_immutables
  TextFormInputWidget({
    Key? key,
    required this.controller,
    required this.keyboardType,
    this.secret = false,
    required this.icon,
    required this.nameField,
    this.inputFormats,
  }) : super(key: key);
  @override
  State<TextFormInputWidget> createState() => _TextFormInputWidgetState();
}

class _TextFormInputWidgetState extends State<TextFormInputWidget> {
  bool obscureText = false;
  @override
  void initState() {
    super.initState();
    obscureText = widget.secret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: obscureText,
        inputFormatters: widget.inputFormats,
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: widget.icon,
          labelText: widget.nameField,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          suffixIcon: widget.secret
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                )
              : null,
        ),
        validator: (String? value) {
          return (value!.isEmpty)
              ? '${widget.nameField} not empty ${widget.controller}.'
              : null;
        },
      ),
    );
  }
}
