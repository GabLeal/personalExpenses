import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget {

  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function(String) onSumitted;

  AdaptativeTextField({
    this.label,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onSumitted
  });
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
    ? Padding(
      padding: const EdgeInsets.only(
        bottom: 10
      ),
      child: CupertinoTextField(
        controller: controller,
        keyboardType: keyboardType,
        onSubmitted: onSumitted,
        placeholder: label,
        padding: EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 12
        ),
      ),
    )
    : TextField(
        controller: controller,
        keyboardType: keyboardType,
        onSubmitted: onSumitted,
        decoration: InputDecoration(
          labelText: label
        ),
    );
  }
}