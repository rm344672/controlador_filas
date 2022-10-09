import 'package:flutter/material.dart';

class AdminWidget extends StatefulWidget {
  const AdminWidget({Key? key}) : super(key: key);

  @override
  State<AdminWidget> createState() => _AdminWidgetState();
}

class _AdminWidgetState extends State<AdminWidget> {
  String proximoNaFila = "1";

  @override
  Widget build(BuildContext context) {
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
                    child: Text("Próxima pessoa da fila:",
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
                child: Text(proximoNaFila,
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
          onPressed: () => {}, label: const Text('Chamar Próximo')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
