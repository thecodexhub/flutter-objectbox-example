part of 'expense_form_bloc.dart';

abstract class ExpenseFormEvent extends Equatable {
  const ExpenseFormEvent();

  @override
  List<Object> get props => [];
}

class InitExpenseForm extends ExpenseFormEvent {}

class AmountChanged extends ExpenseFormEvent {
  const AmountChanged(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

class NoteChanged extends ExpenseFormEvent {
  const NoteChanged(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

class ExpenseTypeChanged extends ExpenseFormEvent {
  const ExpenseTypeChanged(this.selectedIndex);
  final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];
}

class ExpenseFormSubmitted extends ExpenseFormEvent {}
