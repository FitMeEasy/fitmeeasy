import 'package:flutter/material.dart';

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
          onDestinationSelected: (i) {},
          backgroundColor: const Color(0xFF18382F), // <- más claro
          indicatorColor: const Color(0xFF2A5A4B), // <- resaltado suave
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.storefront_outlined),
              selectedIcon: Icon(Icons.storefront),
              label: 'Store',
            ),
            NavigationDestination(
              icon: Icon(Icons.show_chart_outlined),
              selectedIcon: Icon(Icons.show_chart),
              label: 'Progress',
            ),
            NavigationDestination(
              icon: Icon(Icons.fitness_center_outlined),
              selectedIcon: Icon(Icons.fitness_center),
              label: 'Routines',
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
    return Material(
      color: const Color(0xFF18382F),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // TODO: abrir detalle del entrenamiento
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Full Body Workout')));
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F4A3D),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.fitness_center, color: Colors.white),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full Body Workout',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '10 ejercicios • 45 min',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.play_arrow_rounded, color: Colors.white70),
            ],
          ),
        ),
      ),
    );
  }

  Widget _goalsCard() {
    return Material(
      color: const Color(0xFF18382F),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Objetivo: Correr 5k')));
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Cuadradito (icono por ahora; luego podemos poner imagen)
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F4A3D),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.directions_run, color: Colors.white),
              ),
              const SizedBox(width: 12),

              // Título + subtítulo
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Correr 5k',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '3/5 entrenamientos completados',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_rounded, color: Colors.white70),
            ],
          ),
        ),
      ),
    );
  }

  Widget _habitsCard() {
    return Material(
      color: const Color(0xFF18382F),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Hábito: Beber 2L de agua')),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F4A3D),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.local_drink, color: Colors.white),
              ),
              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Beber 2L de agua',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Sigue tu ingesta diaria',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_rounded, color: Colors.white70),
            ],
          ),
        ),
      ),
    );
  }
}
