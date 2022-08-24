import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_objectbox_example/entities/entities.dart';
import 'package:flutter_objectbox_example/form_inputs/form_inputs.dart';
import 'package:flutter_objectbox_example/repository/repository.dart';
import 'package:formz/formz.dart';

part 'expense_form_event.dart';
part 'expense_form_state.dart';

class ExpenseFormBloc extends Bloc<ExpenseFormEvent, ExpenseFormState> {
  ExpenseFormBloc({
    required ExpenseRepository expenseRepository,
    required ExpenseTypeRepository expenseTypeRepository,
  })  : _expenseRepository = expenseRepository,
        _expenseTypeRepository = expenseTypeRepository,
        super(const ExpenseFormState()) {
    on<InitExpenseForm>(_onInitExpenseForm);
    on<AmountChanged>(_onAmountChanged);
    on<NoteChanged>(_onNoteChanged);
    on<ExpenseTypeChanged>(_onExpenseTypeChanged);
    on<ExpenseFormSubmitted>(_onExpenseFormSubmitted);
  }

  final ExpenseRepository _expenseRepository;
  final ExpenseTypeRepository _expenseTypeRepository;

  void _onInitExpenseForm(
    InitExpenseForm event,
    Emitter<ExpenseFormState> emit,
  ) {
    final expenseTypes = _expenseTypeRepository.getAllExpenseTypes();
    emit(state.copyWith(expenseTypes: expenseTypes));
  }

  void _onAmountChanged(
    AmountChanged event,
    Emitter<ExpenseFormState> emit,
  ) {
    final amount = Amount.dirty(event.value);
    emit(state.copyWith(
      amount: amount,
      status: Formz.validate([amount, state.note]),
    ));
  }

  void _onNoteChanged(
    NoteChanged event,
    Emitter<ExpenseFormState> emit,
  ) {
    final note = Note.dirty(event.value);
    emit(state.copyWith(
      note: note,
      status: Formz.validate([state.amount, note]),
    ));
  }

  void _onExpenseTypeChanged(
    ExpenseTypeChanged event,
    Emitter<ExpenseFormState> emit,
  ) {
    emit(state.copyWith(
      selectedTypeIndex: event.selectedIndex,
      status: Formz.validate([state.amount, state.note]),
    ));
  }

  void _onExpenseFormSubmitted(
    ExpenseFormSubmitted event,
    Emitter<ExpenseFormState> emit,
  ) {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    final expenseType = state.expenseTypes.elementAt(state.selectedTypeIndex);
    try {
      _expenseRepository.addExpense(
        Expense(
          amount: double.parse(state.amount.value),
          note: state.note.value,
          date: DateTime.now(),
        ),
        expenseType,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        errorMessage: e.toString(),
      ));
    }
  }
}
