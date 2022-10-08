import 'package:flutter/material.dart';

class adminWidget extends StatefulWidget {
  const adminWidget({Key? key}) : super(key: key);

  @override
  _adminWidget createState() => _adminWidget();
}

class _adminWidget extends State<adminWidget> {
  String proximoNaFila = "1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Controle de filas - Admin"),
      ),
      body: Container(
        height: double.maxFinite,
        child: Stack(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // ignore: prefer_const_constructors
            Positioned(
              child: const Padding(
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
            // ignore: prefer_const_constructors
            Positioned(
                // ignore: unnecessary_new
                child: new Align(
              alignment: FractionalOffset.center,
              child: Center(
                child: Text(proximoNaFila,
                    textAlign: TextAlign.center,
                    // ignore: prefer_const_constructors
                    style: TextStyle(
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
