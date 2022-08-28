part of 'expense_bloc.dart';

enum ExpenseStatus { initial, loading, success, failure }

enum ExpenseSort { none, time, amount }

class ExpenseState extends Equatable {
  const ExpenseState({
    this.status = ExpenseStatus.initial,
    this.expenses = const [],
    this.expenseSort = ExpenseSort.none,
    this.expenseInLast7Days = 0.0,
  });

  final ExpenseStatus status;
  final List<Expense> expenses;
  final ExpenseSort expenseSort;
  final double expenseInLast7Days;

  @override
  List<Object> get props => [status, expenses, expenseSort, expenseInLast7Days];

  ExpenseState copyWith({
    ExpenseStatus? status,
    List<Expense>? expenses,
    ExpenseSort? expenseSort,
    double? expenseInLast7Days,
  }) {
    return ExpenseState(
      status: status ?? this.status,
      expenses: expenses ?? this.expenses,
      expenseSort: expenseSort ?? this.expenseSort,
      expenseInLast7Days: expenseInLast7Days ?? this.expenseInLast7Days,
    );
  }
}
