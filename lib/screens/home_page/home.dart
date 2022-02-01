import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel/screens/add_hotel/add_hotel.dart';
import 'package:travel/screens/details_hotel/hotel.dart';
import 'package:travel/screens/details_page/detail.dart';
import 'package:travel/screens/initial_page/initial.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firebase = FirebaseFirestore.instance;
  int _selectedIndex = 0;
  PageController pageController = PageController();

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent[700],
      body: PageView(
        controller: pageController,
        children: [
          //const InitialPage(), chama a pagina
          HomeItems(),
          const AdicionarHotel(),
          //HotelPage(),
          // DetailPage(),
          // Container(color: Colors.yellow),
          // Container(
          //   color: Colors.lightBlue,
          // ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add, size: 30), label: 'Adicionar'),
          //BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.orange[900],
        backgroundColor: Colors.teal,
        onTap: onTapped,
      ),
    );
  }

  Widget HomeItems() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  "Travel.com",
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                      ),
                      // child: TextFormField(
                      //   style: TextStyle(fontSize: 20, color: Colors.black),
                      // ),
                    ),
                  ),
                  // const Icon(
                  //   Icons.search,
                  // ),
                ],
              ),
              Anuncio(),
              ItemList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget Anuncio() {
    return Container(
        height: 140,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(
              "https://picsum.photos/250?image=9",
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.darken,
            ),
          ),
          //color: Colors.grey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, bottom: 10),
              child: Text(
                "Anuncios",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
          ],
        ));
  }

  Widget ItemList() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: firebase.collection("places").snapshots(),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                      nome: valor['nome'],
                                      detalhes: valor['detalhes'],
                                      img: valor['img'],
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
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
