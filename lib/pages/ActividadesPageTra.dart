import 'package:actividad/Interfaces/ListaActividadesTra.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ActividadesPageTra extends StatelessWidget {
  const ActividadesPageTra({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () => context.go('/nuevaActividad'),
          child: const Text("Registrar Actividad"),
        ),
        const Expanded(
          child: ListaPendientesWidget(),
        )
      ],
    );
  }
}