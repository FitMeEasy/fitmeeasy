import 'package:flutter/material.dart';

class ExerciseItem {
  ExerciseItem({
    required this.name,
    required this.prescription,
    required this.icon,
    this.done = false,
  });

  final String name;
  final String prescription;
  final IconData icon;
  bool done;
}

class DayDetailScreen extends StatefulWidget {
  const DayDetailScreen({super.key, required this.title});

  final String title; // ej: "Día 1 — Full Body"

  @override
  State<DayDetailScreen> createState() => _DayDetailScreenState();
}

class _DayDetailScreenState extends State<DayDetailScreen> {
  final List<ExerciseItem> _exercises = [
    ExerciseItem(
      name: 'Calentamiento',
      prescription: 'Movilidad • 5 min',
      icon: Icons.self_improvement,
    ),
    ExerciseItem(
      name: 'Sentadilla',
      prescription: '3×12 rep • 60s descanso',
      icon: Icons.fitness_center,
    ),
    ExerciseItem(
      name: 'Flexiones',
      prescription: '3×10 rep • 60s descanso',
      icon: Icons.push_pin, // icono simpático para placeholder
    ),
    ExerciseItem(
      name: 'Remo con mancuerna',
      prescription: '3×12 rep • 60s descanso',
      icon: Icons.sports_gymnastics,
    ),
    ExerciseItem(
      name: 'Plancha',
      prescription: '3×40 s • 45s descanso',
      icon: Icons.crop_16_9,
    ),
    ExerciseItem(
      name: 'Estiramientos',
      prescription: 'Enfriamiento • 5 min',
      icon: Icons.accessibility_new,
    ),
  ];

  Widget _metaHeader() {
    final total = _exercises.length;
    // estimación tonta para el MVP (la afinaremos luego)
    const estimate = '~45 min';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF18382F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.white70),
          const SizedBox(width: 8),
          Text(
            '$total ejercicios • $estimate',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  void _toggleDone(int index, bool? v) {
    setState(() => _exercises[index].done = v ?? false);
    final allDone = _exercises.every((e) => e.done);
    if (allDone) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('¡Día completado!')));
    }
  }

  Widget _exerciseTile(int index) {
    final e = _exercises[index];
    return Material(
      color: const Color(0xFF18382F),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(e.icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    e.prescription,
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Checkbox(
              value: e.done,
              onChanged: (v) => _toggleDone(index, v),
              activeColor: const Color(0xFF16B39A), // tu verde del botón
              checkColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F2C24),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F2C24),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: _exercises.length + 2, // cabecera + título + ejercicios
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            if (i == 0) return _metaHeader();
            if (i == 1) {
              return const Text(
                'Ejercicios',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              );
            }
            final exIndex = i - 2;
            return _exerciseTile(exIndex);
          },
        ),
      ),
    );
  }
}
