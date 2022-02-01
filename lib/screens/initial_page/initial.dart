import 'package:flutter/material.dart';
import 'package:travel/screens/home_page/home.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 1200), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent[700],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
                child: Container(
                  // height: MediaQuery.of(context).size.height - 50,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/capa.png'),
                      fit: BoxFit.cover,
                    ),
                    //color: Colors.grey,
                  ),
                  //color: Colors.grey,
                ),
              ),
            ),
            const Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(50.0),
                child: Text(
                  'Travell.com',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
