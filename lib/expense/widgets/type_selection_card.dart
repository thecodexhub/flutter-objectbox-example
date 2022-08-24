import 'package:flutter/material.dart';
import 'package:flutter_objectbox_example/entities/entities.dart';

class TypeSelectionCard extends StatelessWidget {
  const TypeSelectionCard({
    super.key,
    required this.expenseType,
    this.backgroundColor,
  });
  final ExpenseType expenseType;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor,
      ),
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
    );
  }
}
