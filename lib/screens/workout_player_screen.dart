import 'dart:async';
import 'package:fitmeeasy/data/local_storage/prefs_service.dart';
import 'package:flutter/material.dart';

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

  Future<void> _next({bool auto = false}) async {
    _timer?.cancel();
    if (_index < widget.steps.length - 1) {
      setState(() {
        _index++;
        _secondsLeft = widget.secondsPerStep;
        _running = false;
      });
    } else {
      await PrefsService.markTodayDone();
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
