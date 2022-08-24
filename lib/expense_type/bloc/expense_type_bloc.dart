import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_objectbox_example/entities/entities.dart';
import 'package:flutter_objectbox_example/repository/repository.dart';

part 'expense_type_event.dart';
part 'expense_type_state.dart';

class ExpenseTypeBloc extends Bloc<ExpenseTypeEvent, ExpenseTypeState> {
  ExpenseTypeBloc({
    required ExpenseTypeRepository expenseTypeRepository,
  })  : _expenseTypeRepository = expenseTypeRepository,
        super(const ExpenseTypeState()) {
    on<ExpenseTypeSubscriptionRequested>(_onSubscriptionRequested);
    on<ExpenseTypeDeleted>(_onExpenseTypeDeleted);
  }

  final ExpenseTypeRepository _expenseTypeRepository;

  Future<void> _onSubscriptionRequested(
    ExpenseTypeSubscriptionRequested event,
    Emitter<ExpenseTypeState> emit,
  ) async {
    emit(state.copyWith(status: ExpenseTypeStatus.loading));
    await emit.forEach<List<ExpenseType>>(
      _expenseTypeRepository.getAllExpenseTypeStream(),
      onData: (expenseTypes) => state.copyWith(
        status: ExpenseTypeStatus.success,
        expenseTypes: expenseTypes,
      ),
      onError: (_, __) => state.copyWith(
        status: ExpenseTypeStatus.failure,
      ),
    );
  }

  void _onExpenseTypeDeleted(
    ExpenseTypeDeleted event,
    Emitter<ExpenseTypeState> emit,
  ) {
    _expenseTypeRepository.deleteExpenseType(event.id);
  }
}
