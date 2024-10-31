import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  LoginState createState() => LoginState();
  
}

class LoginState extends State<Login> {
  bool _isObscure = true; //controla el estado si la contraseña es visible o no
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<bool> verificarTrabajador(String nombre, String password) async {

      final QuerySnapshot trabajadorSnapshot = await FirebaseFirestore.instance
        .collection('TRABAJADORES')
        .where('Nombre', isEqualTo: nombre)
        .where('Password', isEqualTo: password)
        .get();

    return trabajadorSnapshot.docs.isNotEmpty;
    
    
  }

  Future<bool> verificarAdministrador(String nombre, String password) async {
  try{
    final QuerySnapshot adminSnapshot = await FirebaseFirestore.instance
      .collection('ADMINISTRADOR')
      .where('Nombre', isEqualTo: nombre)
      .where('Password', isEqualTo: password)
      .get();

    return adminSnapshot.docs.isNotEmpty;
  } catch (e) {
      print('Error buscando Administrador: $e');
      return false; 
    }
  }
  

  void iniciarSesion() async {
    String nombre = nombreController.text;
    String password = passwordController.text;

    bool esTrabajador = await verificarTrabajador(nombre, password);
    bool esAdministrador = await verificarAdministrador(nombre, password);

    if (esTrabajador) {context.go('/trabajadores');}
      //Navigator.pushReplacementNamed(context, '/trabajadores');  
    else{
      if (esAdministrador) {context.go('/administradores');}
        //Navigator.pushReplacementNamed(context,'/administradores'); 
       else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Usuario o contraseña incorrectos'),
        ));
    }
    }  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ListView(
        children: [
          Stack(
            children: [
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
                painter: LoginFondo(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
                child: Column(
                  children: [
                    Image.asset('lib/images/Logo.png', height: 75,),
                    SizedBox(height: 200,),
                    Text(
                      'INICIAR SESION', 
                      style: (TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                    ),
                    SizedBox(height: 70,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          TextField(
                            controller: nombreController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: 'Usuario',
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          TextField(
                            obscureText: _isObscure,
                            controller: passwordController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'Contraseña',
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ), suffixIcon: IconButton(
                                icon: Icon(
                                _isObscure ? Icons.visibility : Icons.visibility_off,
                              ), 
                              onPressed: () {
                                setState((){
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                          )
                          ),
                          SizedBox(height: 30,),
                          ElevatedButton(
                            onPressed: iniciarSesion,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: const Color.fromARGB(255, 28, 43, 92),
                            ),
                            child: const Text('INICIAR SESION', style: TextStyle(fontSize: 18, color: Colors.white),),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                               TextButton(
                            onPressed: () => context.go('/signup'),
                            /*{Navigator.pushNamed(context, '/signup');}*/
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              textStyle: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              foregroundColor: Colors.white,
                            ),
                            child: Text('Registrarse')),
                            ]
                          )    
                        ]
                      ),
                    ),
                  ],
              )
              ),  
            ],
          )
        ],
      )
    );
  }
}



class LoginFondo extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = const Color.fromARGB(255, 242, 85, 6);
    paint.style = PaintingStyle.fill;
      
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.35);
    path.quadraticBezierTo(
      size.width * 0.2, size.height * 0.45, 
      size.width * 0.5, size.height * 0.37,       
    );
    path.quadraticBezierTo(
      size.width * 0.8, size.height * 0.28,
      size.width, size.height * 0.35,
    );
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

