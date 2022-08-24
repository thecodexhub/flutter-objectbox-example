import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_objectbox_example/entities/entities.dart';
import 'package:flutter_objectbox_example/form_inputs/form_inputs.dart';
import 'package:flutter_objectbox_example/repository/repository.dart';
import 'package:formz/formz.dart';

part 'expense_type_form_event.dart';
part 'expense_type_form_state.dart';

class ExpenseTypeFormBloc
    extends Bloc<ExpenseTypeFormEvent, ExpenseTypeFormState> {
  ExpenseTypeFormBloc({
    required ExpenseTypeRepository expenseTypeRepository,
  })  : _expenseTypeRepository = expenseTypeRepository,
        super(const ExpenseTypeFormState()) {
    on<IdentifierChanged>(_onIdentifierChanged);
    on<NameChanged>(_onNameChanged);
    on<ExpenseTypeFormSubmitted>(_onExpenseTypeFormSubmitted);
  }

  final ExpenseTypeRepository _expenseTypeRepository;

  void _onIdentifierChanged(
    IdentifierChanged event,
    Emitter<ExpenseTypeFormState> emit,
  ) {
    final identifier = Identifier.dirty(event.value);
    emit(state.copyWith(
      identifier: identifier,
      status: Formz.validate([identifier, state.name]),
    ));
  }

  void _onNameChanged(
    NameChanged event,
    Emitter<ExpenseTypeFormState> emit,
  ) {
    final name = Name.dirty(event.value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([state.identifier, name]),
    ));
  }

  void _onExpenseTypeFormSubmitted(
    ExpenseTypeFormSubmitted event,
    Emitter<ExpenseTypeFormState> emit,
  ) {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      _expenseTypeRepository.addExpenseType(
        ExpenseType(identifier: state.identifier.value, name: state.name.value),
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        errorMessage: 'You may have entered a duplicate expense type',
      ));
    }
  }
}
