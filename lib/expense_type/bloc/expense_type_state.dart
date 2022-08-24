part of 'expense_type_bloc.dart';

enum ExpenseTypeStatus { initial, loading, success, failure }

class ExpenseTypeState extends Equatable {
  const ExpenseTypeState({
    this.status = ExpenseTypeStatus.initial,
    this.expenseTypes = const [],
  });

  final ExpenseTypeStatus status;
  final List<ExpenseType> expenseTypes;

  @override
  List<Object> get props => [status, expenseTypes];

  ExpenseTypeState copyWith({
    ExpenseTypeStatus? status,
    List<ExpenseType>? expenseTypes,
  }) {
    return ExpenseTypeState(
      status: status ?? this.status,
      expenseTypes: expenseTypes ?? this.expenseTypes,
    );
  }
}
