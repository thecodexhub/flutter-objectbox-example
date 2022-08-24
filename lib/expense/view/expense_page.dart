import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_objectbox_example/entities/expense.dart';
import 'package:flutter_objectbox_example/expense/expense.dart';
import 'package:flutter_objectbox_example/expense_type/expense_type.dart';
import 'package:flutter_objectbox_example/repository/repository.dart';

class ExpensePage extends StatelessWidget {
  const ExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, ExpenseTypePage.route()),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider<ExpenseBloc>(
          create: (_) =>
              ExpenseBloc(expenseRepository: context.read<ExpenseRepository>())
                ..add(ExpenseListRequested())
                ..add(ExpenseInLast7DaysRequested()),
          child: const ExpenseView(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, ExpenseFormPage.route()),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ExpenseView extends StatelessWidget {
  const ExpenseView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _LastWeekSpentWidget(),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 16.0),
            const Text(
              'ALL EXPENSES',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24.0),
            Expanded(
              child: ListView.builder(
                itemCount: state.expenses.length,
                itemBuilder: (context, index) {
                  final expense = state.expenses.elementAt(index);
                  return ExpenseTile(expense: expense);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LastWeekSpentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      buildWhen: (previous, current) =>
          previous.expenseInLast7Days != current.expenseInLast7Days,
      builder: (context, state) {
        return SizedBox(
          height: 120,
          // color: Colors.red,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Spent this week',
                  style: TextStyle(fontSize: 18, color: Colors.black45),
                ),
                const SizedBox(height: 8),
                Text(
                  '₹ ${state.expenseInLast7Days.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
