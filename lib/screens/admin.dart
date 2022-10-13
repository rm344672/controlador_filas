import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/usuarios.dart';
import '../models/Filas.dart';

class AdminWidget extends StatefulWidget {
  const AdminWidget({Key? key}) : super(key: key);

  @override
  State<AdminWidget> createState() => _AdminWidgetState();
}

class _AdminWidgetState extends State<AdminWidget> {

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
            onPressed: () async {

              Filas? filas = await getFila();

              if (filas.pos_atual! <= filas.ultima_pos!) {
                updateFila();
              } else {
                // ignore: use_build_context_synchronously
                exibeAlerta(context, "Não existe mais usuários na fila");
              }
              
            }, 
            label: const Text('Chamar Próximo')),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        drawer: Drawer(
          child: ListView(
            children: [
              Divider(),
              Expanded(
                  child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: ListTile(
                  title: const Text('Exit'),
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
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LinearProgressIndicator();
          if (snapshot.data == null) {
            return Container(child: const Text("Nenhum usuário na fila"));
          } else {
            return buildNomeProximoFila(context, snapshot.data!.docs);
          }
        });
  }

  buildNomeProximoFila(
    BuildContext context, List<QueryDocumentSnapshot> snapshot) {
    Filas fila = Filas.fromSnapshot(snapshot[0]);
    final proximoNaFila = fila.pos_atual;

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


  Future<Filas> getFila () async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
    .collection("fila")
    .get();  

    Filas filas = Filas.fromSnapshot(snapshot.docs.first);

    return filas;

  }
  updateFila() async{

    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
    .collection("fila")
    .get(); 

      DocumentSnapshot element = snapshot.docs.first;
      FirebaseFirestore.instance.collection("fila")
      .doc(element.id)
      .update({"pos_atual": FieldValue.increment(1)});   

  }

  exibeAlerta(BuildContext context, String texto) {
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text("Alerta"),
        content: Text(texto)
      );
    });
  }
}
