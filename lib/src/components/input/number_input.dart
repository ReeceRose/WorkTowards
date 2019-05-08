import 'package:flutter/material.dart';

class NumberInput extends StatelessWidget {
  String label;
  String hint;
  TextEditingController controller;

  NumberInput({this.label, this.hint, this.controller});

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
      keyboardType: TextInputType.number,
    );
  }
}
