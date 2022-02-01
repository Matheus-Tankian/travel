import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel/screens/details_hotel/hotel.dart';
import 'package:travel/screens/home_page/home.dart';

class DetailPage extends StatefulWidget {
  final String nome;
  final String detalhes;
  final String img;

  const DetailPage({
    Key? key,
    required this.nome,
    required this.detalhes,
    required this.img,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final firebase = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent[700],
        title: Text("Detalhes"),
      ),
      backgroundColor: Colors.tealAccent[700],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.img),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      child: Text(
                        //nome aqui
                        widget.nome,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  InfoLugar(),
                ],
              ),
              Container(
                //color: Colors.blue,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 20),
                          child: Container(
                            height: 60,
                            child: const Center(
                              child: Text(
                                "Hoteis ao arredor",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),

                        // Container(
                        //   child: Icon(
                        //     Icons.home,
                        //     size: 40,
                        //     color: Colors.grey[800],
                        //   ),
                        // ),
                        // Container(
                        //   child: Icon(
                        //     Icons.home,
                        //     size: 40,
                        //     color: Colors.grey[800],
                        //   ),
                        // ),
                      ],
                    ),
                    HotelList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget InfoLugar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        child: Expanded(
          flex: 2,
          child: Text(
            //info aqui
            widget.detalhes,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget HotelList() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: firebase.collection("hotel").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    QueryDocumentSnapshot valor = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: GestureDetector(
                        onTap: () {
                          String nome;
                          String detalhes;
                          String img;
                          String preco;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HotelPage(
                                      nome: valor['nome'],
                                      detalhes: valor['detalhes'],
                                      img: valor['img'],
                                      preco: valor['preco'],
                                    )),
                          );
                        },
                        child: Container(
                          height: 140,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(valor['img']),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.4),
                                BlendMode.darken,
                              ),
                            ),
                            color: Colors.blueGrey,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    valor['nome'],
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
