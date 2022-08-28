import 'package:flutter_objectbox_example/entities/entities.dart';
import 'package:objectbox/objectbox.dart';

/// Repository to perform different operations with [ExpenseType].
class ExpenseTypeRepository {
  ExpenseTypeRepository({required this.store});
  final Store store;

  /// Persists the given [ExpenseType] in the store.
  void addExpenseType(ExpenseType expenseType) {
    store.box<ExpenseType>().put(expenseType);
  }

  /// Returns all stored [ExpenseType]s in this Box.
  List<ExpenseType> getAllExpenseTypes() {
    return store.box<ExpenseType>().getAll();
  }

  /// Provides a [Stream] of all expense types.
  Stream<List<ExpenseType>> getAllExpenseTypeStream() {
    final query = store.box<ExpenseType>().query();
    return query
        .watch(triggerImmediately: true)
        .map<List<ExpenseType>>((query) => query.find());
  }

  /// Deletes the [ExpenseType] with the given [id].
  bool deleteExpenseType(int id) {
    return store.box<ExpenseType>().remove(id);
  }
}
