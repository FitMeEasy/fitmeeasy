import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'store_screen.dart';
import 'routines_screen.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F2C24),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F2C24),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Progreso'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Progreso (placeholder)', style: TextStyle(color: Colors.white)),
      ),

      // Bottom bar (igual que Home/Rutinas/Tienda), con índice 2 seleccionado
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
          selectedIndex: 2, // Progreso
          onDestinationSelected: (i) {
            if (i == 0) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            } else if (i == 1) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const StoreScreen()),
              );
            } else if (i == 3) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const RoutinesScreen()),
              );
            }
          },
          backgroundColor: const Color(0xFF18382F),
          indicatorColor: const Color(0xFF2A5A4B),
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
