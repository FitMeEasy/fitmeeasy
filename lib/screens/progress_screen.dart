import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/section_title.dart';
import '../widgets/week_row.dart';
import '../data/local_storage/prefs_service.dart';

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
    final week = await PrefsService.getWeekDone();
    final last = await PrefsService.getLast14();
    if (!mounted) return;
    setState(() {
      _weekDone = week;
      _last14Days = last;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Progreso'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            SectionTitle('Resumen'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _streakCard()),
                const SizedBox(width: 12),
                Expanded(
                  child: _statCard(
                    icon: Icons.star_rounded, // ⭐
                    iconBg: AppColors.cardAlt,
                    value: '1.250',
                    label: 'Puntos',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SectionTitle('Esta semana'),
            WeekRow(done: _weekDone),
            const SizedBox(height: 24),
            SectionTitle('Historial reciente'),
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
            SectionTitle('Logros'),
            _achievementsTile(context),
            const SizedBox(height: 16),

            const SizedBox(height: 16),

            // Aquí luego añadiremos “Progreso semanal / mensual” o más métricas.
          ],
        ),
      ),

      // Bottom bar (igual que Home/Rutinas/Tienda), con índice 2 seleccionado
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
      //     selectedIndex: 2, // Progreso
      //     onDestinationSelected: (i) {
      //       if (i == 0) {
      //         Navigator.of(context).pushReplacement(
      //           MaterialPageRoute(builder: (_) => const ProfileScreen()),
      //         );
      //       } else if (i == 1) {
      //         Navigator.of(context).pushReplacement(
      //           MaterialPageRoute(builder: (_) => const StoreScreen()),
      //         );
      //       } else if (i == 3) {
      //         Navigator.of(context).pushReplacement(
      //           MaterialPageRoute(builder: (_) => const RoutinesScreen()),
      //         );
      //       }
      //     },
      //     backgroundColor: AppColors.bg,
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

  Widget _statCard({
    required IconData icon,
    required String value,
    required String label,
    Color bg = AppColors.bg,
    Color iconBg = AppColors.cardAlt,
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
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.cardAlt,
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
        backgroundColor: AppColors.cardAlt,
        child: Icon(icon, color: unlocked ? AppColors.accent : Colors.white70),
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
        color: unlocked ? AppColors.accent : Colors.white54,
      ),
    );
  }

  Widget _achievementsTile(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
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
    final progressColor = AppColors.accent;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
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
                  backgroundColor: AppColors.cardAlt,
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
