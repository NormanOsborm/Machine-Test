import 'package:flutter/material.dart';

class Maina extends StatelessWidget {
  const Maina({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text("HI",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
      ),
    );
  }
}
