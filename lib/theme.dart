import 'package:flutter/material.dart';

ThemeData createAppTheme(BuildContext context) {
  return ThemeData(
    appBarTheme: AppBarTheme(
      color: const Color(0xFFFAFAFA),
      titleTextStyle: Theme.of(context).textTheme.headline6?.copyWith(
            color: const Color(0xDD000000),
          ),
      iconTheme: Theme.of(context).iconTheme.copyWith(
            color: const Color(0xDD000000),
          ),
      actionsIconTheme: Theme.of(context).iconTheme.copyWith(
            color: const Color(0xDD000000),
          ),
      elevation: 0,
    ),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: const Color(0xDD000000),
    ),
  );
}
