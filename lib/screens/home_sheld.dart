import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'profile_screen.dart';
import 'store_screen.dart';
import 'progress_screen.dart';
import 'routines_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key, this.initialIndex = 0});
  final int initialIndex;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  late int _index = widget.initialIndex;

  // Cada tab mantiene su propio estado gracias a IndexedStack.
  final _tabs = const [
    ProfileScreen(),
    StoreScreen(),
    ProgressScreen(),
    RoutinesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No AppBar aquí; cada tab gestiona su appbar.
      body: IndexedStack(
        index: _index,
        children: _tabs,
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
            (states) => TextStyle(
              color: states.contains(WidgetState.selected) ? Colors.white : Colors.white70,
              fontSize: 12,
            ),
          ),
          iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>(
            (states) => IconThemeData(
              color: states.contains(WidgetState.selected) ? Colors.white : Colors.white70,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          backgroundColor: AppColors.card,
          indicatorColor: AppColors.cardAlt,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Inicio',
            ),
            NavigationDestination(
              icon: Icon(Icons.storefront_outlined), selectedIcon: Icon(Icons.storefront), label: 'Tienda',
            ),
            NavigationDestination(
              icon: Icon(Icons.show_chart_outlined), selectedIcon: Icon(Icons.show_chart), label: 'Progreso',
            ),
            NavigationDestination(
              icon: Icon(Icons.fitness_center_outlined), selectedIcon: Icon(Icons.fitness_center), label: 'Rutinas',
            ),
          ],
        ),
      ),
    );
  }
}
