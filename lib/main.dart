import 'package:flutter/material.dart';
import 'package:gestor_fila/screens/admin.dart';
import 'package:gestor_fila/screens/cadastro_usuario.dart';
import 'package:gestor_fila/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de filas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomeWidget(),
        "/admin": (context) => const adminWidget(),
        "/cadastro": (context) => const CadastroWidget()
      },
    );
  }
}
