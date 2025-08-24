import 'package:fitmeeasy/screens/routines_screen.dart';
import 'package:flutter/material.dart';
import 'store_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F2C24), // verde oscuro base (temporal)
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F2C24),
        foregroundColor: Colors.white, // <- texto e iconos en blanco
        elevation: 0,
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),
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
          selectedIndex: 0,
          onDestinationSelected: (i) {
            if (i == 0) return;
            if (i == 1) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const StoreScreen()),
              );
            } else if (i == 3) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const RoutinesScreen()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sección aún no disponible')),
              );
            }
          },

          backgroundColor: const Color(0xFF18382F), // <- más claro
          indicatorColor: const Color(0xFF2A5A4B), // <- resaltado suave
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
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _profileHeader(),
            const SizedBox(height: 16),
            _sectionTitle('Hoy'),
            _todayCard(),
            const SizedBox(height: 16),

            _sectionTitle('Objetivos'),
            _goalsCard(),
            const SizedBox(height: 16),

            _sectionTitle('Hábitos'),
            _habitsCard(),
          ],
        ),
      ),
    );
  }

  Widget _profileHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF18382F), // tarjeta verde oscura
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Avatar
          const CircleAvatar(
            radius: 32,
            backgroundColor: Color(0xFF1F4A3D),
            child: Icon(Icons.person, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 16),
          // Nombre + nivel + puntos
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Sophia',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Nivel 3',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                '1,200 puntos',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
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

  Widget _todayCard() {
    return DashboardCard(
      leading: const Icon(Icons.fitness_center, color: Colors.white),
      title: 'Full Body Workout',
      subtitle: '10 ejercicios • 45 min',
      trailing: const Icon(Icons.play_arrow_rounded, color: Colors.white70),
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Full Body Workout')));
      },
    );
  }

  Widget _goalsCard() {
    return DashboardCard(
      leading: const Icon(Icons.directions_run, color: Colors.white),
      title: 'Correr 5k',
      subtitle: '3/5 entrenamientos completados',
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Objetivo: Correr 5k')));
      },
    );
  }

  Widget _habitsCard() {
    return DashboardCard(
      leading: const Icon(Icons.local_drink, color: Colors.white),
      title: 'Beber 2L de agua',
      subtitle: 'Sigue tu ingesta diaria',
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Hábito: Beber 2L de agua')),
        );
      },
    );
  }
}

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.trailing = const Icon(
      Icons.arrow_forward_rounded,
      color: Colors.white70,
    ),
    this.bgColor = const Color(0xFF18382F),
    this.leadingBg = const Color(0xFF1F4A3D),
  });

  final Widget leading; // icono o imagen (lo que quieras delante)
  final String title; // texto principal
  final String subtitle; // texto secundario
  final VoidCallback? onTap; // acción al tocar
  final Widget trailing; // flecha/play/etc.
  final Color bgColor; // color tarjeta
  final Color leadingBg; // color fondo del cuadrito

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Cuadradito con fondo y el 'leading' centrado
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: leadingBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: leading,
              ),
              const SizedBox(width: 12),

              // Títulos
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}
