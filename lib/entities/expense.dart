import 'package:flutter_objectbox_example/entities/entities.dart';
import 'package:objectbox/objectbox.dart';

/// {@template expense}
/// Expense entity.
/// {@endtemplate}
@Entity()
class Expense {
  /// {@macro expense}
  Expense({
    this.id = 0,
    required this.amount,
    this.note = '',
    required this.date,
  });

  /// Id of the expense entity, managed by Objectbox.
  int id;

  /// Amount that has been expensed.
  double amount;

  /// Optional note for the expense.
  String note;

  /// Date and time when the expense has been noted.
  @Property(type: PropertyType.dateNano)
  DateTime date;

  /// [ExpenseType] of the expense.
  final expenseType = ToOne<ExpenseType>();
}
