import 'package:actividad/Interfaces/administrador.dart';
import 'package:actividad/Interfaces/nuevaActividad.dart';
import 'package:actividad/Interfaces/trabajador.dart';
import 'package:actividad/Interfaces/login.dart';
import 'package:actividad/Interfaces/signup.dart';
import 'package:actividad/firebase_options.dart';
import 'package:actividad/pages/ActividadesPageTra.dart';
import 'package:actividad/pages/ReportesPageTra.dart';
import 'package:actividad/pages/TurnosPageTra.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      //routerDelegate: _router.routerDelegate,
      //routeInformationParser: _router.routeInformationParser,
      /*initialRoute: 'login', 
    routes: {
      '/': (_) => Container(),
      'login': (_) => const Login(),
      'signup': (_) => const SignUp(),
      'trabajadores': (_) => const trabajador(),
      'administradores': (_) => const Administrador(),
      'actividadespageTra': (_) => const ActividadesPageTra(),
      'reportespageTra': (_) => const ReportesPageTra(),
      'turnospageTra': (_) => const TurnosPageTra(),
      'nuevaActividad': (_) => const NuevaActividad(),
    },
        onUnknownRoute: (settings) => MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(child: Text("No se encontró la ruta correspondiente."),),
      ),
    ),*/
    );
  }
}

  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const Login();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const Login();
        },
      ),GoRoute(
        path: '/signup',
        builder: (BuildContext context, GoRouterState state) {
          return const SignUp();
        },
      ), GoRoute(
        path: '/trabajadores',
        builder: (BuildContext context, GoRouterState state) {
          return const trabajador();
        },
      ), GoRoute(
          path: '/administradores',
          builder: (BuildContext context, GoRouterState state) {
           return const Administrador();
      }
      ),GoRoute(
        path: '/actividadespageTra',
        builder: (BuildContext context, GoRouterState state) {
          return const ActividadesPageTra();
        },
      ),GoRoute(
        path: '/reportespageTra',
        builder: (BuildContext context, GoRouterState state) {
          return const ReportesPageTra();
        },
      ),GoRoute (
        path: '/nuevaActividad',
        builder: (BuildContext context, GoRouterState state) {
          return const NuevaActividad();
        },
      ),GoRoute(
        path: '/turnospageTra', 
        builder: (BuildContext context, GoRouterState state) {
        return const TurnosPageTra();
      }),
    ]
  );
  


/*class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'login', 
      routes: {
        'login': (_) => const Login(),
        'signup': (_) => const SignUp(),
        'trabajadores': (_) => const trabajador(),
        'administradores': (_) => const Administrador(),
        'actividadespageTra': (_) => const ActividadesPageTra(),
        'reportespageTra': (_) => const ReportesPageTra(),
        'turnospageTra': (_) => const TurnosPageTra(),
        'nuevaActividad': (_) => const NuevaActividad(),
      }
    );
  }
}*/

