import 'package:flutter_objectbox_example/entities/entities.dart';
import 'package:flutter_objectbox_example/objectbox.g.dart' as objectbox_g;
import 'package:objectbox/objectbox.dart';

/// Repository to perform different operations with [Expense].
class ExpenseRepository {
  ExpenseRepository({required this.store});
  final Store store;

  /// Persists the given [Expense] in the store.
  void addExpense(Expense expense, ExpenseType expenseType) {
    expense.expenseType.target = expenseType;
    store.box<Expense>().put(expense);
  }

  /// Deletes the [Expense] with the given [id].
  void removeExpense(int id) {
    store.box<Expense>().remove(id);
  }

  /// Provides a [Stream] of all expenses.
  Stream<List<Expense>> getAllExpenseStream() {
    final query = store.box<Expense>().query();
    return query
        .watch(triggerImmediately: true)
        .map<List<Expense>>((query) => query.find());
  }

  /// Provides a [Stream] of total expense in last 7 days.
  Stream<double> expenseInLast7Days() {
    final query = store
        .box<Expense>()
        .query(objectbox_g.Expense_.date.greaterThan(
          DateTime.now()
                  .subtract(const Duration(days: 7))
                  .microsecondsSinceEpoch *
              1000,
        ))
        .watch(triggerImmediately: true);
    return query.map<double>((query) => query
        .find()
        .map<double>((e) => e.amount)
        .reduce((value, element) => value + element));
  }

  /// Provides a [Stream] of all expenses ordered by time.
  Stream<List<Expense>> getExpenseSortByTime() {
    final query = store.box<Expense>().query()
      ..order(objectbox_g.Expense_.date, flags: Order.descending);
    return query
        .watch(triggerImmediately: true)
        .map<List<Expense>>((query) => query.find());
  }

  /// Provides a [Stream] of all expenses ordered by amount.
  Stream<List<Expense>> getExpenseSortByAmount() {
    final query = store.box<Expense>().query()
      ..order(objectbox_g.Expense_.amount, flags: Order.descending);
    return query
        .watch(triggerImmediately: true)
        .map<List<Expense>>((query) => query.find());
  }
}
