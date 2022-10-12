import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/usuarios.dart';
import '../models/filas.dart';

class AdminWidget extends StatefulWidget {
  const AdminWidget({Key? key}) : super(key: key);

  @override
  State<AdminWidget> createState() => _AdminWidgetState();
}

class _AdminWidgetState extends State<AdminWidget> {
  String proximoNaFila = "1";

  Usuario? currentUser = null;
  getCurrentUser() async {
    String? emailUserLogged = FirebaseAuth.instance.currentUser?.email;

    var findUserByEmail = await FirebaseFirestore.instance
        .collection("usuarios")
        .where("email", isEqualTo: emailUserLogged)
        .get();
  
    Usuario user = Usuario.fromSnapshot(findUserByEmail.docs.first);
    setCurrentUser(user);
  }

  setCurrentUser(Usuario user) {
    currentUser = user;
  }

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Controle de filas - Admin")),
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
              buildInfoUser(context),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => {}, label: const Text('Chamar Próximo')),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        drawer: Drawer(
          child: ListView(
            children: [
              Divider(),
              Expanded(
                  child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: ListTile(
                  title: Text('Exit'),
                  onTap: () => {
                    FirebaseAuth.instance.signOut(),
                    Navigator.pushNamed(context, '/')
                  },
                ),
              ))
            ],
          ),
        ));
  }

  Widget buildInfoUser(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("fila")
            .orderBy("id_atual", descending: false)
            .limit(1)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LinearProgressIndicator();
          if (snapshot.data == null) {
            return Container(child: const Text("Nenhum carro encontrado"));
          } else {
            return buildNomeProximoFila(context, snapshot.data!.docs);
          }
        });
  }

  buildNomeProximoFila(
      BuildContext context, List<QueryDocumentSnapshot> snapshot) {
    Filas fila = Filas.fromSnapshot(snapshot[0]);
    final proximoNaFila = fila.id_atual;
    //final nomeUser = getUser(fila.doc_user);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Positioned(
            child: Align(
          alignment: FractionalOffset.center,
          child: Center(
            child: Text("$proximoNaFila",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontSize: 32)),
          ),
        ))
      ],
    );
  }

  Future<String> getUser(docUser) async {
    var findNextUserByFila = await FirebaseFirestore.instance
        .collection("usuarios")
        .doc(docUser)
        .get();

    return Usuario.fromJson(findNextUserByFila).nome;
  }
}
