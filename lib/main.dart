import 'package:flutter/material.dart';
import 'package:gestor_fila/screens/admin.dart';
import 'package:gestor_fila/screens/cadastro_usuario.dart';
import 'package:gestor_fila/screens/entrar_fila.dart';
import 'package:gestor_fila/screens/fila.dart';
import 'package:gestor_fila/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        "/admin": (context) => const AdminWidget(),
        "/cadastro": (context) => const CadastroWidget(),
        "/entrar_na_fila": (context) => const EntrarFilaWidget(),
        "/fila": (context) => const FilaWidget()
      },
    );
  }
}
