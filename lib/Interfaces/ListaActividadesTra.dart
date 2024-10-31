import 'package:actividad/Interfaces/trabajador.dart'; 
import 'package:flutter/material.dart';

class ListaPendientesWidget extends StatefulWidget {
  const ListaPendientesWidget({
    super.key,
  });

  @override
  State<ListaPendientesWidget> createState() => _ListaPendientesWidgetState();
}

class _ListaPendientesWidgetState extends State<ListaPendientesWidget> {
  double radius = 10;
  @override
  Widget build(BuildContext context) {

    return Column(
        children: List.generate(dataArray.length, (index) {
      final item = dataArray[index];

      if (item.estado != 1) {
        return const SizedBox.shrink();
      }

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border(
                left: BorderSide(
              color: colorValidateEstado(item.estado),
              width: 5,
            ))),
        child: ExpansionTile(
          leading: const Icon(Icons.edit_document),
          title: Text(item.nombre), 
          subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(item.cliente),
              Container(
                decoration: BoxDecoration(
                    color: colorValidateEstado(item.estado),
                    borderRadius: BorderRadius.circular(10)),
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                child: Text(
                  getNameEstado(item.estado),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide.none,
          ),
          trailing: validateButtonState(item.estado)
              ? ElevatedButton(onPressed: () {}, child: const Text("SOLUCIONAR"))
              : const SizedBox.shrink(),
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              color: Colors.grey.withOpacity(0.3),
              width: double.maxFinite,
              child: Text(item.descripcion),
            )
          ],
        ),
      );
    }));
  }
}

String getNameEstado(int estado) {
  switch (estado) {
    case 1:
      return "PENDIENTE";
    case 2:
      return "RESUELTO";
    case 0:
      return "ELIMINADO";
    default:
      return "ERROR";
  }
}

bool validateButtonState(int estado) {
  switch (estado) {
    case 1:
      return true;
    case 2:
      return false;
    case 0:
      return false;
    default:
      return false;
  }
}

Color colorValidateEstado(int estado) {
  switch (estado) {
    case 1:
      return Colors.yellow.shade800;
    case 2:
      return Colors.green.shade900;
    case 0:
      return Colors.red.shade600;
    default:
      return Colors.grey;
  }
}
