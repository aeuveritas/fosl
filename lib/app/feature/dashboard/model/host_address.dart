import 'package:formz/formz.dart';

enum HostAddressValidationError { empty, wrongFormat, notNumber }

class HostAddress extends FormzInput<String, HostAddressValidationError> {
  const HostAddress.pure() : super.pure('');
  const HostAddress.dirty([String value = '']) : super.dirty(value);

  @override
  HostAddressValidationError? validator(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty == true) {
      return HostAddressValidationError.empty;
    }

    final numbers = value.split('.');

    for (var val in numbers) {
      final intVal = int.tryParse(val);
      if (intVal == null) {
        return HostAddressValidationError.notNumber;
      }
    }

    if (numbers.length != 4) {
      return HostAddressValidationError.wrongFormat;
    }

    return null;
  }

  String get errorMessage {
    switch (error) {
      case HostAddressValidationError.empty:
        return "Empty";
      case HostAddressValidationError.wrongFormat:
        return "Wrong format";
      case HostAddressValidationError.notNumber:
        return "Only numbers are valid";
      default:
    }
    return "";
  }
}
