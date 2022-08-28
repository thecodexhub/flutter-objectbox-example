part of 'expense_form_bloc.dart';

class ExpenseFormState extends Equatable {
  const ExpenseFormState({
    this.amount = const Amount.pure(),
    this.note = const Note.pure(),
    this.expenseTypes = const [],
    this.selectedTypeIndex = 0,
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Amount amount;
  final Note note;
  final List<ExpenseType> expenseTypes;
  final int selectedTypeIndex;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props =>
      [amount, note, expenseTypes, selectedTypeIndex, status];

  ExpenseFormState copyWith({
    Amount? amount,
    Note? note,
    List<ExpenseType>? expenseTypes,
    int? selectedTypeIndex,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return ExpenseFormState(
      amount: amount ?? this.amount,
      note: note ?? this.note,
      expenseTypes: expenseTypes ?? this.expenseTypes,
      selectedTypeIndex: selectedTypeIndex ?? this.selectedTypeIndex,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
