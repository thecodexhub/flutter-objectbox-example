import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_objectbox_example/expense/expense.dart';
import 'package:flutter_objectbox_example/repository/repository.dart';
import 'package:flutter_objectbox_example/theme.dart';

class App extends StatelessWidget {
  const App({super.key, required StoreRepository storeRepository})
      : _storeRepository = storeRepository;
  final StoreRepository _storeRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<StoreRepository>.value(
      value: _storeRepository,
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ExpenseRepository>(
            create: (_) => ExpenseRepository(store: _storeRepository.store),
          ),
          RepositoryProvider<ExpenseTypeRepository>(
            create: (_) => ExpenseTypeRepository(store: _storeRepository.store),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Objectbox Example',
          debugShowCheckedModeBanner: false,
          theme: createAppTheme(context),
          home: const ExpensePage(),
        ),
      ),
    );
  }
}
