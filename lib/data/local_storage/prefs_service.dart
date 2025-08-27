import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static const _weekKey = 'week_done';
  static const _last14Key = 'last14';

  static Future<SharedPreferences> _p() => SharedPreferences.getInstance();

  static List<bool> _decodeBools(String? value, int length) {
    final s = (value ?? '').padRight(length, '0').substring(0, length);
    return s.split('').map((c) => c == '1').toList();
  }

  static String _encodeBools(List<bool> list, int length) {
    final buf = StringBuffer();
    for (var i = 0; i < length; i++) {
      buf.write(i < list.length && list[i] ? '1' : '0');
    }
    return buf.toString();
  }

  // Semana L..D (7)
  static Future<List<bool>> getWeekDone() async {
    final prefs = await _p();
    return _decodeBools(prefs.getString(_weekKey), 7);
  }

  static Future<void> setWeekDone(List<bool> week) async {
    final prefs = await _p();
    await prefs.setString(_weekKey, _encodeBools(week, 7));
  }

  // Últimos 14 días (para racha)
  static Future<List<bool>> getLast14() async {
    final prefs = await _p();
    return _decodeBools(prefs.getString(_last14Key), 14);
  }

  static Future<void> setLast14(List<bool> last) async {
    final prefs = await _p();
    await prefs.setString(_last14Key, _encodeBools(last, 14));
  }

  // Marca "hoy" como completado
  static Future<void> markTodayDone() async {
    // Semana
    final week = await getWeekDone();
    final idx = DateTime.now().weekday - 1; // L=0..D=6
    if (idx >= 0 && idx < 7) {
      week[idx] = true;
      await setWeekDone(week);
    }

    // Últimos 14: ponemos el último en true (MVP)
    final last = await getLast14();
    if (last.length == 14) {
      last[13] = true;
      await setLast14(last);
    }
  }

  // (Opcional) Reset para pruebas
  static Future<void> resetProgress() async {
    final prefs = await _p();
    await prefs.setString(_weekKey, '0000000');
    await prefs.setString(_last14Key, '00000000000000');
  }
}
