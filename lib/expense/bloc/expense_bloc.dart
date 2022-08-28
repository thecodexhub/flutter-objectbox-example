import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_objectbox_example/entities/entities.dart';
import 'package:flutter_objectbox_example/repository/repository.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc({
    required ExpenseRepository expenseRepository,
  })  : _expenseRepository = expenseRepository,
        super(const ExpenseState()) {
    on<ExpenseListRequested>(_onExpenseList);
    on<ExpenseListSortByTimeRequested>(_onExpenseListSortByTime);
    on<ExpenseListSortByAmountRequested>(_onExpenseListSortByAmount);
    on<ToggleExpenseSort>(_onToggleExpenseSort);
    on<ExpenseInLast7DaysRequested>(_onExpenseInLast7DaysRequested);
    on<ExpenseDeleted>(_onExpenseDeleted);
  }

  final ExpenseRepository _expenseRepository;

  Future<void> _onExpenseList(
    ExpenseListRequested event,
    Emitter<ExpenseState> emit
  ) async {
    emit(state.copyWith(status: ExpenseStatus.loading));
    await emit.forEach<List<Expense>>(
      _expenseRepository.getAllExpenseStream(),
      onData: (expenses) => state.copyWith(
        status: ExpenseStatus.success,
        expenses: expenses,
      ),
      onError: (_, __) => state.copyWith(
        status: ExpenseStatus.failure,
      ),
    );
  }

  Future<void> _onExpenseListSortByTime(
    ExpenseListSortByTimeRequested event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(state.copyWith(status: ExpenseStatus.loading));
    await emit.forEach<List<Expense>>(
      _expenseRepository.getExpenseSortByTime(),
      onData: (expenses) => state.copyWith(
        status: ExpenseStatus.success,
        expenses: expenses,
      ),
      onError: (_, __) => state.copyWith(
        status: ExpenseStatus.failure,
      ),
    );
  }

  Future<void> _onExpenseListSortByAmount(
    ExpenseListSortByAmountRequested event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(state.copyWith(status: ExpenseStatus.loading));
    await emit.forEach<List<Expense>>(
      _expenseRepository.getExpenseSortByAmount(),
      onData: (expenses) => state.copyWith(
        status: ExpenseStatus.success,
        expenses: expenses,
      ),
      onError: (_, __) => state.copyWith(
        status: ExpenseStatus.failure,
      ),
    );
  }

  void _onToggleExpenseSort(
    ToggleExpenseSort event,
    Emitter<ExpenseState> emit
  ) {
    if (state.expenseSort == ExpenseSort.none) {
      emit(state.copyWith(expenseSort: ExpenseSort.time));
      add(ExpenseListSortByTimeRequested());
    } else if (state.expenseSort == ExpenseSort.time) {
      emit(state.copyWith(expenseSort: ExpenseSort.amount));
      add(ExpenseListSortByAmountRequested());
    } else if (state.expenseSort == ExpenseSort.amount) {
      emit(state.copyWith(expenseSort: ExpenseSort.none));
      add(ExpenseListRequested());
    }
  }

  Future<void> _onExpenseInLast7DaysRequested(
    ExpenseInLast7DaysRequested event,
    Emitter<ExpenseState> emit
  ) async {
    await emit.forEach<double>(
      _expenseRepository.expenseInLast7Days(),
      onData: (totalExpenses) => state.copyWith(
        expenseInLast7Days: totalExpenses,
      ),
      onError: (_, __) => state.copyWith(
        expenseInLast7Days: 0.0,
      ),
    );
  }

  void _onExpenseDeleted(ExpenseDeleted event, Emitter<ExpenseState> emit) {
    _expenseRepository.removeExpense(event.id);
  }
}
