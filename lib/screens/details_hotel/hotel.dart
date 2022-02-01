import 'package:flutter/material.dart';

class HotelPage extends StatefulWidget {
  final String nome;
  final String detalhes;
  final String img;
  final String preco;

  const HotelPage({
    Key? key,
    required this.nome,
    required this.detalhes,
    required this.img,
    required this.preco,
  }) : super(key: key);

  @override
  _HotelPageState createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent[700],
        title: Text("Iformações sobre o hotel"),
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
                //color: Colors.grey,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 20),
                          child: Container(
                            height: 60,
                            child: const Center(
                              child: Text(
                                "Estadia",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, right: 20),
                          child: Container(
                            height: 60,
                            child: Center(
                              child: Text(
                                widget.preco + "R\$\ ",
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
            widget.detalhes,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
