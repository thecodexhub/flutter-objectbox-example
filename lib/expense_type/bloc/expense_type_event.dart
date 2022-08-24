part of 'expense_type_bloc.dart';

abstract class ExpenseTypeEvent extends Equatable {
  const ExpenseTypeEvent();

  @override
  List<Object> get props => [];
}

class ExpenseTypeSubscriptionRequested extends ExpenseTypeEvent {}

class ExpenseTypeDeleted extends ExpenseTypeEvent {
  const ExpenseTypeDeleted(this.id);
  final int id;

  @override
  List<Object> get props => [id];
}
