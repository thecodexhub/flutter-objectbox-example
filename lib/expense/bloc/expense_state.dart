part of 'expense_bloc.dart';

enum ExpenseStatus { initial, loading, success, failure }

class ExpenseState extends Equatable {
  const ExpenseState({
    this.status = ExpenseStatus.initial,
    this.expenses = const [],
    this.expenseInLast7Days = 0.0,
  });

  final ExpenseStatus status;
  final List<Expense> expenses;
  final double expenseInLast7Days;

  @override
  List<Object> get props => [
        status,
        expenses,
        expenseInLast7Days,
      ];

  ExpenseState copyWith({
    ExpenseStatus? status,
    List<Expense>? expenses,
    double? expenseInLast7Days,
  }) {
    return ExpenseState(
      status: status ?? this.status,
      expenses: expenses ?? this.expenses,
      expenseInLast7Days: expenseInLast7Days ?? this.expenseInLast7Days,
    );
  }
}
