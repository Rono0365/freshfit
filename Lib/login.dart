import 'package:FreshFit/legal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'main.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
//import 'netcloud.dart';
//import 'package:flutter/material.dart';
import 'regs2.dart';
import 'signup.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppL extends StatefulWidget {
  MyAppL({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  @override
  _MyAppLState createState() => _MyAppLState();
}

class _MyAppLState extends State<MyAppL> {
  final titleController = TextEditingController();
  final titleController1 = TextEditingController();
  //final titleController = TextEditingController();
  //final titleController1 = TextEditingController();
  final titleController2 = TextEditingController();
  final titleController3 = TextEditingController();
  final titleController4 = TextEditingController();
  final titleControllerv = TextEditingController();

  var passtok;
  var userid;
  var userid1;
  var userid2;
  var userid3;
  int State = 0;
  int State2 = 0;
  //var passtok;
  String PassToken = '';
  String ID = '';
  final storage = new FlutterSecureStorage();
  //var userid;
  var value;
  //int State = 0;
  Future create1() async {
    http.Response response1 = await http.post(
      Uri.parse('https://afleet.co.ke/registerff/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        //'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        /*
        primadonnna
        */
        'username': titleController.text,
        'password': titleController1.text,
        'password2': titleController2.text,
        'email': titleController3.text,
        'first_name': titleController4.text,
        'last_name': titleControllerv.text,
      }),
    );

    //works => print(token['token']);

    var token = jsonDecode(response1.body);

    print(token);
    print(response1.statusCode);
    //works => print(token['token']);
    setState(() {
      State = response1.statusCode;
    });
    //var token = jsonDecode(response1.body);
  }

  Future logout() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove('token');
    sharedPreferences.remove('key');
    //var idk = sharedPreferences.getString('key');

    print('another one' + PassToken);
    print('another tw' + ID);
  }

  Future getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtoken = sharedPreferences.getString('token');
    var idk = sharedPreferences.getString('key');
    //var idk = sharedPreferences.getString('key');

    setState(() {
      PassToken = obtoken;
      ID = idk;
    });
    print('another one' + PassToken);
    print('another tw' + ID);
  }

  @override
  void initState() {
    widget.title.toString() == ''
        ? getValidation().whenComplete(() {
            PassToken != null
                    ? Future.delayed(Duration.zero, () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyApp(
                                    title: 'Freshfit',
                                    token: PassToken,
                                    userid: ID)));
                      })
                    : Container()
                //MyAppL()
                //.whenComplete(() async {

                ;
            //print("here she comes:" + userid);
          })
        : logout();

    super.initState();
  }

  Future createAlbum() async {
    http.Response response1 = await http.post(
      Uri.parse('https://afleet.co.ke/api-token-auth_forfF/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': titleController.text,
        'password': titleController1.text,
      }),
    );
    print(response1.statusCode);
    //works => print(token['token']);
    setState(() {
      State = response1.statusCode;
    });
    var token = jsonDecode(response1.body);
    print(token);
    if (response1.statusCode == 200) {
      setState(() async {
        passtok = token['token'].toString();
        userid = token['user_id'].toString();
        await storage.write(key: userid, value: passtok);
        value = storage.read(key: userid);
      });

      //});
//save the token for next time

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[700],
        body: PageView(children: [
          Container(
            color: Colors.white,
            child: Card(
              elevation: 0,

                color: Colors.white,
                child: Center(
                    child: Column(children: [
                      Container(height:15,
                      ),
                  //Image.asset('assets/judegroceries-removebg-preview.png'),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.45,
                    child: Container(
                      decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/shop3.png'),
      fit: BoxFit.cover,
    ),
  ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                  
                    width: 350,
                    padding: EdgeInsets.all(3.0),
                    child: Card(
                      elevation:0,
                      color: Colors.grey.shade100.withOpacity(0.2),
                      child:Column(
                        children: [
                           
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.17,
                  ),
                  //https://www.google.com/search?q=illustration+qr+code+drawing&sxsrf=APq-WBvyA863MRv7UgrxoUuglVUDFrRHhQ:1648523831027&tbm=isch&source=iu&ictx=1&vet=1&fir=gkZVKHnUvSESmM%252CYpTeIJ7_t3iUMM%252C_%253BSWMbnmfmxyvzMM%252Cwdng2dY126YtkM%252C_%253BvUcJA6ARjjWbYM%252Cf8Qjb9nHxR1BcM%252C_%253Bo0STY6lj_-dnoM%252C4quweExXGeEGZM%252C_%253Bt_QzcAXML7Gv-M%252CeNcvHA6qMiZqRM%252C_%253BJSiWvVkyQv-pWM%252Cf4gCUS9n_xuspM%252C_%253Bl8BN6QfbWTuFyM%252CilENFJ89gaqY0M%252C_%253BJ9Dg-_9fnUGkNM%252Cp1ssrBPOYBj5IM%252C_%253BZZv9k59aCYIP0M%252C-KAOCPBRIRsm4M%252C_%253BlOMJ-pVYka6Y7M%252Cf4gCUS9n_xuspM%252C_%253BU0Y1zjAnDEpb5M%252CBmlZjyL7xGa4eM%252C_%253B1vHR2KOqJLGBMM%252CU8952bWiHSODlM%252C_%253BFkYGDlKbmubZNM%252CGVIVM7GHjncykM%252C_%253BJvD09eOePrAOKM%252C4quweExXGeEGZM%252C_%253Bcm_Wg1BlTDa5vM%252CTwlHudSGR4KatM%252C_%253BjVwuN8HtKBpLnM%252CPN-TcZ5ImaGpRM%252C_%253BPT39wWSdWlz_PM%252CBmlZjyL7xGa4eM%252C_&usg=AI4_-kSl-z7SOeiaES8h-CeulpcDUSbnnA&sa=X&ved=2ahUKEwiakujqrer2AhUHyKQKHV85CdAQ9QF6BAgREAE#imgrc=o0STY6lj_-dnoM

                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.20,
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Image.asset('assets/carrot.png'),
                    ),
                  ),
                  /*Text(
                    "Freshfit",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                    textAlign: TextAlign.center,
                  ),*/
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.050,
                  ),
                  Text(
                    "Fresh groceries, delivered " + '\n' + "to your doorstep.",
                    style: GoogleFonts.lato(fontWeight: FontWeight.w300, fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                        ],
                      )
                    ),
                  ),
                

                  
                  Text(
                    "",
                  )
                  //Container(height: 100,width: MediaQuery.of(context).size.width,color: Colors.white,)
                ]))),
          ),
        ]),
        
        bottomNavigationBar: Container(
          height:MediaQuery.of(context).size.height*.29,
         
          color: Colors.white,
          child:Column(children:[
            SizedBox(
                    height: MediaQuery.of(context).size.width * 0.15,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.86,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                          
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0),
                            spreadRadius: 0,
                            blurRadius: 0,
                          )
                        ],
                      ),
                      child: FlatButton(
                          onPressed: (() {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  //  sum = 0;
                                  //var given_list = [1, 2, 3, 4, 5];

                                  return Scaffold(
                                    backgroundColor: Colors.yellow[700],
                                    body: Card(
                                      elevation: 0,
                                      color: Colors.yellow[700],
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 60.0),
                                              child: Center(
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                                  child: Image.asset(
                                                      'assets/carrot.png'),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.30,
                                            ),
                                            Padding(
                                              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              child: TextField(
                                                controller: titleController,
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.grey[100],
                                                    //fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0)),
                                                    labelText: 'Username',
                                                    hintText:
                                                        'Enter your username'),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0,
                                                  right: 15.0,
                                                  top: 15,
                                                  bottom: 0),
                                              //padding: EdgeInsets.symmetric(horizontal: 15),
                                              child: TextField(
                                                controller: titleController1,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.grey[100],
                                                    //fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0)),

                                                    //border: OutlineInputBorder(),
                                                    labelText: 'Password',
                                                    hintText:
                                                        'Enter secure password'),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.20,
                                            ),
                                            Container(
                                              height: 50,
                                              width: 250,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: FlatButton(
                                                child: Text(
                                                  'Login',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25),
                                                ),
                                                onPressed: () {
                                                  createAlbum()
                                                      .whenComplete(() async {
                                                    final SharedPreferences
                                                        sharedPreferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    sharedPreferences.setString(
                                                        'token', passtok);
                                                    sharedPreferences.setString(
                                                        'key', userid);
                                                    setState(() {
                                                      PassToken = passtok;
                                                    });
                                                    if (State == 200) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    MyApp(
                                                              title:
                                                                  titleController
                                                                      .text,
                                                              token: passtok,
                                                              userid: userid,
                                                            ),
                                                          ));
                                                      print('exis' + passtok);
                                                    } else {
                                                      print('haiwork');
                                                      const snackBar = SnackBar(
                                                        content: Text(
                                                            "Please Try Again! There's an error with your credentials"),
                                                      );

                                                      // Find the ScaffoldMessenger in the widget tree
                                                      // and use it to show a SnackBar.
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar);
                                                    }
                                                    ;
                                                  });

                                                  //print(State);
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 80,
                                            ),
                                            Text('' + '\n' + '',
                                                textAlign: TextAlign.center)
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }),
                          child: Text(
                            "Login", //changed
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                color: Colors.white),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.051,
                  ),Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:[
                          Container(
                            color:Colors.grey,
                            height:0.27,
                            width: MediaQuery.of(context).size.width*.35,
                          ),
                          Text("or")
                          ,Container(
                            color:Colors.grey,
                            height:0.27,
                            width: MediaQuery.of(context).size.width*.35,
                          )
                          ]),

                        SizedBox(
                          height: 15,
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.14,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.66,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0),
                            spreadRadius: 0,
                            blurRadius: 0,
                          )
                        ],
                      ),
                      child: FlatButton(
                          onPressed: (() {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  //  sum = 0;
                                  //var given_list = [1, 2, 3, 4, 5];

                                  return Scaffold(
                                      backgroundColor: Colors.white,
                                      appBar: AppBar(
                                        centerTitle: true,
                                        elevation: 0.0,
                                        backgroundColor: Colors.white,
                                        title: Text("",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                      ),
                                      body: SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                            ),
                                            Padding(
                                              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              child: TextField(
                                                controller: titleController4,
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.grey[100],
                                                    //fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0)),
                                                    labelText: 'First name',
                                                    hintText:
                                                        'Enter Your first name'),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0,
                                                  right: 15.0,
                                                  top: 15,
                                                  bottom: 0),
                                              child: TextField(
                                                controller: titleControllerv,
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.grey[100],
                                                    //fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0)),
                                                    labelText: 'Second name',
                                                    hintText:
                                                        'Enter Your Second name'),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0,
                                                  right: 15.0,
                                                  top: 15,
                                                  bottom: 0),
                                              //padding: EdgeInsets.symmetric(horizontal: 15),
                                              child: TextField(
                                                controller: titleController3,
                                                //obscureText: true,
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.grey[100],
                                                    //fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0)),

                                                    //border: OutlineInputBorder(),
                                                    labelText: 'Email',
                                                    hintText: 'Enter Email'),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0,
                                                  right: 15.0,
                                                  top: 15,
                                                  bottom: 0),
                                              //padding: EdgeInsets.symmetric(horizontal: 15),
                                              child: TextField(
                                                controller: titleController,
                                                //obscureText: true,
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.grey[100],
                                                    //fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0)),

                                                    //border: OutlineInputBorder(),
                                                    labelText: 'Username',
                                                    hintText:
                                                        'Choose your nickname'),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0,
                                                  right: 15.0,
                                                  top: 15,
                                                  bottom: 0),
                                              //padding: EdgeInsets.symmetric(horizontal: 15),
                                              child: TextField(
                                                controller: titleController1,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.grey[100],
                                                    //fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0)),

                                                    //border: OutlineInputBorder(),
                                                    labelText: 'Password',
                                                    hintText:
                                                        'Enter secure password'),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0,
                                                  right: 15.0,
                                                  top: 15,
                                                  bottom: 0),
                                              //padding: EdgeInsets.symmetric(horizontal: 15),
                                              child: TextField(
                                                controller: titleController2,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.grey[100],
                                                    //fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0)),

                                                    //border: OutlineInputBorder(),
                                                    labelText:
                                                        'Re-enter Password',
                                                    hintText:
                                                        'Enter secure pasword'),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Container(
                                              height: 50,
                                              width: 250,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: FlatButton(
                                                onPressed: () {
                                                  setState(() {
                                                    create1()
                                                        .whenComplete(() async {
                                                      final SharedPreferences
                                                          sharedPreferences =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      sharedPreferences
                                                          .setString(
                                                              'token', passtok);
                                                      sharedPreferences
                                                          .setString(
                                                              'key', userid);
                                                      setState(() {
                                                        PassToken = passtok;
                                                      });
                                                      if (State == 201) {
                                                        showModalBottomSheet(
                                                          context: context,
                                                          builder: (context) {
                                                            return Container(
                                                              child: Center(
                                                                  child: Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                    Text(
                                                                        "User Account Created"),
                                                                    Container(
                                                                      height:
                                                                          50,
                                                                      width:
                                                                          250,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .red,
                                                                          borderRadius:
                                                                              BorderRadius.circular(20)),
                                                                      child:
                                                                          FlatButton(
                                                                        child:
                                                                            Text(
                                                                          'Login',
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 25),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          createAlbum()
                                                                              .whenComplete(() async {
                                                                            final SharedPreferences
                                                                                sharedPreferences =
                                                                                await SharedPreferences.getInstance();
                                                                            sharedPreferences.setString('token',
                                                                                passtok);
                                                                            sharedPreferences.setString('key',
                                                                                userid);
                                                                            setState(() {
                                                                              PassToken = passtok;
                                                                            });
                                                                            Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                    builder: (context) => MyApp(
                                                                                      title: titleController.text,
                                                                                      token: passtok,
                                                                                      userid: userid,
                                                                                    ),
                                                                                  ))
                                                                            ;
                                                                          });

                                                                          //print(State);
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ])),
                                                            );
                                                          },
                                                        );
                                                      } else {
                                                        print('haiwork');
                                                        const snackBar =
                                                            SnackBar(
                                                          content: Text(
                                                              " Please Try Again! There's an error with your credentials"),
                                                        );

                                                        // Find the ScaffoldMessenger in the widget tree
                                                        // and use it to show a SnackBar.
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackBar);

                                                        ;
                                                      }
                                                    });
                                                  }
                                                      // createAlbumX();
                                                      );
                                                },
                                                child: State == 400
                                                    ? Text(
                                                        'Continue',
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 25),
                                                      )
                                                    : Text(
                                                        'Continue',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 25),
                                                      ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 130,
                                            ),
                                            Text('© 2023' + '\n' + '',
                                                textAlign: TextAlign.center)
                                          ],
                                        ),
                                      ));
                                });
                          }),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          )),
                    ),
                  ),
                  SizedBox(height:15),
            Center(child:Wrap(children:[Text("By Signing in to our app, you are agreeing to our "),InkWell(
            onTap:(){
              Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                legal2(
                                                                    darkmode:
                                                                        false) //screen(),
                                                            ), //MaterialPageRoute
                                                      );
            },
            child: Text("terms and conditions",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                //fontSize: 20,
                                color: Colors.green),))])) ]),),
        );
  }
}
