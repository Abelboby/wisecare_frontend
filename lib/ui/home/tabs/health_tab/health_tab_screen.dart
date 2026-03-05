import 'package:flutter/material.dart';

part 'health_tab_functions.dart';
part 'health_tab_variables.dart';

class HealthTabScreen extends StatelessWidget {
  const HealthTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Health',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
