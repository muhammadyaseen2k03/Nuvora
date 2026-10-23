import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/fitness/fitness_screen.dart';
import '../features/ai/ai_screen.dart';
import '../features/habits/calendar_screen.dart';
import '../features/notifications/notifications_screen.dart';
import '../features/habits/journal_screen.dart';
import '../features/insights/progress_screen.dart';
import '../features/planner/planner_screen.dart';
import '../features/fitness/workout_player.dart';
import '../features/prayer/prayer_screen.dart';
import '../features/study/review_screen.dart';
import '../features/study/study_screen.dart';
import '../features/study/subject_screen.dart';
import '../features/auth/onboarding_screen.dart';
import '../features/home/home_screen.dart';
import '../features/settings/settings_screen.dart';
import '../l10n/gen/app_localizations.dart';
import 'providers.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // Bridges Riverpod state to GoRouter's redirect re-evaluation.
  final refresh = ValueNotifier<String?>(ref.read(activeProfileIdProvider));
  ref.listen<String?>(activeProfileIdProvider, (_, next) => refresh.value = next);
  ref.onDispose(refresh.dispose);

  final router = GoRouter(
    initialLocation: '/home',
    refreshListenable: refresh,
    redirect: (context, state) {
      final hasProfile = ref.read(activeProfileIdProvider) != null;
      final onboarding = state.matchedLocation == '/onboarding';
      if (!hasProfile && !onboarding) return '/onboarding';
      return null;
    },
    routes: [
      GoRoute(path: '/onboarding', builder: (_, _) => const OnboardingScreen()),
      GoRoute(path: '/settings', builder: (_, _) => const SettingsScreen()),
      GoRoute(
        path: '/study/subject/:id',
        builder: (_, state) => SubjectScreen(subjectId: state.pathParameters['id']!),
      ),
      GoRoute(path: '/study/review', builder: (_, _) => const ReviewScreen()),
      GoRoute(path: '/planner', builder: (_, _) => const PlannerScreen()),
      GoRoute(path: '/calendar', builder: (_, _) => const CalendarScreen()),
      GoRoute(path: '/journal', builder: (_, _) => const JournalScreen()),
      GoRoute(path: '/progress', builder: (_, _) => const ProgressScreen()),
      GoRoute(path: '/ai', builder: (_, _) => const AiScreen()),
      GoRoute(path: '/notifications', builder: (_, _) => const NotificationsScreen()),
      GoRoute(
        path: '/fitness/workout/:id',
        builder: (_, state) => WorkoutPlayer(workoutId: state.pathParameters['id']!),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => _Shell(shell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/home', builder: (_, _) => const HomeScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/prayer', builder: (_, _) => const PrayerScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/study', builder: (_, _) => const StudyScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/fitness', builder: (_, _) => const FitnessScreen()),
          ]),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

class _Shell extends StatelessWidget {
  const _Shell({required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (i) =>
            shell.goBranch(i, initialLocation: i == shell.currentIndex),
        destinations: [
          NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: l.navHome),
          NavigationDestination(
              icon: const Icon(Icons.nights_stay_outlined),
              selectedIcon: const Icon(Icons.nights_stay),
              label: l.navPrayer),
          NavigationDestination(
              icon: const Icon(Icons.menu_book_outlined),
              selectedIcon: const Icon(Icons.menu_book),
              label: l.navStudy),
          NavigationDestination(
              icon: const Icon(Icons.fitness_center_outlined),
              selectedIcon: const Icon(Icons.fitness_center),
              label: l.navFitness),
        ],
      ),
    );
  }
}
