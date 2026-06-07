import 'package:flutter/material.dart';

void main(){
  runApp(CureApp());
}

class CureApp extends StatelessWidget {
  const CureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    );
  }
}
