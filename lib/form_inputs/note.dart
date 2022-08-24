import 'package:formz/formz.dart';

enum NoteValidationError { invalid }

class Note extends FormzInput<String, NoteValidationError> {
  const Note.pure() : super.pure('');
  const Note.dirty([String note = '']) : super.dirty(note);

  static final RegExp _noteRegExp = RegExp(r'^.{1,20}$');

  @override
  NoteValidationError? validator(String value) {
    return _noteRegExp.hasMatch(value) ? null : NoteValidationError.invalid;
  }
}
