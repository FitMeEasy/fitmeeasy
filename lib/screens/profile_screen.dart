import 'package:fitmeeasy/screens/details/day_detail_screen.dart';
import 'package:fitmeeasy/screens/details/routine_detail_screen.dart';
import 'package:fitmeeasy/screens/habits_screen.dart';
import 'package:fitmeeasy/screens/routines_screen.dart';
import 'package:fitmeeasy/theme/app_colors.dart';
import 'package:fitmeeasy/widgets/dashboard_card.dart';
import 'package:flutter/material.dart';
import 'store_screen.dart';
import 'progress_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg, // verde oscuro base (temporal)
      appBar: AppBar(
        backgroundColor: AppColors.bg,
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
            } else if (i == 2) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const ProgressScreen()),
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

          backgroundColor: AppColors.card, // <- más claro
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
        color: AppColors.card, // tarjeta verde oscura
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Avatar
          const CircleAvatar(
            radius: 32,
            backgroundColor: AppColors.cardAlt,
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
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const DayDetailScreen(title: 'Día 1 — Full Body'),
          ),
        );
      },
    );
  }

  Widget _goalsCard() {
    return DashboardCard(
      leading: const Icon(Icons.directions_run, color: Colors.white),
      title: 'Correr 5k',
      subtitle: '3/5 entrenamientos completados',
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const RoutineDetailScreen(
              title: 'Correr 5k',
              meta: '3 días/semana · Nivel principiante',
            ),
          ),
        );
      },
    );
  }

  Widget _habitsCard() {
    return DashboardCard(
      leading: const Icon(Icons.local_drink, color: Colors.white),
      title: 'Beber 2L de agua',
      subtitle: 'Sigue tu ingesta diaria',
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const HabitsScreen()));
      },
    );
  }
}
