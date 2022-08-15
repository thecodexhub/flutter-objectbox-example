import 'package:flutter_objectbox_example/entities/entities.dart';
import 'package:objectbox/objectbox.dart';

class ExpenseTypeRepository {
  ExpenseTypeRepository({required this.store});
  final Store store;

  void addExpenseType(ExpenseType expenseType) {
    store.box<ExpenseType>().put(expenseType);
  }

  List<ExpenseType> getAllExpenseTypes() {
    return store.box<ExpenseType>().getAll();
  }

  Stream<List<ExpenseType>> getAllExpenseTypeStream() {
    return store
        .box<ExpenseType>()
        .query()
        .watch(triggerImmediately: true)
        .map<List<ExpenseType>>((query) => query.find());
  }

  bool deleteExpenseType(int id) {
    return store.box<ExpenseType>().remove(id);
  }
}
