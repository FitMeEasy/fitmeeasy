import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkoutPlayerScreen extends StatefulWidget {
  const WorkoutPlayerScreen({
    super.key,
    required this.steps,
    this.secondsPerStep = 30,
  });

  final List<String> steps;
  final int secondsPerStep;

  @override
  State<WorkoutPlayerScreen> createState() => _WorkoutPlayerScreenState();
}

class _WorkoutPlayerScreenState extends State<WorkoutPlayerScreen> {
  bool _savedToday = false;

  int _index = 0;
  int _secondsLeft = 0;
  Timer? _timer;
  bool _running = false;

  @override
  void initState() {
    super.initState();
    _secondsLeft = widget.secondsPerStep;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggle() {
    setState(() => _running = !_running);
    if (_running) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (_secondsLeft > 0) {
          setState(() => _secondsLeft--);
        } else {
          _next(auto: true);
        }
      });
    } else {
      _timer?.cancel();
    }
  }

  Future<void> _markTodayDone() async {
    if (_savedToday) return;
    final prefs = await SharedPreferences.getInstance();

    // Semana L..D
    String weekStr = prefs.getString('week_done') ?? '0000000';
    final chars = ('${weekStr}0000000').substring(0, 7).split('');
    final idx = DateTime.now().weekday - 1; // L=0..D=6
    chars[idx] = '1';
    await prefs.setString('week_done', chars.join());

    // Últimos 14 días (racha)
    String last = prefs.getString('last14') ?? '00000000000000';
    last = ('${last}00000000000000').substring(0, 14);
    last = '${last.substring(0, 13)}1';
    await prefs.setString('last14', last);

    _savedToday = true;
  }

  Future<void> _next({bool auto = false}) async {
    _timer?.cancel();
    if (_index < widget.steps.length - 1) {
      setState(() {
        _index++;
        _secondsLeft = widget.secondsPerStep;
        _running = false;
      });
    } else {
      await _markTodayDone();
      if (!auto && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Entrenamiento completado!')),
        );
      }
      if (mounted) Navigator.pop(context);
    }
  }

  void _prev() {
    _timer?.cancel();
    if (_index > 0) {
      setState(() {
        _index--;
        _secondsLeft = widget.secondsPerStep;
        _running = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = widget.steps[_index];
    final progress = 1 - (_secondsLeft / widget.secondsPerStep);

    return Scaffold(
      backgroundColor: const Color(0xFF0F2C24),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F2C24),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Entrenamiento'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Text(
              step,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 140,
              height: 140,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 8,
                    backgroundColor: const Color(0xFF1F4A3D),
                    valueColor: const AlwaysStoppedAnimation(Color(0xFF16B39A)),
                  ),
                  Text(
                    _secondsLeft.toString().padLeft(2, '0'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '${_index + 1}/${widget.steps.length}',
              style: const TextStyle(color: Colors.white70),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _prev,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white24),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Anterior'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: _toggle,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF16B39A),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(_running ? 'Pausa' : 'Iniciar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _next,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white24),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Siguiente'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
