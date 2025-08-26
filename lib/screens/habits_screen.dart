import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class HabitItem {
  HabitItem({
    required this.name,
    required this.subtitle,
    this.icon = Icons.check_circle_outline,
    this.enabled = false,
  });

  final String name;
  final String subtitle;
  final IconData icon;
  bool enabled;
}

class _HabitsScreenState extends State<HabitsScreen> {
  final List<HabitItem> _habits = [
    HabitItem(
      name: 'Beber 2L de agua',
      subtitle: 'Objetivo diario',
      icon: Icons.local_drink,
    ),
    HabitItem(
      name: 'Dormir 8 h',
      subtitle: 'Objetivo diario',
      icon: Icons.bedtime,
    ),
    HabitItem(
      name: 'Caminar 8k pasos',
      subtitle: 'Objetivo diario',
      icon: Icons.directions_walk,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F2C24),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F2C24),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Hábitos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: _habits.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            final h = _habits[i];
            return Container(
              decoration: BoxDecoration(
                color: const Color(0xFF18382F),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF1F4A3D),
                  child: Icon(h.icon, color: Colors.white),
                ),
                title: Text(
                  h.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  h.subtitle,
                  style: const TextStyle(color: Colors.white70),
                ),
                trailing: Switch(
                  value: h.enabled,
                  activeColor: const Color(0xFF16B39A),
                  onChanged: (v) async {
                    setState(() => h.enabled = v);
                    if (v) {
                      await _markTodayDone();
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('¡Progreso de hoy marcado!'),
                        ),
                      );
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _markTodayDone() async {
    final prefs = await SharedPreferences.getInstance();

    // Semana L..D
    String weekStr = prefs.getString('week_done') ?? '0000000';
    final chars = ('${weekStr}0000000').substring(0, 7).split('');
    final idx = DateTime.now().weekday - 1; // L=0..D=6
    chars[idx] = '1';
    await prefs.setString('week_done', chars.join());

    // Racha: últimos 14 días (marcamos el último como 1)
    String last = prefs.getString('last14') ?? '00000000000000';
    last = ('${last}00000000000000').substring(0, 14);
    last = '${last.substring(0, 13)}1'; // set último día a '1'
    await prefs.setString('last14', last);
  }
}
