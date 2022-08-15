import 'package:flutter_objectbox_example/entities/entities.dart';
import 'package:objectbox/objectbox.dart';

/// {@template expense_type}
/// Expense type entity.
/// {@endtemplate}
@Entity()
class ExpenseType {
  /// {@macro expense_type}
  ExpenseType({
    this.id = 0,
    required this.identifier,
    required this.name,
  });

  /// Id of the entity, managed by the Objectbox.
  int id;

  /// Identifier for the [ExpenseType], generally an emoji.
  String identifier;

  /// Name for the [ExpenseType], must be unique.
  @Unique()
  String name;

  /// All the expenses linked to this [ExpenseType]
  @Backlink()
  final expenses = ToMany<Expense>();
}
