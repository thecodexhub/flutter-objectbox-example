import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_objectbox_example/entities/entities.dart';
import 'package:flutter_objectbox_example/expense/expense.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({super.key, required this.expense});
  final Expense expense;

  Future<void> _showDeleteDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Expense'),
        content: const Text('Are you sure you want to delete this expense?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'CANCEL',
              style: TextStyle(color: Colors.black54),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<ExpenseBloc>().add(ExpenseDeleted(expense.id));
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () => _showDeleteDialog(context),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                expense.expenseType.target?.identifier ?? '',
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expense.expenseType.target?.name ?? '',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      expense.note,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black45),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹ ${expense.amount.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    expense.date.formattedTime,
                    style: const TextStyle(fontSize: 14, color: Colors.black45),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Divider(),
        ],
      ),
    );
  }
}
