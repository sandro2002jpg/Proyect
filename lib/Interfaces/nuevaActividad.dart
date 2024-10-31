import 'package:flutter/material.dart';

class NuevaActividad extends StatelessWidget {
  const NuevaActividad({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [ 
          Stack(
           children: [
            log()
          ],
        ),
        ]
      ),
    );
  }
}

class log extends StatelessWidget {
  const log({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: Image.asset('lib/images/Logochiq.png', height: 50),
        ),
      ],
    );
  }
}