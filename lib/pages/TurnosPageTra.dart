import 'package:flutter/material.dart';

class TurnosPageTra extends StatelessWidget {
  const TurnosPageTra({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Turnos'),
      ),
      body: const Center(
        child: Text('turnos'),
      ),
    );
  }
}