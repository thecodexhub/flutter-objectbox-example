import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_objectbox_example/expense_type/expense_type.dart';
import 'package:flutter_objectbox_example/form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

class ExpenseTypeView extends StatelessWidget {
  const ExpenseTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ExpenseTypeFormBloc, ExpenseTypeFormState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content:
                        Text(state.errorMessage ?? 'Something went wrong!'),
                  ),
                );
            }
          },
        ),
        BlocListener<ExpenseTypeBloc, ExpenseTypeState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == ExpenseTypeStatus.failure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text('Something went wrong while loading types!'),
                  ),
                );
            }
          },
        ),
      ],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Add an identifier', style: TextStyle(fontSize: 18)),
            _IdentifierTextField(),
            const SizedBox(height: 16.0),
            const Text('Add a name', style: TextStyle(fontSize: 18)),
            _NameTextField(),
            const SizedBox(height: 16.0),
            _SubmitButton(),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 16.0),
            const Text(
              'AVAILABLE EXPENSE TYPES',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24.0),
            _ExpenseTypesList(),
          ],
        ),
      ),
    );
  }
}

class _IdentifierTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseTypeFormBloc, ExpenseTypeFormState>(
      buildWhen: (previous, current) =>
          previous.identifier != current.identifier,
      builder: (context, state) {
        return TextField(
          key: const Key('expenseTypeForm_identifier_textField'),
          onChanged: (value) =>
              context.read<ExpenseTypeFormBloc>().add(IdentifierChanged(value)),
          decoration: InputDecoration(
            hintText: 'Identifier',
            errorText:
                state.identifier.invalid ? 'Must be within 5 characters' : null,
          ),
        );
      },
    );
  }
}

class _NameTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseTypeFormBloc, ExpenseTypeFormState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          key: const Key('expenseTypeForm_name_textField'),
          onChanged: (value) =>
              context.read<ExpenseTypeFormBloc>().add(NameChanged(value)),
          decoration: InputDecoration(
            hintText: 'Name',
            errorText:
                state.name.invalid ? 'Must be within 10 characters' : null,
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseTypeFormBloc, ExpenseTypeFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            primary: const Color(0xFF252525),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: state.status.isValidated
              ? () => context
                  .read<ExpenseTypeFormBloc>()
                  .add(ExpenseTypeFormSubmitted())
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

class _ExpenseTypesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseTypeBloc, ExpenseTypeState>(
      builder: (context, state) {
        if (state.expenseTypes.isEmpty) {
          if (state.status == ExpenseTypeStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status != ExpenseTypeStatus.success) {
            return const SizedBox();
          } else {
            return const SizedBox(
              height: 150,
              child: Center(
                child: Text(
                  'No Expense Type available',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
          }
        }
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemCount: state.expenseTypes.length,
          itemBuilder: (context, index) {
            final expenseType = state.expenseTypes.elementAt(index);
            return ExpenseTypeCard(expenseType: expenseType);
          },
        );
      },
    );
  }
}
