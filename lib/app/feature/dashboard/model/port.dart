import 'package:formz/formz.dart';

enum PortValidationError { empty, notNumber, tooSmall, tooBig }

class Port extends FormzInput<String, PortValidationError> {
  const Port.pure() : super.pure('');
  const Port.dirty([String value = '']) : super.dirty(value);

  @override
  PortValidationError? validator(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty == true) {
      return PortValidationError.empty;
    }

    final intVal = int.tryParse(value);
    if (intVal == null) {
      return PortValidationError.notNumber;
    }

    if (intVal < 30000) {
      return PortValidationError.tooSmall;
    }

    if (intVal > 40000) {
      return PortValidationError.tooBig;
    }

    return null;
  }

  String get errorMessage {
    switch (error) {
      case PortValidationError.empty:
        return "Empty";
      case PortValidationError.notNumber:
        return "Only numbers are valid";
      case PortValidationError.tooSmall:
        return "Valid range is 30000 ~ 40000";
      case PortValidationError.tooBig:
        return "Valid range is 30000 ~ 40000";
      default:
    }
    return "";
  }
}
