import 'package:flutter_objectbox_example/entities/entities.dart';
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
}
