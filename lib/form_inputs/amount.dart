import 'package:formz/formz.dart';

enum AmountValidationError { invalid }

class Amount extends FormzInput<String, AmountValidationError> {
  const Amount.pure() : super.pure('');
  const Amount.dirty([String amount = '']) : super.dirty(amount);

  static final RegExp _amountRegExp = RegExp(r'^\d+(\.\d{1,2})?$');

  @override
  AmountValidationError? validator(String value) {
    return _amountRegExp.hasMatch(value) ? null : AmountValidationError.invalid;
  }
}
