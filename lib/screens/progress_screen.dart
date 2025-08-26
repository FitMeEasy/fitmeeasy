import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'store_screen.dart';
import 'routines_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  // semana L..D (7 bools) y últimos 14 días para calcular racha
  List<bool> _weekDone = List<bool>.filled(7, false);
  List<bool> _last14Days = List<bool>.filled(14, false);

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();

    // Semana
    String weekStr = prefs.getString('week_done') ?? '0000000';
    weekStr = ('${weekStr}0000000').substring(0, 7);
    _weekDone = weekStr.split('').map((c) => c == '1').toList();

    // Últimos 14 días (para racha)
    String last = prefs.getString('last14') ?? '00000000000000';
    last = ('${last}00000000000000').substring(0, 14);
    _last14Days = last.split('').map((c) => c == '1').toList();

    if (mounted) setState(() {});
  }

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
                Expanded(child: _streakCard()),
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
            _sectionTitle('Esta semana'),
            _weekRow(done: _weekDone),
            //_monthSummaryCard(done: 8, target: 16, lastMonthDone: 6),
            const SizedBox(height: 24),

            _sectionTitle('Historial reciente'),
            _historyItem(
              icon: Icons.check_circle,
              title: 'Día 1 — Full Body',
              date: 'Lun, 18 Ago',
              subtitle: '45 min • 10 ejercicios',
            ),
            const SizedBox(height: 8),
            _historyItem(
              icon: Icons.directions_run,
              title: 'Cardio & Core',
              date: 'Sáb, 16 Ago',
              subtitle: '30 min • HIIT',
            ),
            const SizedBox(height: 8),
            _historyItem(
              icon: Icons.local_drink,
              title: 'Hábito: Agua',
              date: 'Vie, 15 Ago',
              subtitle: '2L completados',
            ),
            const SizedBox(height: 16),
            _sectionTitle('Logros'),
            _achievementsTile(context),
            const SizedBox(height: 16),

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

  // Abreviaturas de días (Lunes..Domingo)
  final List<String> _weekDays = const ['L', 'M', 'X', 'J', 'V', 'S', 'D'];

  Widget _weekDot(String label, bool done) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: done ? const Color(0xFF16B39A) : const Color(0xFF18382F),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: done ? Colors.white : Colors.white70,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _weekRow({required List<bool> done}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (i) => _weekDot(_weekDays[i], done[i])),
    );
  }


  /*final List<bool> _last14Days = const [
    false,
    true,
    true,
    false,
    true,
    true,
    true,
    false,
    true,
    true,
    true,
    true,
    true,
    true,
  ];*/

  int _currentStreak(List<bool> days) {
    var c = 0;
    for (var i = days.length - 1; i >= 0; i--) {
      if (days[i]) {
        c++;
      } else {
        break;
      }
    }
    return c;
  }

  Widget _historyItem({
    required IconData icon,
    required String title,
    required String date,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF18382F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF1F4A3D),
              borderRadius: BorderRadius.circular(10),
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
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            date,
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _achievementRow(
    IconData icon,
    String title,
    String subtitle,
    bool unlocked,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: CircleAvatar(
        backgroundColor: const Color(0xFF1F4A3D),
        child: Icon(
          icon,
          color: unlocked ? const Color(0xFF16B39A) : Colors.white70,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
      trailing: Icon(
        unlocked ? Icons.check_circle : Icons.lock_outline,
        color: unlocked ? const Color(0xFF16B39A) : Colors.white54,
      ),
    );
  }

  Widget _achievementsTile(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF18382F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: false,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          collapsedIconColor: Colors.white70,
          iconColor: Colors.white70,
          title: const Text(
            'Logros',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          subtitle: const Text(
            '3/10 desbloqueados',
            style: TextStyle(color: Colors.white70),
          ),
          children: [
            _achievementRow(
              Icons.emoji_events,
              'Primera semana completa',
              '7 días seguidos',
              true,
            ),
            _achievementRow(
              Icons.bolt,
              'Primer PR',
              'Mejor marca personal',
              false,
            ),
            _achievementRow(
              Icons.local_fire_department,
              'Racha 30',
              '30 días sin fallar',
              false,
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  /*int _currentStreak(List<bool> days) {
    var c = 0;
    for (var i = days.length - 1; i >= 0; i--) {
      if (days[i])
        c++;
      else
        break;
    }
    return c;
  }*/

  // int _bestStreak(List<bool> days) {
  //   var best = 0, cur = 0;
  //   for (final d in days) {
  //     if (d) {
  //       cur++;
  //       if (cur > best) best = cur;
  //     } else {
  //       cur = 0;
  //     }
  //   }
  //   return best;
  // }

  int _nextMilestone(int current) {
    if (current < 7) return 7;
    if (current < 14) return 14;
    if (current < 30) return 30;
    return 60; // siguiente grande; ajustaremos cuando tengamos datos reales
  }

  Widget _streakCard() {
    final current = _currentStreak(_last14Days);
    //final best = _bestStreak(_last14Days);
    final goal = _nextMilestone(current);
    final progress = (current / goal).clamp(0.0, 1.0);
    final progressColor = const Color(0xFF16B39A);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF18382F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Icono con anillo de progreso
          SizedBox(
            width: 44,
            height: 44,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 4,
                  backgroundColor: const Color(0xFF1F4A3D),
                  valueColor: AlwaysStoppedAnimation(progressColor),
                ),
                const Icon(Icons.local_fire_department, color: Colors.white),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Números y textos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$current días',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Racha',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
