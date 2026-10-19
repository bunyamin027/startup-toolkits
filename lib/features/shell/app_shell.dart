import 'package:flutter/material.dart';

import '../../core/theme/app_tokens.dart';
import '../favorites/my_tools_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../project/project_screen.dart';

/// Bottom tabs: Home, Project, My tools, Profile (§7.4). Tabs keep their
/// scroll position while switching.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _tab = 0;

  static const _pages = [
    HomeScreen(),
    ProjectScreen(),
    MyToolsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Scaffold(
      body: IndexedStack(index: _tab, children: _pages),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: t.bg,
          indicatorColor: t.surface2,
          iconTheme: WidgetStateProperty.resolveWith(
            (s) => IconThemeData(
              color: s.contains(WidgetState.selected) ? t.accent : t.muted,
            ),
          ),
          labelTextStyle: WidgetStateProperty.resolveWith(
            (s) => TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: s.contains(WidgetState.selected) ? t.text : t.muted,
            ),
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: t.border)),
          ),
          child: NavigationBar(
            selectedIndex: _tab,
            onDestinationSelected: (i) => setState(() => _tab = i),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.folder_outlined),
                selectedIcon: Icon(Icons.folder),
                label: 'Project',
              ),
              NavigationDestination(
                icon: Icon(Icons.star_outline_rounded),
                selectedIcon: Icon(Icons.star_rounded),
                label: 'My tools',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
