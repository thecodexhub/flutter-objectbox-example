import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_objectbox_example/expense/expense.dart';
import 'package:flutter_objectbox_example/form_inputs/form_inputs.dart';
import 'package:flutter_objectbox_example/repository/repository.dart';
import 'package:formz/formz.dart';

class ExpenseFormPage extends StatelessWidget {
  const ExpenseFormPage({super.key});

  static Route route() => MaterialPageRoute(
        builder: (_) => const ExpenseFormPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EXPENSE'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider<ExpenseFormBloc>(
          create: (context) => ExpenseFormBloc(
            expenseRepository: context.read<ExpenseRepository>(),
            expenseTypeRepository: context.read<ExpenseTypeRepository>(),
          )..add(InitExpenseForm()),
          child: const ExpenseFormView(),
        ),
      ),
    );
  }
}

class ExpenseFormView extends StatelessWidget {
  const ExpenseFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpenseFormBloc, ExpenseFormState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Something went wrong'),
              ),
            );
        } else if (state.status.isSubmissionSuccess) {
          Navigator.pop(context);
        }
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Add amount', style: TextStyle(fontSize: 18)),
            _AmountTextField(),
            const SizedBox(height: 16),
            const Text('Add a note', style: TextStyle(fontSize: 18)),
            _NoteTextField(),
            const SizedBox(height: 24),
            const Text('Select an expense type',
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            _ExpenseTypeSelectionWidget(),
            const SizedBox(height: 16),
            _AddExpenseButton(),
          ],
        ),
      ),
    );
  }
}

class _AmountTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseFormBloc, ExpenseFormState>(
      buildWhen: (previous, current) => previous.amount != current.amount,
      builder: (context, state) {
        return TextField(
          key: const Key('expenseForm_amount_textField'),
          onChanged: (value) =>
              context.read<ExpenseFormBloc>().add(AmountChanged(value)),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Amount',
            errorText: state.amount.invalid ? 'Must be a number' : null,
          ),
        );
      },
    );
  }
}

class _NoteTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseFormBloc, ExpenseFormState>(
      buildWhen: (previous, current) => previous.note != current.note,
      builder: (context, state) {
        return TextField(
          key: const Key('expenseForm_note_textField'),
          onChanged: (value) =>
              context.read<ExpenseFormBloc>().add(NoteChanged(value)),
          decoration: InputDecoration(
            hintText: 'Note',
            errorText:
                state.note.invalid ? 'Must be within 10 characters' : null,
          ),
        );
      },
    );
  }
}

class _ExpenseTypeSelectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseFormBloc, ExpenseFormState>(
      buildWhen: (previous, current) =>
          previous.selectedTypeIndex != current.selectedTypeIndex ||
          previous.expenseTypes != current.expenseTypes,
      builder: (context, state) {
        return GridView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemCount: state.expenseTypes.length,
          itemBuilder: (context, index) {
            final expenseType = state.expenseTypes.elementAt(index);
            return InkWell(
              onTap: () => context
                  .read<ExpenseFormBloc>()
                  .add(ExpenseTypeChanged(index)),
              child: TypeSelectionCard(
                expenseType: expenseType,
                backgroundColor:
                    index == state.selectedTypeIndex ? Colors.grey[300] : null,
              ),
            );
          },
        );
      },
    );
  }
}

class _AddExpenseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseFormBloc, ExpenseFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('expenseForm_addExpense_elevatedButton'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            primary: const Color(0xFF252525),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: state.status.isValidated
              ? () =>
                  context.read<ExpenseFormBloc>().add(ExpenseFormSubmitted())
              : null,
          child: state.status.isSubmissionInProgress
              ? const CircularProgressIndicator()
              : const Text(
                  'SAVE',
                  style: TextStyle(fontSize: 18),
                ),
        );
      },
    );
  }
}
