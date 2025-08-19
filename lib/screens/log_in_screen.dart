import 'dart:ui';

import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // ~20% del ancho, con límites para no pasarnos en móviles muy pequeños o tablets
    final logoHeight = (width * 0.75).clamp(84.0, 300.0).toDouble();

    return Scaffold(
      body: Stack(
        //separamos por capas
        children: [
          _backgroundImage(),
          _logoImage(logoHeight),
          _panelLogin(),
        ],
      ),
    );
  }

  Align _logoImage(double logoHeight) {
    return Align(
          alignment: Alignment.topCenter,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Image.asset(
                'assets/images/Logo.png',
                height: logoHeight,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        );
  }

  Positioned _backgroundImage() {
    return Positioned.fill(
          //pega el hijo a los bordes del stack (lo rellena todo)
          child: Image.asset(
            'assets/images/Login_Background.png',
            fit: BoxFit.cover,
          ),
        );
  }

  Align _panelLogin() {
    return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 128),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  constraints: const BoxConstraints(
                    minHeight: 220,
                  ), //temporal
                  decoration: BoxDecoration(
                    color: const Color(0x59000000),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0x26FFFFFF), // 0x26 ≈ 15% de 255
                    ),
                  ),
                  child: _itemsPanelLogin(),
                ),
              ),
            ),
          ),
        );
  }

  Column _itemsPanelLogin() {
    return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _userCtrl,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Usuario',
                        labelStyle: TextStyle(color: Colors.white70),
                        // Bordes tipo "underline"
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0x26FFFFFF),
                          ), // ~15% blanco
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _passCtrl,
                      obscureText: _obscure,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: const TextStyle(color: Colors.white70),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0x26FFFFFF)),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        // Botón ojo
                        suffixIcon: IconButton(
                          onPressed: () =>
                              setState(() => _obscure = !_obscure),
                          icon: Icon(
                            _obscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white70,
                          ),
                          tooltip: _obscure ? 'Mostrar' : 'Ocultar',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          // TODO: login real más adelante
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login (demo)')),
                          );
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(
                            0xFF16B39A,
                          ), // verde/teal similar al mockup
                          foregroundColor:
                              Colors.white, // texto en blanco, por si acaso
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text(
                          'Iniciar sesión',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                );
  }
}
