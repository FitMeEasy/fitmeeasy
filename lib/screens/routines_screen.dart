import 'package:flutter/material.dart';
import 'profile_screen.dart'; // para volver a Home desde la bottom bar

class RoutinesScreen extends StatelessWidget {
  const RoutinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F2C24),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F2C24),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Rutinas'),
        centerTitle: true,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 3,
        onDestinationSelected: (i) {
          if (i == 0) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          } else if (i != 3) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sección aún no disponible')),
            );
          }
        },
        backgroundColor: const Color(0xFF18382F),
        indicatorColor: const Color(0xFF2A5A4B),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Perfil',
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

      // en el siguiente paso pondremos la bottom bar y el contenido
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            Text(
              'Tus rutinas',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 12),
            ListTile(
              leading: Icon(Icons.fitness_center, color: Colors.white),
              title: Text(
                'Full Body — Semana 1',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                '3 días/semana • Nivel principiante',
                style: TextStyle(color: Colors.white70),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white70,
                size: 18,
              ),
            ),
            Divider(color: Colors.white24),
            ListTile(
              leading: Icon(Icons.directions_run, color: Colors.white),
              title: Text(
                'Cardio & Core',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                '2 días/semana • 30–40 min',
                style: TextStyle(color: Colors.white70),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white70,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
