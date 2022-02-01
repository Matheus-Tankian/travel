import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdicionarHotel extends StatefulWidget {
  const AdicionarHotel({Key? key}) : super(key: key);

  @override
  _AdicionarHotelState createState() => _AdicionarHotelState();
}

class _AdicionarHotelState extends State<AdicionarHotel> {
  TextEditingController nomeHotel = TextEditingController();
  TextEditingController detalhesHotel = TextEditingController();
  TextEditingController urlHotel = TextEditingController();
  TextEditingController precoHotel = TextEditingController();

  final firebase = FirebaseFirestore.instance;

  create() async {
    try {
      await firebase.collection("hotel").doc(nomeHotel.text).set({
        "detalhes": detalhesHotel.text,
        "img": urlHotel.text,
        "nome": nomeHotel.text,
        "preco": precoHotel,
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.tealAccent[700],
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Container(
                    child: const Text(
                      'Adicionar Hotel',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    controller: nomeHotel,
                    decoration: InputDecoration(
                      labelText: "Nome do Hotel",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: detalhesHotel,
                  decoration: InputDecoration(
                    labelText: "Detalhes do Hotel",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: urlHotel,
                  decoration: InputDecoration(
                    labelText: "Link da Imagen do Hotel",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: precoHotel,
                  decoration: InputDecoration(
                    labelText: "Preço",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      create();
                      // nomeHotel.clear();
                      // detalhesHotel.clear();
                      // precoHotel.clear();
                      // urlHotel.clear();
                      print("teste");
                    },
                    child: Container(
                      height: 80,
                      width: 200,
                      //color: Colors.teal[900],
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.teal[900],
                      ),
                      child: const Center(
                        child: Text(
                          "Adicionar",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // ElevatedButton(
                //   style: TextButton.styleFrom(backgroundColor: Colors.green),
                //   onPressed: () {
                //     create();
                //   },
                //   child: Text(
                //     'Create',
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
