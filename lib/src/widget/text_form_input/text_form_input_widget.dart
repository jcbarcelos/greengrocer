// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class TextFormInputWidget extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType keyboardType;
  late bool secret;
  final Icon icon;
  final String nameField;
  final String? initialValue;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormats;
  final String? Function(String?)? validator;
  final String? Function(String?)? onchange;
  final GlobalKey<FormFieldState>? formFieldkey;

  // ignore: prefer_const_constructors_in_immutables
  TextFormInputWidget({
    Key? key,
    this.controller,
    required this.keyboardType,
    this.secret = false,
    required this.icon,
    required this.nameField,
    this.inputFormats,
    this.initialValue,
    this.validator,
    this.onchange,
    this.readOnly = false,
    this.formFieldkey,
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
      child: StatefulBuilder(
        builder: (context, setState) {
          return TextFormField(
            key: widget.formFieldkey,
            readOnly: widget.readOnly,
            initialValue:
                widget.initialValue == null || widget.controller == null
                    ? widget.initialValue
                    : widget.initialValue,
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
            validator: widget.validator,
            onChanged: widget.onchange,
          );
        },
      ),
    );
  }
}
