import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/gen/app_localizations.dart';
import 'cards_tab.dart';
import 'focus_tab.dart';
import 'subjects_tab.dart';

class StudyScreen extends ConsumerWidget {
  const StudyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l.navStudy),
          bottom: TabBar(tabs: [
            Tab(text: l.studyTabFocus),
            Tab(text: l.studyTabSubjects),
            Tab(text: l.studyTabCards),
          ]),
        ),
        body: const TabBarView(
          children: [FocusTab(), SubjectsTab(), CardsTab()],
        ),
      ),
    );
  }
}
