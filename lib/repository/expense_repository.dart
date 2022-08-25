import 'package:flutter_objectbox_example/entities/entities.dart';
import 'package:flutter_objectbox_example/objectbox.g.dart' as objectbox_g;
import 'package:objectbox/objectbox.dart';

class ExpenseRepository {
  ExpenseRepository({required this.store});
  final Store store;

  void addExpense(Expense expense, ExpenseType expenseType) async {
    expense.expenseType.target = expenseType;
    store.box<Expense>().put(expense);
  }

  void removeExpense(int id) {
    store.box<Expense>().remove(id);
  }

  Stream<List<Expense>> getAllExpenseStream() {
    return store
        .box<Expense>()
        .query()
        .watch(triggerImmediately: true)
        .map<List<Expense>>((query) => query.find());
  }

  Stream<double> expenseInLast7Days() {
    return store
        .box<Expense>()
        .query(objectbox_g.Expense_.date.greaterThan(
          DateTime.now()
                  .subtract(const Duration(days: 7))
                  .microsecondsSinceEpoch *
              1000,
        ))
        .watch(triggerImmediately: true)
        .map<double>((query) => query
            .find()
            .map<double>((e) => e.amount)
            .reduce((value, element) => value + element));
  }

  Stream<List<Expense>> getExpenseSortByTime() {
    final query = store.box<Expense>().query()
      ..order(objectbox_g.Expense_.date, flags: Order.descending);
    return query
        .watch(triggerImmediately: true)
        .map<List<Expense>>((query) => query.find());
  }

  Stream<List<Expense>> getExpenseSortByAmount() {
    final query = store.box<Expense>().query()
      ..order(objectbox_g.Expense_.amount, flags: Order.descending);
    return query
        .watch(triggerImmediately: true)
        .map<List<Expense>>((query) => query.find());
  }
}
