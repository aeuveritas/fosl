import 'package:formz/formz.dart';

enum SyncIntervalValidationError { empty, notNumber, tooShort, tooLong }

class SyncInterval extends FormzInput<String, SyncIntervalValidationError> {
  const SyncInterval.pure() : super.pure('');
  const SyncInterval.dirty([String value = '']) : super.dirty(value);

  @override
  SyncIntervalValidationError? validator(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty == true) {
      return SyncIntervalValidationError.empty;
    }

    final intVal = int.tryParse(value);
    if (intVal == null) {
      return SyncIntervalValidationError.notNumber;
    }

    if (intVal < 1) {
      return SyncIntervalValidationError.tooShort;
    }

    if (intVal > 60) {
      return SyncIntervalValidationError.tooLong;
    }

    return null;
  }

  String get errorMessage {
    switch (error) {
      case SyncIntervalValidationError.empty:
        return "Empty";
      case SyncIntervalValidationError.notNumber:
        return "Only numbers are valid";
      case SyncIntervalValidationError.tooShort:
        return "Minimum interval is 1 min";
      case SyncIntervalValidationError.tooLong:
        return "Maximum interval is 60 min";
      default:
    }
    return "";
  }
}
