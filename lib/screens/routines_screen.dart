import 'package:fitmeeasy/screens/details/routine_detail_screen.dart';
import 'package:flutter/material.dart';
// para volver a Home desde la bottom bar

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
      // bottomNavigationBar: NavigationBarTheme(
      //   data: NavigationBarThemeData(
      //     labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
      //       (states) => TextStyle(
      //         color: states.contains(WidgetState.selected)
      //             ? Colors.white
      //             : Colors.white70,
      //         fontSize: 12,
      //       ),
      //     ),
      //     iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>(
      //       (states) => IconThemeData(
      //         color: states.contains(WidgetState.selected)
      //             ? Colors.white
      //             : Colors.white70,
      //       ),
      //     ),
      //   ),
      //   child: NavigationBar(
      //     selectedIndex: 3, // Rutinas
      //     onDestinationSelected: (i) {
      //       if (i == 0) {
      //         Navigator.of(context).pushReplacement(
      //           MaterialPageRoute(builder: (_) => const ProfileScreen()),
      //         );
      //       } else if (i == 1) {
      //         Navigator.of(context).pushReplacement(
      //           MaterialPageRoute(builder: (_) => const StoreScreen()),
      //         );
      //       } else if (i == 2) {
      //         Navigator.of(context).pushReplacement(
      //           MaterialPageRoute(builder: (_) => const ProgressScreen()),
      //         );
      //       } else if (i != 3) {
      //         ScaffoldMessenger.of(context).showSnackBar(
      //           const SnackBar(content: Text('Sección aún no disponible')),
      //         );
      //       }
      //     },
      //     backgroundColor: const Color(0xFF18382F), // mismo que Home
      //     indicatorColor: const Color(0xFF2A5A4B), // mismo que Home
      //     destinations: const [
      //       NavigationDestination(
      //         icon: Icon(Icons.home_outlined),
      //         selectedIcon: Icon(Icons.home),
      //         label: 'Inicio',
      //       ),
      //       NavigationDestination(
      //         icon: Icon(Icons.storefront_outlined),
      //         selectedIcon: Icon(Icons.storefront),
      //         label: 'Tienda',
      //       ),
      //       NavigationDestination(
      //         icon: Icon(Icons.show_chart_outlined),
      //         selectedIcon: Icon(Icons.show_chart),
      //         label: 'Progreso',
      //       ),
      //       NavigationDestination(
      //         icon: Icon(Icons.fitness_center_outlined),
      //         selectedIcon: Icon(Icons.fitness_center),
      //         label: 'Rutinas',
      //       ),
      //     ],
      //   ),
      // ),

      // en el siguiente paso pondremos la bottom bar y el contenido
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Tus rutinas',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            _weekHeader('Semana 1'),

            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const RoutineDetailScreen(
                      title: 'Full Body — Semana 1',
                      meta: '3 días/semana · Nivel principiante',
                    ),
                  ),
                );
              },

              leading: const Icon(Icons.fitness_center, color: Colors.white),
              title: const Text(
                'Full Body — Semana 1',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: const Text(
                '3 días/semana • Nivel principiante',
                style: TextStyle(color: Colors.white70),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white70,
                size: 18,
              ),
            ),
            const Divider(color: Colors.white24),
            _weekHeader('Semana 2'),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const RoutineDetailScreen(
                      title: 'Cardio & Core — Semana 2',
                      meta: '2 días/semana · 30–40 min',
                    ),
                  ),
                );
              },

              leading: Icon(Icons.directions_run, color: Colors.white),
              title: Text(
                'Cardio & Core — Semana 2',
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

  Widget _weekHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF1F4A3D),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // línea que se estira para separar visualmente
          Expanded(child: Container(height: 1, color: Colors.white24)),
        ],
      ),
    );
  }
}
