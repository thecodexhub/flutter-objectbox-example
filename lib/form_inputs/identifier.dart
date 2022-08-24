import 'package:formz/formz.dart';

enum IdentifierValidationError { invalid }

class Identifier extends FormzInput<String, IdentifierValidationError> {
  const Identifier.pure() : super.pure('');
  const Identifier.dirty([String identifier = '']) : super.dirty(identifier);

  static final RegExp _identifierRegExp = RegExp(r'^.{1,5}$');

  @override
  IdentifierValidationError? validator(String value) {
    return _identifierRegExp.hasMatch(value)
        ? null
        : IdentifierValidationError.invalid;
  }
}
