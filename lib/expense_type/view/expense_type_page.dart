import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_objectbox_example/expense_type/expense_type.dart';
import 'package:flutter_objectbox_example/form_inputs/form_inputs.dart';
import 'package:flutter_objectbox_example/repository/repository.dart';

class ExpenseTypePage extends StatelessWidget {
  const ExpenseTypePage({super.key});

  static Route<void> route() => MaterialPageRoute<void>(
        builder: (_) => const ExpenseTypePage(),
        fullscreenDialog: true,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EXPENSE TYPES'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ExpenseTypeFormBloc>(
              create: (context) => ExpenseTypeFormBloc(
                expenseTypeRepository: context.read<ExpenseTypeRepository>(),
              ),
            ),
            BlocProvider<ExpenseTypeBloc>(
              create: (context) => ExpenseTypeBloc(
                expenseTypeRepository: context.read<ExpenseTypeRepository>(),
              )..add(ExpenseTypeSubscriptionRequested()),
            ),
          ],
          child: const ExpenseTypeForm(),
        ),
      ),
    );
  }
}
