import 'package:flutter/material.dart';
import 'package:actividad/pages/TurnosPageTra.dart';
import 'package:actividad/pages/ActividadesPageTra.dart';
import 'package:actividad/pages/ReportesPageTra.dart';
//import 'package:actividad/Interfaces/listaActividadesTra.dart';


Radius radiusBorder = const Radius.circular(15);

class trabajador extends StatelessWidget {
  const trabajador({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange.shade800),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexValue = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabBarData.length,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 500),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange.shade900,
          toolbarHeight: 100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: radiusBorder,
              bottomRight: radiusBorder,
            ),
          ),
          title: const Text(
            "Usqay\nACTIVIDADES",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
          ),
          centerTitle: true,
        ),
        bottomSheet: TabBar(
            onTap: (value) {
              setState(() {
                indexValue = value;
              });
            },
            tabs: List.generate(tabBarData.length, (index) {
              TabBarModel item = tabBarData[index];

              return Tab(
                icon: item.icon,
                child: Text(item.title),
              );
            })),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: getWidgetPage(indexValue),
        ),
      ),
    );
  }
}

List<PeticionModel> dataArray = [
  PeticionModel(
      nombre: "Petición 1",
      descripcion: "Descripción de la petición 1",
      cliente: "Cliente A",
      fecha: DateTime.now(),
      estado: 1),
  PeticionModel(
      nombre: "Petición 2",
      descripcion: "Descripción de la petición 2",
      cliente: "Cliente B",
      fecha: DateTime.now().add(Duration(days: 1)),
      estado: 2),
  PeticionModel(
      nombre: "Petición 3",
      descripcion: "Descripción de la petición 3",
      cliente: "Cliente C",
      fecha: DateTime.now().add(Duration(days: 2)),
      estado: 0),
  PeticionModel(
      nombre: "Petición 4",
      descripcion: "Descripción de la petición 4",
      cliente: "Cliente D",
      fecha: DateTime.now().add(Duration(days: 3)),
      estado: 1),
  PeticionModel(
      nombre: "Petición 5",
      descripcion: "Descripción de la petición 5",
      cliente: "Cliente E",
      fecha: DateTime.now().add(Duration(days: 4)),
      estado: 2),
];

class PeticionModel {
  final String nombre;
  final String descripcion;
  final String cliente;
  final DateTime fecha;
  final int estado;

  PeticionModel(
      {required this.nombre,
      required this.descripcion,
      required this.cliente,
      required this.fecha,
      required this.estado});
}

class TabBarModel {
  final String title;
  final Icon icon;

  TabBarModel({required this.title, required this.icon});
}

// "Turnos", "Actividades", "Reportes"
List<TabBarModel> tabBarData = [
  TabBarModel(
    title: "Turnos",
    icon: const Icon(Icons.watch_later_outlined),
  ),
  TabBarModel(
    title: "Actividades",
    icon: const Icon(Icons.house_rounded),
  ),
  TabBarModel(title: "Reportes", icon: const Icon(Icons.file_copy_rounded)),
];

Widget getWidgetPage(int index) {
  switch (index) {
    case 0:
      return const TurnosPageTra();
    case 1:
      return  const ActividadesPageTra();
    case 2:
      return const ReportesPageTra();
    default:
      return Container(
        color: Colors.red,
      );
  }
}
