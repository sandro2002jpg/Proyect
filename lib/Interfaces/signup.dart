import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
//import 'package:firebase_core/firebase_core.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 221, 221),
        body: ListView(children: [
      Stack(
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height),
            painter: SignUpFondo(),
          ),
          logo(),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 53, vertical: 20),
          child: Column(
            children: [
              titulo(),
              registrarTrabajadores(),
            ]
          ),
          )
          
        ],
      ),
    ]));
  }
}

class logo extends StatelessWidget {
  const logo({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: Image.asset('lib/images/Logochiq.png', height: 50),
        ),
      ],
    );
  }
}

class titulo extends StatelessWidget {

  const titulo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: Column(
        children: [
          Text('USQAY',
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Colors.black),),
          SizedBox(height: 30,),
          Text('REGISTRO',
          style: const TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: Colors.black),),
        ]
      )
    );
  }
} 
class SignUpFondo extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    final blancopath = Path();
    blancopath.moveTo(0, size.height);
    blancopath.lineTo(0, size.height * 0.75);
    blancopath.quadraticBezierTo(
      size.width * 0.34, size.height * 0.94,
      size.width, size.height * 0.7,
    );
    blancopath.lineTo(size.width, size.height);
    blancopath.close();

    paint.color = const Color.fromARGB(122, 255, 255, 255);
    canvas.drawPath(blancopath, paint);

    final orangepath = Path();
    orangepath.moveTo(size.width * 0.01, size.height);
    orangepath.quadraticBezierTo(
      size.width * 0.7, size.height * 0.93,
      size.width, size.height * 0.76,
    );
    orangepath.lineTo(size.width, size.height);
    orangepath.lineTo(0, size.height);
    orangepath.close();

    paint.color = const Color.fromARGB(255, 242, 85, 6);
    canvas.drawPath(orangepath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


class registrarTrabajadores extends StatefulWidget {
  const registrarTrabajadores({super.key});
  @override
  registrarTrabajadoresState createState() => registrarTrabajadoresState();
}

class registrarTrabajadoresState extends State<registrarTrabajadores> {

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidosController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController claveController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final List<String> dias = ['Selecciona dia de descanso','Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
  String diaDescansoSeleccionado = 'Selecciona dia de descanso';

    Future<bool> verificarClave(String idClave) async {
    // Buscar la clave en la colección "CLAVE"
    final QuerySnapshot claveSnapshot = await FirebaseFirestore.instance
        .collection('CLAVE')
        .where('CLAVE', isEqualTo: idClave)
        .get();
    
    return claveSnapshot.docs.isNotEmpty; // Si hay documentos, la clave es válida
  }

  // Método para agregar un nuevo trabajador si la clave es válida
  void agregarNuevoTrabajador() async {
    String idClave = claveController.text;

    // Verificar si la clave es válida
    bool claveValida = await verificarClave(idClave);

    if (claveValida && diaDescansoSeleccionado != 'Selecciona dia de descanso') {
      // Si la clave es válida, agregar el trabajador
      await FirebaseFirestore.instance.collection('TRABAJADORES').add({
        'Nombre': nombreController.text,
        'Apellidos': apellidosController.text,
        'Telefono': telefonoController.text,
        'AreaLaboral': areaController.text,  
        'DiaDescanso': diaDescansoSeleccionado,
        'IDClave': idClave,
        'Estado': 'Activo',
        'Password': passwordController.text,  
      }).then((docRef) {
        // Mostrar mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Trabajador agregado con éxito'),
        ));
        context.go('/login');
        //Navigator.pushReplacementNamed(context, 'login');
      }).catchError((error) {
        // Mostrar mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error al agregar trabajador: $error'),
        ));
      });
    } else {
      // Mostrar mensaje de error si la clave no es válida
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('La clave ingresada no es válida'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
        child: Column(
          children: [
            SizedBox(height: 20,),
            TextField(
              controller: nombreController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Usuario/Nombre',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
          ),SizedBox(height: 10,),
          TextField(
            controller: apellidosController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              labelText: 'Apellidos',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),SizedBox(height: 10,),
          TextField(
            controller: telefonoController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone),
              labelText: 'Telefono',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),SizedBox(height: 10,),
          TextField(
            controller: areaController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.work),
              labelText: 'Area Laboral',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ), SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.black),
            ),
            child: DropdownButton<String>(
              icon: Icon(Icons.calendar_month),
              value: diaDescansoSeleccionado,
              isExpanded: true,
              onChanged: (String? nuevoDia) {
                setState(() {
                  diaDescansoSeleccionado = nuevoDia!;
                });
              },
              items: dias.map((String dia) {
                return DropdownMenuItem<String>(
                  value: dia,
                  child: Text(dia),
                );
              }).toList(),
            ),
          ),
          
          SizedBox(height: 10,),
          TextField(
            controller: passwordController,
            obscureText: false,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              labelText: 'Contraseña',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ), SizedBox(height: 10,),
          TextField(
            controller: claveController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.key),
              labelText: 'Clave',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ), SizedBox(height: 50,),
          ElevatedButton(
                onPressed: agregarNuevoTrabajador,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color.fromARGB(255, 28, 43, 92),
                ),
                child: const Text(
                  'REGISTRARSE',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
          ]
        )
        
          
        )
      ],
    );
  }
}

