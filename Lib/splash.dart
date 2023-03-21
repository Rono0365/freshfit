import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';
import 'login.dart';

class screen extends StatefulWidget {
  const screen({Key? key}) : super(key: key);

  @override
  _screenState createState() => _screenState();
}

class _screenState extends State<screen> {
  @override
  void initState() {
    super.initState();
    _navtohome();
  }

  _navtohome() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => MyAppL(title:'')));//MyHomePage(title: "myRiara")
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.20,
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Image.asset('assets/carrot.png'),
                    ),
                  ),
                  Text(
                    "Freshfit",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.050,
                  ),
                  Text(
                    "Fresh groceries, delivered " + '\n' + "to your doorstep.",
                    style: GoogleFonts.lato(fontWeight: FontWeight.w300, fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
          
              
        ],
      )),
      bottomNavigationBar: Container(
              height: MediaQuery.of(context).size.width * 0.10,
              width: MediaQuery.of(context).size.width * 0.10,
              child: Text("",style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
    );
  }
}

         
           