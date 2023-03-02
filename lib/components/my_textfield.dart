import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final controller;
  final String hintText;
  final bool obsecureText;
  final Icon icon;
  final FormFieldValidator<String> validator;

   MyTextField({super.key,
    required this.controller,
    required this.hintText,
    required this.obsecureText,
    required this.icon,
     required this.validator
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlignVertical: TextAlignVertical.center,
        validator: widget.validator,
        obscureText: widget.obsecureText,
        controller: widget.controller,
        decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: widget.icon,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Colors.white,
                )),
            focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(16)
            ),
            fillColor: Colors.grey[100],
            filled: true),

      ),
    );
  }
}
