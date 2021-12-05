import 'package:flutter/material.dart';
import 'package:sleep_sync/app/core/const/config.dart';

typedef OnChange = void Function(String);

class ModifiableTextField extends StatelessWidget {
  const ModifiableTextField({
    required this.key,
    required this.initialValue,
    required this.onChanged,
    this.errorText,
    this.readOnly = false,
  }) : super(key: key);

  final Key key;
  final String initialValue;
  final String? errorText;
  final OnChange onChanged;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      key: key,
      style: defaultTextStyle,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        errorText: errorText,
      ),
      onChanged: onChanged,
      readOnly: readOnly,
    );
  }
}
