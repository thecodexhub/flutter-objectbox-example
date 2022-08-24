part of 'expense_type_form_bloc.dart';

class ExpenseTypeFormState extends Equatable {
  const ExpenseTypeFormState({
    this.identifier = const Identifier.pure(),
    this.name = const Name.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Identifier identifier;
  final Name name;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [identifier, name, status];

  ExpenseTypeFormState copyWith({
    Identifier? identifier,
    Name? name,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return ExpenseTypeFormState(
      identifier: identifier ?? this.identifier,
      name: name ?? this.name,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
