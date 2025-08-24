import 'package:flutter/material.dart';
import 'package:fitmeeasy/screens/details/day_detail_screen.dart';

class RoutineDetailScreen extends StatelessWidget {
  const RoutineDetailScreen({
    super.key,
    required this.title,
    required this.meta, // ej: "3 días/semana · Nivel principiante"
  });

  final String title;
  final String meta;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F2C24),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F2C24),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _metaHeader(meta),
            const SizedBox(height: 16),
            const Text(
              'Semana 1',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),

            _dayItem(
              title: 'Día 1 — Full Body',
              subtitle: 'Calentamiento + 8 ejercicios',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        const DayDetailScreen(title: 'Día 1 — Full Body'),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),

            _dayItem(
              title: 'Día 2 — Cardio',
              subtitle: 'HIIT 20 min + core',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        const DayDetailScreen(title: 'Día 1 — Full Body'),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),

            _dayItem(
              title: 'Día 3 — Fuerza',
              subtitle: 'Tirón + Empuje',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        const DayDetailScreen(title: 'Día 1 — Full Body'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _metaHeader(String meta) {
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
          Expanded(
            child: Text(
              // Usamos el parámetro meta que llega fuera
              // (sustituido en runtime)
              meta,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dayItem({
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Material(
      color: const Color(0xFF18382F),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              const Icon(Icons.today, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // estos textos los sustituimos ahora
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(subtitle, style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white70,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
