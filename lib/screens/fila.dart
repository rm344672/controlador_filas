import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gestor_fila/screens/entrar_fila.dart';


import '../models/Filas.dart';

class FilaWidget extends StatefulWidget {
  const FilaWidget({Key? key}) : super(key: key);

  @override
  State<FilaWidget> createState() => _FilaWidgetState();
}

class _FilaWidgetState extends State<FilaWidget> {
  @override
  Widget build(BuildContext context) {


    final args = ModalRoute.of(context)!.settings.arguments as Filas;

    ScreenUtil.init(context, designSize: const Size(700, 1400));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Controle de filas - Admin"),
      ),
      body: SizedBox(
        height: double.maxFinite,
        child: Stack(
          children: [
            const Positioned(
              child: Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Align(
                    alignment: FractionalOffset.topCenter,
                    child: Text("Sua posição atual na fila:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 20)),
                  )),
            ),
            Positioned(
                child: Align(
              alignment: FractionalOffset.center,
              child: Center(
                child: Text(args.id_ultimo.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontSize: 32)),
              ),
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => {Navigator.pushNamed(context, "/entrar_na_fila")},
          label: const Text('Sair da Fila')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}
