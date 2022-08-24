import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_objectbox_example/entities/entities.dart';
import 'package:flutter_objectbox_example/expense_type/expense_type.dart';

class ExpenseTypeCard extends StatelessWidget {
  const ExpenseTypeCard({super.key, required this.expenseType});
  final ExpenseType expenseType;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: InkWell(
            onTap: () => context
                .read<ExpenseTypeBloc>()
                .add(ExpenseTypeDeleted(expenseType.id)),
            child: const CircleAvatar(
              radius: 10,
              backgroundColor: Color(0xFFDEDEDE),
              child: Icon(
                Icons.close,
                size: 12,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                expenseType.identifier,
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 12),
              Text(
                expenseType.name,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xDD232323),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
