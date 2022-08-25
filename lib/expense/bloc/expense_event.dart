part of 'expense_bloc.dart';

abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object> get props => [];
}

class ExpenseListRequested extends ExpenseEvent {}

class ExpenseListSortByTimeRequested extends ExpenseEvent {}

class ExpenseListSortByAmountRequested extends ExpenseEvent {}

class ToggleExpenseSort extends ExpenseEvent {}

class ExpenseInLast7DaysRequested extends ExpenseEvent {}

class ExpenseDeleted extends ExpenseEvent {
  const ExpenseDeleted(this.id);
  final int id;

  @override
  List<Object> get props => [id];
}
