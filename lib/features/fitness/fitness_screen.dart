import 'package:flutter/material.dart';

import '../../l10n/gen/app_localizations.dart';
import 'fasting_tab.dart';
import 'water_tab.dart';
import 'workouts_tab.dart';

class FitnessScreen extends StatelessWidget {
  const FitnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l.navFitness),
          bottom: TabBar(tabs: [
            Tab(text: l.fitnessTabWorkouts),
            Tab(text: l.fitnessTabWater),
            Tab(text: l.fitnessTabFasting),
          ]),
        ),
        body: const TabBarView(
          children: [WorkoutsTab(), WaterTab(), FastingTab()],
        ),
      ),
    );
  }
}
