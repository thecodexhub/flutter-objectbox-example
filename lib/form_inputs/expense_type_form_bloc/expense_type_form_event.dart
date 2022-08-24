part of 'expense_type_form_bloc.dart';

abstract class ExpenseTypeFormEvent extends Equatable {
  const ExpenseTypeFormEvent();

  @override
  List<Object> get props => [];
}

class IdentifierChanged extends ExpenseTypeFormEvent {
  const IdentifierChanged(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

class NameChanged extends ExpenseTypeFormEvent {
  const NameChanged(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

class ExpenseTypeFormSubmitted extends ExpenseTypeFormEvent {}
