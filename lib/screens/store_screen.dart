import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F2C24),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F2C24),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Tienda'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Tienda (placeholder)',
          style: TextStyle(color: Colors.white),
        ),
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
      //     selectedIndex: 1, // Tienda
      //     onDestinationSelected: (i) {
      //       if (i == 0) {
      //         Navigator.of(context).pushReplacement(
      //           MaterialPageRoute(builder: (_) => const ProfileScreen()),
      //         );
      //       } else if (i == 3) {
      //         Navigator.of(context).pushReplacement(
      //           MaterialPageRoute(builder: (_) => const RoutinesScreen()),
      //         );
      //       } else if (i == 2) {
      //         Navigator.of(context).pushReplacement(
      //           MaterialPageRoute(builder: (_) => const ProgressScreen()),
      //         );
      //       } else if (i != 1) {
      //         ScaffoldMessenger.of(context).showSnackBar(
      //           const SnackBar(content: Text('Sección aún no disponible')),
      //         );
      //       }
      //     },
      //     backgroundColor: const Color(0xFF18382F),
      //     indicatorColor: const Color(0xFF2A5A4B),
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
    );
  }
}
