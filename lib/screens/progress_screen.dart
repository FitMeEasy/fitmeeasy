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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _sectionTitle('Resumen'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    icon: Icons.local_fire_department, // 🔥
                    iconBg: const Color(0xFF1F4A3D),
                    value: '12',
                    label: 'Racha',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statCard(
                    icon: Icons.star_rounded, // ⭐
                    iconBg: const Color(0xFF1F4A3D),
                    value: '1.250',
                    label: 'Puntos',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Aquí luego añadiremos “Progreso semanal / mensual” o más métricas.
          ],
        ),
      ),

      // Bottom bar (igual que Home/Rutinas/Tienda), con índice 2 seleccionado
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
            (states) => TextStyle(
              color: states.contains(WidgetState.selected)
                  ? Colors.white
                  : Colors.white70,
              fontSize: 12,
            ),
          ),
          iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>(
            (states) => IconThemeData(
              color: states.contains(WidgetState.selected)
                  ? Colors.white
                  : Colors.white70,
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
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Inicio',
            ),
            NavigationDestination(
              icon: Icon(Icons.storefront_outlined),
              selectedIcon: Icon(Icons.storefront),
              label: 'Tienda',
            ),
            NavigationDestination(
              icon: Icon(Icons.show_chart_outlined),
              selectedIcon: Icon(Icons.show_chart),
              label: 'Progreso',
            ),
            NavigationDestination(
              icon: Icon(Icons.fitness_center_outlined),
              selectedIcon: Icon(Icons.fitness_center),
              label: 'Rutinas',
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 4),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _statCard({
    required IconData icon,
    required String value,
    required String label,
    Color bg = const Color(0xFF18382F),
    Color iconBg = const Color(0xFF1F4A3D),
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22, // número grande
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
