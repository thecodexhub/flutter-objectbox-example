import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_objectbox_example/app/app.dart';
import 'package:flutter_objectbox_example/repository/repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();

  StoreRepository storeRepository = StoreRepository();
  await storeRepository.initStore();

  runApp(App(storeRepository: storeRepository));
}
