import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  String label;
  String hint;
  TextEditingController controller;

  TextInput({this.label, this.hint, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(),
        ),
      ),
      textAlign: TextAlign.center,
      controller: controller,
      keyboardType: TextInputType.text,
    );
  }
}
