//freshfit ~ Upon this rock i will build my church
import 'dart:developer';
import 'dart:core';
import 'dart:async';
import 'package:FreshFit/receipt.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:place_picker/place_picker.dart';
import 'login.dart';
import 'ad_helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_beep/flutter_beep.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'legal.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';
import 'main.dart';
import 'orders.dart';
import 'payments.dart';
import 'preorder.dart';
//import 'mpesa.dart';
import 'shoppinglist.dart';

import 'thank.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'restaurants.dart';
import 'package:collection/collection.dart';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notifications.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'search2.dart';
import 'imgechange.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mpesa/mpesa.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:showcaseview/showcaseview.dart';
import 'dart:math';

class Rutimetable extends StatefulWidget {
  Rutimetable(
      {Key? key,
      required this.title,
      required this.token,
      required this.user,
      required this.id,
      required this.firstname,
      //required this.food1,
      required this.me})
      : super(key: key);
//, required this.title
  final String title;
  final String token;
  final String user;
  final String id;
  final String firstname;

  //final String food1;
  final String me;

  @override
  _RutimetableState createState() => _RutimetableState();
}

class _RutimetableState extends State<Rutimetable> {
  bool lang1 = false;
  var lang2;

  Future<void> startCheckout(
      {required String userPhone, required double amount}) async {
    //Preferably expect 'dynamic', response type varies a lot!
    dynamic transactionInitialisation;
    //Better wrap in a try-catch for lots of reasons.
    try {
      //Run it
      transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: amount,
          partyA: userPhone,
          partyB: "174379",
          callBackURL:
              Uri(scheme: "https", host: "1234.1234.co.ke", path: "/1234.php"),
          accountReference: "${widget.me}",
          phoneNumber: userPhone,
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          transactionDesc: "purchase",
          passKey:
              'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919');

      print("TRANSACTION RESULT: " +
          transactionInitialisation['MerchantRequestID']);
      setState(() {
        transactionInitialisationx = transactionInitialisation.toString();
      });
      //You can check sample parsing here -> https://github.com/keronei/Mobile-Demos/blob/mpesa-flutter-client-app/lib/main.dart

      /*Update your db with the init data received from initialization response,
      * Remaining bit will be sent via callback url*/
      return transactionInitialisation;
    } catch (e) {
      //For now, console might be useful
      print("CAUGHT EXCEPTION: " + e.toString());

      /*
      Other 'throws':
      1. Amount being less than 1.0
      2. Consumer Secret/Key not set
      3. Phone number is less than 9 characters
      4. Phone number not in international format(should start with 254 for KE)
       */
    }
  }

  //change this
  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();
  String selectedValue = "Settings";
  retball() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey.withOpacity(0.5)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon(Icons.check),
          
          CircleAvatar(
                                                    radius: 13,
          child:Center(child:Container(
              height: 20, width: 20, child: Image.asset("assets/carrot.png")),)),
          (int.parse(generateRandomString2(1)) / 7) != 0
              ? lang2 != "Kiswahili (🇰🇪)"
                  ? Text(
                      " ${generateRandomString(1)}******${generateRandomString2(1)}" +
                          " just completed an Order",style:TextStyle(color:darkmode?Colors.white:Colors.black))
                  : Text(
                      "${generateRandomString(1)}******${generateRandomString2(1)}" +
                          " Amekamilisha Order",style:TextStyle(color:darkmode?Colors.white:Colors.black))
              : lang2 != "Kiswahili (🇰🇪)"
                  ? Text(
                      "${generateRandomString(1)}******${generateRandomString2(1)}" +
                          "+ 5 others made a group order",style:TextStyle(color:Colors.yellow))
                  : Text(
                      "${generateRandomString(1)}******${generateRandomString2(1)}" +
                          " na Wengine 5 walifanya agizo la kikundi",style:TextStyle(color:darkmode?Colors.white:Colors.black)),
        ],
      ),
    );

    flutterToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP_RIGHT,
      toastDuration: const Duration(seconds: 2),
    );
  }

  String generateRandomString(int lengthOfString) {
    final random = Random();
    const allChars = 'AaBbCcDdlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL';
    // below statement will generate a random string of length using the characters
    // and length provided to it
    final randomString = List.generate(lengthOfString,
        (index) => allChars[random.nextInt(allChars.length)]).join();
    return randomString; // return the generated string
  }

  String generateRandomString2(int lengthOfString) {
    final random = Random();
    const allChars = '123456789';
    // below statement will generate a random string of length using the characters
    // and length provided to it
    final randomString = List.generate(lengthOfString,
        (index) => allChars[random.nextInt(allChars.length)]).join();
    return randomString; // return the generated string
  }

  String generateRandomString3(int lengthOfString) {
    final random = Random();
    const allChars = '172839465';
    // below statement will generate a random string of length using the characters
    // and length provided to it
    final randomString = List.generate(lengthOfString,
        (index) => allChars[random.nextInt(allChars.length)]).join();
    return randomString; // return the generated string
  }

  bool darkmode = false;
  bool salenote = false;
  bool notification = false;
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  late BannerAd _bannerAd;
  // TODO: Add _isBannerAdReady
  bool _isBannerAdReady = false;

  xls(String order) {
    return Ninotify.showNotification(
      id: 2,
      title: order,
      body: 'Your order is ready',
      payload: 'r',
    );
  }

  //const Rutimetable({Key? key}) : super(key: key);
  var sky;
  var picpic;
  var leo;
  String transactionInitialisationx = '';
  bool xon = false;

  //var newthing();
  var now;
  late var selectedTime = TimeOfDay.now();
  kisw(String X) {
    var a;
    var b = {
      "vegetables": "mboga",
      "Fruits": "Matunda",
      "Herbs and Spices": "viungo vya upishi",
      "Cereals": "nafaka"
    };
    a = b[X];
    return a.toString();
  }

  Future mpesacall() {
    return showModalBottomSheet(
        //isScrollControlled: true,
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .3,
            child: Column(children: [
              //Text(wild.toString()),

              ListTile(
                onTap: () {
                  //showPlacePicker();
                },
                //leading: Icon(Icons.phone),
                title: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .7,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 15, bottom: 0),
                            //padding: EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: titleController4,
                              obscureText: false,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  //fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),

                                  //border: OutlineInputBorder(),
                                  labelText: 'Mpesa phone number',
                                  hintText: 'Enter your Mpesa Phone number'),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .1,
                          child: FloatingActionButton(
                            mini: true,
                            onPressed: () {},
                            child: const Icon(Icons.done),
                          ),
                        ),
                      ]),
                ),
              ),
              const ListTile(

                  //leading: Icon(Icons.location_pin),
                  //title: const Text("My delivery Address"),
                  ),
              ListTile(
                title: Text("",
                    style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                onTap: () {
                  ;
                  //get out of my app
                },
              ),
            ]),
          );
        });
  }

  searchfoodz() {
    week_area = DateFormat('d MMM').format(DateTime.now());
    leo = DateFormat.jm().format(DateTime.now());
    now = DateFormat('EEEE d MMM')
        .format(DateTime.now()); //returns json body from api
    print(leo);
    //this.courseblock = result1;
    var titleController;
    titleController.text = '';
    List rono = food7;
    bool woz = true; //yea i was listening to steve wozniak
    List chosen = [];

    String transactionInitialisationx = '';
    String works = '';
    KeyboardVisibilityController().onChange.listen((event) {
      setState(() {
        softkey = event;
        if (softkey == true) {
          works = 'ollo';
        }
        ;
      });

      print("THE KEYBOARD" + softkey.toString());
    });

    num sum = 0;
    for (num e in amount) {
      sum += e;
      print(sum);
      //sumx = sum;
    }
    List ronox;
    void sq(List x) {
      setState(() => ronox = x);
      //print(ronox);

      //rono was here 5/20/22~2:29am
      //rono was here again 6/9/22~4:15am
      //rono was here again 1/10/23~2:20pm
    }

    print('search bar' + titleController.text);
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              //Text(wild.toString()),
              const ListTile(),
              ListTile(
                  onTap: () {
                    //showPlacePicker();
                  },
                  //leading: Icon(Icons.phone),
                  title: Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    color: darkmode ? Colors.white : Colors.black,
                    child: Padding(
                      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        onTap: () {
                          woz = true;
                          print(rono);
                          sq(rono
                              .where(
                                (x) => x['name'].toLowerCase().contains(''),
                                //print(x);
                              )
                              .toList());
                        },
                        //actions:[],
                        onChanged: (text) {
                          //print(rono[0]['food'][0]['name']);

                          //print("can't get this" + rono.toString());

                          woz = true;

                          sq(rono
                              .where(
                                (x) => x['name']
                                    .toLowerCase()
                                    .contains(text.toLowerCase()),
                                //print(x);
                              )
                              .toList());
                          print(rono.first);
                        },

                        autofocus: false,
                        controller: titleController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search,
                                color: darkmode ? Colors.white : Colors.black),
                            suffixIcon: woz
                                ? InkWell(
                                    child: Icon(Icons.close,
                                        color: darkmode
                                            ? Colors.white
                                            : Colors.black),
                                    onTap: () {
                                      //woz = true;

                                      titleController.clear();
                                      titleController.text = '';
                                      print('was here');
                                    },
                                  )
                                : Container(),
                            filled: true,
                            fillColor:
                                !darkmode ? Colors.white : Colors.grey.shade800,
                            //fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(60.0)),
                            //labelText: 'Search',
                            hintText: 'Type to Search and see suggestions'),
                      ),
                    ),
                  )),
              const ListTile(

                  //leading: Icon(Icons.location_pin),
                  //title: const Text("My delivery Address"),
                  ),
              ListTile(
                title: Text("",
                    style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                onTap: () {
                  ;
                  //get out of my app
                },
              ),
            ]),
          );
        });
  }

  var week_area;
  bool pressedCart = true;
  var wild;
  var wild2;
  late var titleController4 = TextEditingController();

  Future getWeather() async {
    MpesaFlutterPlugin.setConsumerKey('rjDWHXkZ3RX5Gy4xDvNztA6ARJQo6gQx');
    MpesaFlutterPlugin.setConsumerSecret('kL2L4KMvGhZDqIZn');

    String token = widget.token;
    //https://afleet.co.ke/restaurant/ http://172.16.12.17:8000/
    print('rono' + token);
    //print(widget.token); wasn't easy but never stopped
    var headers = {
      'Authorization': 'Token ${token}',
    };
    http.Response responsev = await http.get(
        Uri.parse('https://afleet.co.ke/restaurant/' + widget.title),
        headers: headers);
    http.Response picpic1 = await http
        .get(Uri.parse('https://afleet.co.ke/profpic/'), headers: headers);
    var results = jsonDecode(responsev.body);
    var picpic = jsonDecode(picpic1.body);
    setState(() {
      this.sky = results;
      this.picpic = picpic;
      /*[{name: bevarage, caption: hot sweet drinks ... you'll come back for more, food: [{name: vanilla latte, price: 250}, {name: Chips, price: 100}, {name: burger, price: 150}, {name: black coffee, price: 100}, {name: capucchino, price: 150}, {name: esspreso, price: 100}]}, {name: fastfood&drinks, caption: delicacies ... you'll come back for more, food: [{name: vanilla latte, price: 250}, {name: Chips, price: 100}, {name: burger, price: 150}, {name: black coffee, price: 100}, {name: capucchino, price: 150}, {name: esspreso, price: 100}, {name: croissant, price: 250}, {name: blackforrest, price: 250}, {name: red velvet, price: 250}, 
{name: Pilau, price: 100}]}]
*/
      //sky['menu'][0]['menu'] -this is the menu
      //sky['menu'][0]['menu'][0]['name'] this is the categries
      print(sky);
    });
    setState(() {
      //DateFormat('EEEE').format(date);
      this.week_area = DateFormat('d MMM').format(DateTime.now());
      this.leo = DateFormat.jm().format(DateTime.now());
      this.now = DateFormat('EEEE d MMM')
          .format(DateTime.now()); //returns json body from api
      print(leo);
      //this.courseblock = result1;
    });
  }

  Widget spacer() {
    return Container(
      width: 5.0,
    );
  }

  Widget line() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.4),
          borderRadius: const BorderRadius.all(
              Radius.circular(10.0) //                 <--- border radius here
              )),
      height: 5.0,
      width: 50.0,
    );
  }

  List<List> cart = [];
  List amount = [];
  var quantity;
  List<List> cart2 = [];
  List amount2 = [];
  List amount3 = [];
  var food2;
  var mpesanumber;
  var food7;
  bool address = false;
  var quantity2;
  bool softkey = false;
  void _increase(var i) {
    final prev = ii;
    ii = i;
    if (prev != ii) {
      quantity = 1;
    }
    quantity++;
  }

  bool settings = false;
  bool legal = true;

  void showPlacePicker() async {
    LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker("AIzaSyA7fRUg_vYd8Q3lxCiGo9IKsIIVgrAT564")));

    // Handle the result in your way
    //print(result);F
    setState(() {
      wild = result?.name;
      wild2 = result?.latLng;
    });
    this.wild = result?.name;
    //print(wild);
    // Navigator.pop(context);
    //Navigator.pop(context);
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.

    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.QR);
    print(barcodeScanRes);

    //here's  functs
    //final _controller = ScrollController();

    void senE(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Invalid "),
          content: const Text("Didn't get the qrcode"),
        ),
      );
    }

    String _scanBarcode = 'Unknown';

    //add the http request here

    setState(() {
      _scanBarcode = barcodeScanRes;
      print(_scanBarcode.toString());
      final id = _scanBarcode.length;
      print(barcodeScanRes.substring(2, id));
      //this.getScan(_scanBarcode.toString());
    });
    //if (barcodeScanRes != true) return _launchURL(_scanBarcode.toString());

    if (barcodeScanRes.toString() != '-1' &&
        barcodeScanRes.toString().split('|')[0] == "AfleetUser") {
      print(barcodeScanRes.length);
      FlutterBeep.beep();
      Navigator.pop(
        context,
      );
      //following functions pushes collected data  to the api
      // getScan(barcodeScanRes.toString());
      //getScan2(barcodeScanRes.toString());
    } else {
      senE(context);
    }
  }

  Future addtocart() async {
    String token = widget.token;
    var headers = {
      'Authorization': 'Token ${token}',
    };
    http.Response responsex =
        await http.post(Uri.parse('http://172.16.12.17:8000/cart/'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Token $token',
            },
            body: jsonEncode(<String, String>{
              'count': quantity.toString(),
              'food': amount2.toString(), //list for food
              //'customer':now.toString()+'\t ,'+leo.toString(),
            }));
  }

  Future addata(String otype, String zum, String otime, String oname) async {
    String token = widget.token;
    //print('ruined sum' + zum.toString());
    //print('rono' + token);
    //print(widget.token); wasn't easy but never stopped
    var headers = {
      'Authorization': 'Token ${token}',
    };
    http.Response responsev =
        await http.post(Uri.parse('https://afleet.co.ke/orderff/'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Token $token',
            },
            body: jsonEncode(<String, String>{
              'table': widget.user.toString(),
              'food': '${amount2.toString()}', //list for food
              'restaurantx': sky['username'].toString(),
              'time': now.toString() + '\t ,' + leo.toString(),
              'owner': widget.me.toString(),

              'totalprice': zum.toString(),
              'ordertype': otype.toString(),
              'ordername': oname.toString(),
              'ordertrak': 'not ready',
              'ordertime': otime.toString(),
              //'customer':now.toString()+'\t ,'+leo.toString(),
            }));
    //returns json body from api
    //var resultsX = jsonDecode(responsevX.body); //returns json body from api
  }

  Future getfood() async {
    String token = widget.token.toString();
    //String id = widget.userid.toString();

    //print(widget.token); wasn't easy but never stopped
    var headers = {
      'Authorization': 'Token $token',
    };
    http.Response responsev = await http
        .get(Uri.parse('https://afleet.co.ke/foodff/'), headers: headers);
    http.Response responsej = await http
        .get(Uri.parse('https://afleet.co.ke/orderff/'), headers: headers);    
    var xcv = jsonDecode(responsev.body);
     var xcv2 = jsonDecode(responsej.body);
    setState(() {
      food7 = xcv;
      food2 = xcv2;
    });
    
  }

  Future getWealth() async {
    String token = widget.token.toString();
    //String id = widget.userid.toString();

    //print(widget.token); wasn't easy but never stopped
    var headers = {
      'Authorization': 'Token $token',
    };
    raw() async {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setBool('darkmode', darkmode);
      sharedPreferences.setBool('salenote', salenote);
      sharedPreferences.setString('lang2', lang2);

      sharedPreferences.setString('sky', json.encode(sky));
      sharedPreferences.setString('food2', json.encode(food2));
      sharedPreferences.setString('food7', json.encode(food7));
      sharedPreferences.setString('cart', json.encode(cart));
      sharedPreferences.setString('wild', json.encode(wild));
      sharedPreferences.setString('wild2', json.encode(wild2));
      //sharedPreferences.setString('titleController4', json.encode(titleController4));
    }

    ;
    //raw();
    setState(() {
      //food2 = xcv;
      raw();
    });
    //print(food1);
  }

  Future getWealth2() async {
    String token = widget.token.toString();
    //String id = widget.userid.toString();

    //print(widget.token); wasn't easy but never stopped
    var headers = {
      'Authorization': 'Token $token',
    };
    http.Response responsev = await http
        .get(Uri.parse('https://afleet.co.ke/orderff/'), headers: headers);
    var xcv = jsonDecode(responsev.body);
    

    ;
    //raw();
   
      food2 = xcv;
      
  
    //print(food1);
  }

  

  Future createAlbumx(
      String sender, String message_me, String receiver, String time) async {
    //print(utf8.encode(titleController.text));
    http.Response response1 = await http.post(
      Uri.parse('https://afleet.co.ke/chatff/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, //'id','sender','message_me','receiver','time'
      body: jsonEncode(<String, String>{
        //'id': titleController.text,this is an autofield
        'name': 'Groupbuy', //groupbuy
        'sender': sender, //widget.me.toString(), //you
        'message_me':
            message_me, //'${amount2.toString()}', //ie '2/rono|re|amount|3
        'receiver': receiver,
        //widget.user.split('|')[0].split('/')[1].toString(), //parent user
        'time': time
        //now.toString() + '|' + leo.toString(),
      }),
    );
    //print(jsonDecode(response1.data.toString()) );
    //works => print(token['token']);

    if (response1.statusCode == 201) {
      print("yea it happened");
      print(jsonDecode(response1.body.toString()));
    }
  }

  void decrease(String i) {
    final prev = ii;
    ii = i;
    if (prev != ii) {
      quantity = 1;
    }
    quantity--;
  }

  String ii = '1';
  late FlutterToast flutterToast;
  orderzangu() {
    var counter = 30;
    Timer.periodic(Duration(seconds: int.parse(generateRandomString3(2))),
        (timer) {
      //http req to  and from server
      counter++;

      if (counter == 0) {
        counter = 15;
        print('Cancel timer');
        timer.cancel();
      } else {
        salenote ? '' : retball();
      }
      ;
    });
  }

  @override
  void initState() {
    super.initState();
    onoop() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
/*
sharedPreferences.setString('yoi', yoi.toString());
    //value3 == null && value == null
    sharedPreferences.setString('this2', this2.toString());
    sharedPreferences.setString('info3', info3.toString());
    sharedPreferences.setString('profpic', profpic.toString());
    //value3 == null && value == null
    sharedPreferences.setString('alone', alone.toString());
*/
    var mode = sharedPreferences.getBool('darkmode'); //
    var o6 = sharedPreferences.getBool('salenote');
    //var o2 = jsonDecode(sharedPreferences.getString('cart'));
    var o3 = jsonDecode(sharedPreferences.getString('food2'));
    var o4 = jsonDecode(sharedPreferences.getString('food7'));
    //var o5 = jsonDecode(sharedPreferences.getString('sky'));
    //var o6 = jsonDecode(sharedPreferences.getString('salenote'));
    var o7 = jsonDecode(sharedPreferences.getString('wild'));

    var o8 = jsonDecode(sharedPreferences.getString('wild2'));
    var o9 = sharedPreferences.getString('lang2');
    //var oo = jsonDecode(sharedPreferences.get('sky2'));
    // = jsonDecode(
    //cart = o2; //jsonDecode(o2);

    setState(() {
      food2 = o3; //jsonDecode(o3);
      food7 = o4;
      lang2 = o9;
      darkmode = mode;
      salenote = o6;
      //sky = o5;
      //titleController4 = o6;
      wild = o7;
      wild2 = o8;
    });
    //this.press = o9;
    //this.sky2 = oo;
  }
    
  onoop();
  
    orderzangu();
     getWealth2();
    getWealth();

    getfood();
   

    flutterToast = FlutterToast(context);
    getWeather();

    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    //_bannerAd * sky3.length;
    _bannerAd.dispose();
    _bannerAd.load();

    //var initializationSettingsAndroid = new AndroidInitializationSettings('@mipmap/ic_launcher');
  }

  @override
  void dispose() {
    //raw();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    raw() async {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        sharedPreferences.setString('food2', json.encode(food2));
        sharedPreferences.setBool('darkmode', darkmode);
      sharedPreferences.setBool('salenote', salenote);
      sharedPreferences.setString('lang2', lang2);

      sharedPreferences.setString('sky', json.encode(sky));
      sharedPreferences.setString('food2', json.encode(food2));
      sharedPreferences.setString('food7', json.encode(food7));
      sharedPreferences.setString('cart', json.encode(cart));
      sharedPreferences.setString('wild', json.encode(wild));
      sharedPreferences.setString('wild2', json.encode(wild2));
      
        //sharedPreferences.setString('now', json.encode(now));
      }
    raw();
    
    //onoop();
    
    
    String works = '';
    
    KeyboardVisibilityController().onChange.listen((event) {
      setState(() {
        softkey = event;
        if (softkey == true) {
          works = 'ollo';
        }
        ;
      });

      print("THE KEYBOARD" + softkey.toString());
    });

    num sum = 0;
    for (num e in amount) {
      sum += e;
      print(sum);
      //sumx = sum;
    }

    //final sum = amount.sum;
    //var _scaffoldKey;

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey(); // Create a key
    Color scaffold1 = darkmode ? Colors.black : Colors.white;
    Color text1 = darkmode ? Colors.white : Colors.black;
    Color icon1 = darkmode ? Colors.grey : Colors.grey.shade700;
 
    return sky != null
        ? WillPopScope(
            onWillPop: () => Future.value(false),
            child: MaterialApp(
              color: scaffold1,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.green,
              ),
              home: Scaffold(
                body: ShowCaseWidget(
                  onStart: (index, key) {
                    //log('onStart: $index, $key');
                  },
                  onComplete: (index, key) {
                    //log('onComplete: $index, $key');
                  },
                  builder: Builder(
                    builder: (context) => DefaultTabController(
                        length: sky['menu'][0]['menu'].length + 1,
                        child: Scaffold(
                            //key: _scaffoldKey,
                            backgroundColor: scaffold1,
                            drawer: Drawer(
                                //isScrollControlled: true,

                                child: Scaffold(
                              backgroundColor: scaffold1,
                              appBar: PreferredSize(
                                preferredSize:
                                    MediaQuery.of(context).size.height > 700
                                        ? Size.fromHeight(
                                            MediaQuery.of(context).size.height *
                                                .17)
                                        : Size.fromHeight(
                                            MediaQuery.of(context).size.height *
                                                .4250959),
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Card(
                                      color: scaffold1,
                                      elevation: 0,
                                      child: Column(children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .05,
                                        ),
                                        Row(children: [
                                          Container(width: 4),
                                          Stack(children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          chang(
                                                            username:
                                                                "${widget.firstname}${widget.id}",
                                                            mode: darkmode,
                                                            lang2: lang2,
                                                          )
                                                      //screen(),
                                                      ), //MaterialPageRoute
                                                );
                                              },
                                              child: CircleAvatar(
                                                  radius: 22,
                                                  child: Stack(children: [
                                                    Center(
                                                      child: Text(
                                                          "${widget.firstname.substring(0, 1)}",
                                                          style: GoogleFonts.lato(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                    ...picpic
                                                        .where((c) =>
                                                            c['username1'] ==
                                                            "${widget.firstname}${widget.id}")
                                                        .map((ui) =>
                                                            CircleAvatar(
                                                              radius: 22,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,

                                                              backgroundImage:
                                                                  NetworkImage(
                                                                ui['image'],
                                                              ), //ui['image'],
                                                            )),
                                                  ])),
                                            ),
                                            Positioned(
                                              bottom: 2,
                                              right: 1,
                                              child: CircleAvatar(
                                                  backgroundColor: scaffold1,
                                                  radius: 5,
                                                  child: const Icon(
                                                      Icons.camera_alt,
                                                      size: 7)),
                                            )
                                          ])
                                        ]),

                                        ListTile(
                                          title: Row(children: [
                                            Text(
                                                lang2 != "Kiswahili (🇰🇪)"
                                                    ? 'Hello '
                                                    : 'Niaje ',
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.lato(
                                                    fontSize: 23,
                                                    fontWeight: FontWeight.bold,
                                                    color: text1)),
                                            Container(
                                             // width: 135,
                                              child: Text('${widget.firstname}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.lato(
                                                      fontSize: 23,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: text1)),
                                            ),
                                            const Icon(Icons.verified,
                                                color: Colors.green, size: 16)
                                          ]),
                                          subtitle: Text(
                                              "@${widget.firstname}${widget.id}",
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.lato(
                                                  color: Colors.grey)),
                                        ),

                                        //trailing: ,
                                      ])),
                                ),
                              ),
                              body: RefreshIndicator(
                                onRefresh: () async {
                                  // offnd();
                                  //Do whatever you want on refrsh.Usually update the date of the listview
                                },
                                child: SingleChildScrollView(
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 25, right: 25),
                                      child: Column(children: [
                                        //Text(wild.toString()),

                                        //trailing: ,

                                        Center(
                                          child: Container(
                                              height: 0.09,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  15,
                                              color: text1),
                                        ),
                                        Container(
                                          height: 2,
                                        ),

                                        ListTile(
                                          onTap: () {
                                            setState(() {
                                              now = DateFormat('EEEE d MMM')
                                                  .format(DateTime.now());
                                              //returns json body from api
                                              //this.courseblock = result1;
                                              leo = DateFormat.jm()
                                                  .format(DateTime.now());
                                            });

                                            scanQR();
                                            /*inmat();
                                                        setState(() {
                                                          chckme =
                                                                  info3.indexOf(ry);
                                                          print(">.>>>>>>>>" +
                                                                  chckme
                                                                      .toString());
                                                        });
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                    FriendMessX1(
                                                                  title: ry[
                                                                          'writer']
                                                                      .toString(),
                                                                  repl: (int.parse(ry[
                                                                                  'id']
                                                                              .toString()) -
                                                                          1)
                                                                      .toString(),
                                                                  newc: info3
                                                                      .toList(),
                                                                  token: widget.tr,
                                                                  myname: '',
                                                                  user: widget
                                                                      .username,
                                                            ),
                                                          ), //MaterialPageRoute
                                                        );*/
                                          },
                                          leading: Icon(Icons.qr_code_2,
                                              color: icon1),
                                          title: Text(
                                            lang2 != "Kiswahili (🇰🇪)"
                                                ? "Scan"
                                                : "Scan",
                                            style: GoogleFonts.lato(
                                                fontSize: 17,
                                                color: text1,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        traktar(
                                                          title:
                                                              food2, //listoffood
                                                          title1: widget.me,
                                                          darkmode: darkmode,
                                                          text1: text1,
                                                          scaffold1: scaffold1,
                                                          //username
                                                        )));
                                            //showPlacePicker();
                                          },
                                          leading:
                                              Icon(Icons.history, color: icon1),
                                          title: Text(
                                            lang2 != "Kiswahili (🇰🇪)"
                                                ? "Orders"
                                                : "Agizo za awali",
                                            style: GoogleFonts.lato(
                                                fontSize: 17,
                                                color: text1,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ShoppingListPage(
                                                        title: darkmode,
                                                      ) //screen(),
                                                  ), //MaterialPageRoute
                                            );
                                            //showPlacePicker();
                                          },
                                          leading:
                                              Icon(Icons.list, color: icon1),
                                          title: Text(
                                            lang2 != "Kiswahili (🇰🇪)"
                                                ? "Shopping List"
                                                : "List ya Shopping",
                                            style: GoogleFonts.lato(
                                                fontSize: 17,
                                                color: text1,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        /*ListTile(
                                                    onTap: () {
                                                      //showPlacePicker();
                                                    },
                                                    leading: Icon(Icons.payment),
                                                    title: Text("Mpesa Number",
                                                          style: GoogleFonts.lato(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),),
                                                  ),*/
                                        ListTile(
                                          onTap: () {
                                            showPlacePicker();
                                          },
                                          leading: Icon(Icons.location_pin,
                                              color: icon1),
                                          title: Text(
                                            lang2 != "Kiswahili (🇰🇪)"
                                                ? "Delivery Address"
                                                : "Place ya Kupata order yako",
                                            style: GoogleFonts.lato(
                                                fontSize: 17,
                                                color: text1,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),

                                        Container(
                                          height: 10,
                                        ),
                                        Center(
                                          child: Container(
                                              height: 0.09,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  15,
                                              color: text1),
                                        ),
                                        Container(
                                          height: 20,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              //Navigator.pop(context);
                                              //;
                                              setState(() {
                                                !settings
                                                    ? settings = true
                                                    : settings = false;
                                              });
                                            },
                                            child: ListTile(
                                              leading: Text(
                                                lang2 != "Kiswahili (🇰🇪)"
                                                    ? "Settings"
                                                    : "Mapendeleo",
                                                style: GoogleFonts.lato(
                                                    fontSize: 17,
                                                    color: text1,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              trailing: Icon(
                                                  settings
                                                      ? Icons.arrow_drop_down
                                                      : Icons.arrow_drop_up,
                                                  color: icon1),
                                            )),
                                        settings
                                            ? const SizedBox()
                                            : Container(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Column(children: [
                                                  ListTile(
                                                    onTap: () {
                                                      //showPlacePicker();
                                                    },
                                                    leading: Icon(
                                                        darkmode
                                                            ? Icons.dark_mode
                                                            : Icons.light_mode,
                                                        color: icon1),
                                                    title: Text(
                                                      lang2 !=
                                                              "Kiswahili (🇰🇪)"
                                                          ? "mode"
                                                          : "hali",
                                                      style: GoogleFonts.lato(
                                                          fontSize: 17,
                                                          color: text1,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    subtitle: lang2 !=
                                                            "Kiswahili (🇰🇪)"
                                                        ? Text(
                                                            darkmode
                                                                ? "dark"
                                                                : "light",
                                                            style: GoogleFonts
                                                                .lato(
                                                                    color: Colors
                                                                        .grey),
                                                          )
                                                        : Text(
                                                            darkmode
                                                                ? "giza"
                                                                : "mwanga",
                                                            style: GoogleFonts
                                                                .lato(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                    trailing: Switch(
                                                        value: darkmode,
                                                        onChanged: (c) {
                                                          setState(() {
                                                            darkmode = c;
                                                            
                                                          });
                                                        }),
                                                    //subtitle: Text("current:  Lightmode"),
                                                  ),
                                                  ListTile(
                                                    onTap: () {
                                                      setState(() {
                                                        lang1
                                                            ? lang1 = false
                                                            : lang1 = true;
                                                      });
                                                      //rono3();
                                                      //showPlacePicker();
                                                    },
                                                    leading: Icon(
                                                        Icons.language,
                                                        color: icon1),

                                                    title: Text(
                                                      lang2 !=
                                                              "Kiswahili (🇰🇪)"
                                                          ? "Language"
                                                          : "Lugha",
                                                      style: GoogleFonts.lato(
                                                          fontSize: 17,
                                                          color: text1,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    trailing: Icon(
                                                        !lang1
                                                            ? Icons
                                                                .arrow_drop_down
                                                            : Icons
                                                                .arrow_drop_up,
                                                        color: icon1),
                                                    //Switch(value: true, onChanged: (c){}),
                                                    subtitle: Text(
                                                        lang2 == null
                                                            ? "English"
                                                            : "${lang2}",
                                                        style: GoogleFonts.lato(
                                                            color: Colors
                                                                .grey)), //when you workon this decide on the color
                                                  ),
                                                  lang1
                                                      ? Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: ListTile(
                                                              title: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                Row(children: [
                                                                  Text(
                                                                      lang2 !=
                                                                              "Kiswahili (🇰🇪)"
                                                                          ? "Select your prefered language"
                                                                          : "Chagua Lugha yako",
                                                                      style: GoogleFonts.lato(
                                                                          color:
                                                                              Colors.green))
                                                                ]),
                                                                Container(
                                                                  height: 10,
                                                                ),
                                                                InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        lang1
                                                                            ? lang1 =
                                                                                false
                                                                            : lang1 =
                                                                                true;
                                                                        lang2 =
                                                                            "Kiswahili (🇰🇪)";
                                                                      });
                                                                    },
                                                                    child: Container(
                                                                        color:
                                                                            scaffold1,
                                                                        padding:
                                                                            const EdgeInsets.all(
                                                                                3.0),
                                                                        child: ListTile(
                                                                            title:
                                                                                Text("Kiswahili (🇰🇪)", style: GoogleFonts.lato(color: text1))))),
                                                                InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      lang1
                                                                          ? lang1 =
                                                                              false
                                                                          : lang1 =
                                                                              true;
                                                                      lang2 =
                                                                          "English";
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    color:
                                                                        scaffold1,
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            3.0),
                                                                    child: ListTile(
                                                                        title: Text(
                                                                            "English",
                                                                            style:
                                                                                GoogleFonts.lato(color: text1))),
                                                                  ),
                                                                )
                                                              ])),
                                                        )
                                                      : const SizedBox(),
                                                  Tooltip(
                                                    message:
                                                        "change the mode of sale notifications you get",
                                                    child: ListTile(
                                                      onTap: () {
                                                        //showPlacePicker();
                                                      },
                                                      leading: Icon(
                                                          salenote
                                                              ? Icons.lock
                                                              : Icons.lock_open,
                                                          color: icon1),
                                                      title: Text(
                                                        lang2 !=
                                                                "Kiswahili (🇰🇪)"
                                                            ? "sale alert"
                                                            : "Taarifa ya kuuza",
                                                        style: GoogleFonts.lato(
                                                            fontSize: 17,
                                                            color: text1,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      trailing: Switch(
                                                          value: salenote,
                                                          onChanged: (c) {
                                                            setState(() {
                                                              salenote = c;
                                                            });
                                                          }),
                                                      //subtitle: Text("current:  Lightmode"),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    onTap: () {
                                                      //showPlacePicker();
                                                    },
                                                    leading: Icon(Icons.phone,
                                                        color: icon1),
                                                    title: Text(
                                                      lang2 !=
                                                              "Kiswahili (🇰🇪)"
                                                          ? "Contact Us"
                                                          : "Wasiliana nasi",
                                                      style: GoogleFonts.lato(
                                                          color: text1,
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    subtitle: Text(
                                                      "0705412626",
                                                      style: GoogleFonts.lato(
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                ])),
                                        Container(
                                            height: 0.07,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .6,
                                            color: text1),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              !legal
                                                  ? legal = true
                                                  : legal = false;
                                            });
                                          },
                                          child: ListTile(
                                            leading: Text(
                                              lang2 != "Kiswahili (🇰🇪)"
                                                  ? "Legal"
                                                  : "sheria",
                                              style: GoogleFonts.lato(
                                                  fontSize: 17,
                                                  color: text1,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            trailing: Icon(
                                              legal
                                                  ? Icons.arrow_drop_down
                                                  : Icons.arrow_drop_up,
                                              color: text1,
                                            ),
                                          ),
                                        ),

                                        legal
                                            ? const SizedBox()
                                            : Container(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Column(children: [
                                                  ListTile(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                legal1(
                                                                    darkmode:
                                                                        darkmode) //screen(),
                                                            ), //MaterialPageRoute
                                                      );
                                                      //showPlacePicker();
                                                    },
                                                    leading: Icon(Icons.policy,
                                                        color: icon1),
                                                    title: Text(
                                                      lang2 !=
                                                              "Kiswahili (🇰🇪)"
                                                          ? "Policy"
                                                          : "Sera",
                                                      style: GoogleFonts.lato(
                                                          fontSize: 17,
                                                          color: text1,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    //Switch(value: true, onChanged: (c){}),
                                                    //when you workon this decide on the color
                                                  ),
                                                  ListTile(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                legal2(
                                                                    darkmode:
                                                                        darkmode) //screen(),
                                                            ), //MaterialPageRoute
                                                      );
                                                      //showPlacePicker();
                                                    },
                                                    leading: Icon(Icons.balance,
                                                        color: icon1),
                                                    title: Text(
                                                      lang2 !=
                                                              "Kiswahili (🇰🇪)"
                                                          ? "Terms and conditions"
                                                          : "Sheria na Masharti",
                                                      style: GoogleFonts.lato(
                                                          fontSize: 17,
                                                          color: text1,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ), //when you workon this decide on the color
                                                  ),
                                                ])),
                                        Container(
                                          height: 10,
                                        ),
                                        Center(
                                          child: Container(
                                            height: 0.09,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                15,
                                            color: text1,
                                          ),
                                        ),
                                        Container(
                                          height: 20,
                                        ),
                                        /*ListTile(
                                          leading: const Icon(
                                            Icons.exit_to_app,
                                            color: Colors.red,
                                          ),
                                          title: Text("Sign out",
                                              style: GoogleFonts.lato(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MyAppL(
                                                      title:
                                                          'logout') //screen(),
                                                  ), //MaterialPageRoute
                                            );
                                            //get out of my app
                                          },
                                        ),*/
                                      ]),
                                    ),
                                  ),
                                ),
                              ),
                              bottomNavigationBar: Container(
                                // padding:EdgeInsets.all(8),
                                height: 100,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: 30,
                                          width: 30,
                                          child:
                                              Image.asset("assets/carrot.png")),
                                      Text("Freshfit",
                                          style: GoogleFonts.lato(
                                              fontSize: 15,
                                              color: text1,
                                              fontWeight: FontWeight.w600)),
                                    ]),
                              ),
                            )),
                            appBar: AppBar(
                              iconTheme: IconThemeData(color: icon1),

                              /*leading: FloatingActionButton(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            mini: true,
                            //

                            onPressed: () =>
                                _scaffoldKey.currentState!.openDrawer(),
                            //                        },
                            child: AvatarGlow(
                                endRadius: 30.0,
                                animate: true,
                                duration: Duration(milliseconds: 5500),
                                glowColor: Colors.green,
                                child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/play_store_512.png")))),*/
                              //centerTitle:true,
                              title: Wrap(children: [
                                Text("FreshFit",
                                    style: GoogleFonts.lato(color: text1)),
                                Shimmer.fromColors(
                                  period: const Duration(milliseconds: 5500),
                                  baseColor: Colors.green.shade300,
                                  highlightColor: Colors.green.shade900,
                                  child: Text(" groceries.",
                                      style: GoogleFonts.lato(
                                          //color: Colors.green,
                                          fontWeight: FontWeight.w300)),
                                ),
                              ]),
                              actions: [
                                FloatingActionButton(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    mini: true,
                                    onPressed: () {
                                      getfood();

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => searchQ7(
                                                  misearch: food7,
                                                  colorx: scaffold1,
                                                  xme: darkmode,
                                                  me: widget.me,
                                                  username: widget.me,
                                                  token:
                                                      widget.token.toString(),
                                                )),
                                      );
                                    },
                                    child: Icon(
                                      Icons.search,
                                      color: darkmode
                                          ? Colors.white
                                          : Colors.black,
                                    )),
                                FloatingActionButton(
                                    backgroundColor:
                                        const Color.fromARGB(0, 32, 5, 5),
                                    elevation: 0,
                                    mini: true,
                                    onPressed: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) {
                                            return Scaffold(
                                              backgroundColor: scaffold1,
                                              appBar: AppBar(
                                                centerTitle: true,
                                                elevation: 0.0,
                                                backgroundColor: scaffold1,
                                              ),
                                              body: Scaffold(
                                                backgroundColor: scaffold1,
                                                appBar: AppBar(
                                                    centerTitle: true,
                                                    elevation: 0.0,
                                                    backgroundColor: scaffold1,
                                                    title: const Chip(
                                                        label: Text(
                                                            'Track your  orders'))),
                                                body: Center(
                                                  child: RefreshIndicator(
                                                    onRefresh: () async {
                                                      setState(() {
                                                        getWealth();
                                                        getWealth2();
                                                      });

                                                      //print("hello bedroom dev");
                                                      //getWeather();
                                                      //rono = false;
                                                      //Do whatever you want on refrsh.Usually update the date of the listview
                                                    },
                                                    child:
                                                        SingleChildScrollView(
                                                            child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        ...food2.reversed.where((op) => op['owner'].toString() == widget.me.toString()).map(
                                                            (i)
                                                                //var index = sky.indexOf(i);
                                                                =>
                                                                i['owner'].toString() !=
                                                                        widget
                                                                            .me
                                                                            .toString()
                                                                    ? Container()
                                                                    : Card(
                                                                        color: darkmode
                                                                            ? Colors
                                                                                .grey.shade900
                                                                            : Colors.grey[
                                                                                50],
                                                                        elevation: darkmode
                                                                            ? 0.4
                                                                            : 0,
                                                                        child: Column(
                                                                            children: [
                                                                              Container(
                                                                                width: MediaQuery.of(context).size.width,
                                                                                child: Card(
                                                                                    color: scaffold1,
                                                                                    elevation: 0,
                                                                                    child: Column(children: [
                                                                                      //SizedBox(height: 5),
                                                                                      //Container(height: 0.08, width: MediaQuery.of(context).size.width * .8, color: text1), SizedBox(height: 5),
                                                                                      //ListTile(title: Text("${food2.reversed.where((op) => op['owner'].toString() == widget.me.toString()).take(1).toList()[0]["id"].toString()}"), subtitle: Text("${food2.reversed.where((op) => op['owner'].toString() == widget.me.toString()).take(1).toList()[0]["ordertime"].toString()}")),
                                                                                      /*ListTile(
                                                                              title: Text("#" + i['id'].toString())
                                                                              //title: Text('name',style:GoogleFonts.lato(color:Colors.black)),
                                                                              ),*/
                                                                                      /*ListTile(
                                                                            leading: Icon(
                                                                                Icons.storefront,
                                                                                color: Colors.amber),
                                                                            title:
                                                                                Text(i['restaurantx'].toString()),
                                                                            subtitle: Text(i['table'].toString() == 'Menu'
                                                                                ? "Pickup order"
                                                                                : i['table'].toString()), //
                                                                            /*trailing: Chip(
                                                                                backgroundColor: Colors.white,
                                                                                avatar: Icon(Icons.timer_outlined, color: Colors.green),
                                                                                label: Text(i['table'] == 'Menu' ? i['ordertime'] : 'Anytime')),*/
                                                                            //title: Text('name',style:GoogleFonts.lato(color:Colors.black)),
                                                                          ),*/
                                                                                      ListTile(
                                                                                        trailing: i['ordertrak'].toString() == "ready" ? Checkbox(value: true, onChanged: (l) {}) : Checkbox(value: false, onChanged: (l) {}),
                                                                                        title: Text(
                                                                                          "#" + i['id'].toString() + "        ",
                                                                                          style: GoogleFonts.lato(color: text1, fontSize: 21),
                                                                                        ),
                                                                                        subtitle: Text(
                                                                                          i['time'].toString(),
                                                                                          style: GoogleFonts.lato(color: text1),
                                                                                        ),
                                                                                      ),

                                                                                      // Text(food7.toString()),
                                                                                      //Text(i['food'].replaceAll("],","|").replaceAll("[","").replaceAll("]]","").split("|")[0].split(",")[0].toString()),
                                                                                      ...i['food'].replaceAll("],", "|").replaceAll("[", "").replaceAll("]]", "").split("|").map((k) => ListTile(
                                                                                              title: Column(
                                                                                            children: [
                                                                                              Card(
                                                                                                  elevation: 0,
                                                                                                  color: !amount3.contains(i)
                                                                                                      ? scaffold1
                                                                                                      : darkmode
                                                                                                          ? Colors.white12
                                                                                                          : Colors.amber.shade50,
                                                                                                  child: Container(
                                                                                                    padding: const EdgeInsets.all(3.0),
                                                                                                    child: SingleChildScrollView(
                                                                                                      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                                                                                        Container(
                                                                                                          child: Card(
                                                                                                            color: Colors.transparent,
                                                                                                            elevation: 0,
                                                                                                            child: Column(children: [
                                                                                                              Container(
                                                                                                                height: 80,
                                                                                                                width: 79,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  //color:Colors.green,
                                                                                                                  borderRadius: const BorderRadius.all(Radius.circular(10.0) //                 <--- border radius here
                                                                                                                      ),
                                                                                                                  image: DecorationImage(
                                                                                                                    image: NetworkImage("${k.split(",")[1].toString().replaceAll(" ", "")}")
                                                                                                                    //k.split(",")[1],                                                                         ),
                                                                                                                    ,
                                                                                                                    fit: BoxFit.cover,
                                                                                                                  ),
                                                                                                                ),
                                                                                                                child: null,
                                                                                                              )
                                                                                                            ]),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Container(
                                                                                                            width: MediaQuery.of(context).size.width > 600 ? MediaQuery.of(context).size.width * .680 : MediaQuery.of(context).size.width * .500,
                                                                                                            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                                              ListTile(
                                                                                                                title: Text(
                                                                                                                  k.split(",")[0],
                                                                                                                  style: GoogleFonts.lato(fontSize: 17, color: amount3.contains(i) ? text1 : text1, fontWeight: FontWeight.bold),
                                                                                                                ),
                                                                                                                subtitle: Wrap(
                                                                                                                  children: [
                                                                                                                    Text(ii == i['name'] ? (int.parse(k.split(",")[3].toString()) * quantity).toString() + 'KES' : k.split(",")[3].toString() + 'KES',
                                                                                                                        style: GoogleFonts.lato(
                                                                                                                            /*backgroundColor: Colors
                                                                          .red
                                                                          .withOpacity(
                                                                              0.1),*/
                                                                                                                            color: Colors.green)),
                                                                                                                    Text(" ", style: GoogleFonts.lato(color: text1)),

                                                                                                                    /* Text( ii == i['name']
                                                                        ? (int.parse(i['points']) *
                                                                                    quantity)
                                                                                .toString(): i['points']
                                                                                .toString() 
                                                                            ,style: GoogleFonts.lato(
                                                                              color: darkmode?Colors.amber.shade200:Colors.amber.shade900
                                                                            ),),
                                                                            Icon(Icons.diamond,color:icon1,size:17),*/
                                                                                                                  ],
                                                                                                                ),
                                                                                                              ),
                                                                                                            ])),
                                                                                                        Container(
                                                                                                          width: MediaQuery.of(context).size.width * .137,
                                                                                                          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                                            // ListTile(),
                                                                                                            Center(
                                                                                                              child: ListTile(
                                                                                                                title: Center(child: Text(k.split(",")[2].toString(), style: GoogleFonts.lato(fontWeight: FontWeight.bold, color: text1))),
                                                                                                                //leading:,Row(children:[ CircleAvatar(child:Icon(Icons.shopping_bag,color:Colors.green),radius:15,backgroundColor:Colors.grey[200])
                                                                                                                //    ,Text('1')])
                                                                                                                //trailing: Text(ii == i['name']?(int.parse(i['price'])*quantity).toString()+'/=':i['price'].toString()+'/=',style:GoogleFonts.lato(fontSize:15,fontWeight:FontWeight.bold)),

                                                                                                                //subtitle: Text(i['price'].toString()),
                                                                                                              ),
                                                                                                            ),
                                                                                                            // ListTile()
                                                                                                          ]),
                                                                                                        )
                                                                                                      ]),
                                                                                                    ),
                                                                                                  )

                                                                                                  //end
                                                                                                  )
                                                                                              /* ListTile(
                                                                               leading: 
                                                                                CircleAvatar(
                                                                                  backgroundColor: Colors.transparent,
                                              radius: 35,
                                              backgroundImage: NetworkImage(
                                                k.split(",")[1].toString()
                                              ), //AtImage(i['image'],),
                                            ),
                                                                              
                                                                               title: Text(k.split(",")[1].toString()),
                                                                             ),*/

                                                                                              //  ...food7.map((lo)=>//Text(lo['name'].toString())
                                                                                              // lo['name'] ==k.split(",")[0].toString()?  Text(k.split(",")[0].toString()):SizedBox())
                                                                                              //
                                                                                              ,
                                                                                              const SizedBox(height: 10),
                                                                                              Container(height: 0.07, width: MediaQuery.of(context).size.width * .8, color: text1),
                                                                                              const SizedBox(height: 10),
                                                                                            ],
                                                                                          )
                                                                                              //Text(k.split(",")[0].toString()),

                                                                                              )),

                                                                                      ListTile(
                                                                                        tileColor: darkmode ? Colors.grey.shade900 : Colors.grey.shade100,
                                                                                        //leading: Text(i['time'].toString(),style:GoogleFonts.lato(color:Colors.black)),
                                                                                        title: Text(
                                                                                          'You spent a total of:',
                                                                                          style: GoogleFonts.lato(color: text1),
                                                                                        ),
                                                                                        subtitle: Text(i['totalprice'].toString() + '\tKES', style: GoogleFonts.lato(color: darkmode ? Colors.grey.shade50 : Colors.grey)), //

                                                                                        //title: Text('name',style:GoogleFonts.lato(color:Colors.black)),
                                                                                      ),
                                                                                    ])),
                                                                              )

                                                                              //play within this boundaries

                                                                              //.toList(),

                                                                              ,
                                                                              Container(
                                                                                height: 10,
                                                                              ),
                                                                            ]))

                                                            //play within this boundaries
                                                            ),
                                                      ],
                                                    )),
                                                  ),
                                                ),
                                              ),
                                              bottomNavigationBar: Container(
                                                height: 60,
                                                child: Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: Container(
                                                    width: _bannerAd.size.width
                                                        .toDouble(),
                                                    height: _bannerAd
                                                        .size.height
                                                        .toDouble(),
                                                    child:
                                                        null /*AdWidget(
                                                        ad: _bannerAd,
                                                        key: UniqueKey())*/
                                                    ,
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: Icon(Icons.shopping_bag,
                                        color: darkmode
                                            ? Colors.white
                                            : Colors.black)),
                                const SizedBox(
                                  width: 5,
                                )
                              ],
                              // preferredSize: Size.fromHeight(100),
                              flexibleSpace: new ClipRect(
                                  child: new BackdropFilter(
                                      filter: new ImageFilter.blur(
                                          sigmaX: 10.0, sigmaY: 10.0),
                                      child: Container(
                                        //height: MediaQuery.of(context).size.height * .23,
                                        decoration: BoxDecoration(
                                          //color: Colors.transparent,

                                          gradient: LinearGradient(
                                            colors: <Color>[
                                              scaffold1,
                                              scaffold1,
                                              darkmode
                                                  ? scaffold1
                                                  : Colors.white,
                                              darkmode
                                                  ? scaffold1
                                                  : Colors.white,
                                              darkmode
                                                  ? scaffold1
                                                  : Colors.white,
                                              darkmode
                                                  ? scaffold1
                                                  : Colors.white
                                            ],
                                          ),
                                          //color:Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(
                                                  10.0) //                 <--- border radius here
                                              ),
                                        ),
                                        // height: 200,
                                        // width: MediaQuery.of(context).size.width,
                                        //
                                      ))),
                              elevation: 0.0,
                              backgroundColor: scaffold1,
                              //centerTitle:true,

                              bottom: PreferredSize(
                                preferredSize: const Size.fromHeight(100.0),
                                child: TabBar(
                                  isScrollable: true,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicator: const UnderlineTabIndicator(
                                      borderSide: BorderSide(
                                        //height:1.0,
                                        width: 1.0,
                                        color: Colors.green,
                                      ),
                                      insets: const EdgeInsets.symmetric(
                                          horizontal: 36.0)),
                                  indicatorColor: Colors.black,
                                  unselectedLabelColor: Colors.grey[900],
                                  labelColor: Colors.black,
                                  tabs: [
                                    Card(
                                        color: Colors.transparent,
                                        elevation: 0,
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                                radius: 30,
                                                child: Stack(children: [
                                                  Center(
                                                    child: Text(
                                                        "${widget.firstname.substring(0, 1)}",
                                                        style: GoogleFonts.lato(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  ...picpic
                                                      .where((c) =>
                                                          c['username1'] ==
                                                          "${widget.firstname}${widget.id}")
                                                      .map((ui) => CircleAvatar(
                                                            radius: 30,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,

                                                            backgroundImage:
                                                                NetworkImage(
                                                              ui['image'],
                                                            ), //ui['image'],
                                                          )),
                                                ])), //AtImage(i['image'],),
                                            Container(),
                                            Shimmer.fromColors(
                                  period: const Duration(milliseconds: 5500),
                                  baseColor: text1,
                                  highlightColor: darkmode?Colors.grey.shade200.withOpacity(0.5):Colors.grey.shade200.withOpacity(0.9),
                                  child:Text(
                                              lang2 != "Kiswahili (🇰🇪)"
                                                  ? "For you"
                                                  : 'Yako',
                                              style: GoogleFonts.lato(
                                                  color: text1),
                                            )),
                                          ],
                                        )),
                                    ...sky['menu'][0]['menu'].map((i) => Card(
                                              color: Colors.transparent,
                                              elevation: 0,
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 35,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      i['image'],
                                                    ), //AtImage(i['image'],),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    lang2 != "Kiswahili (🇰🇪)"
                                                        ? i['name'].toString()
                                                        : kisw(i['name']
                                                            .toString()),
                                                    style: GoogleFonts.lato(
                                                        color: text1),
                                                  )
                                                ],
                                              ),
                                            ) /*Tab(
                              icon:CircleAvatar(
                                radius:25,
                      
                              ),
                                text: i['name'].toString(),
                                    )*/
                                        ),
                                  ],
                                ),
                              ),

                              /*title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Chip(
                                avatar: Icon(
                                  //widget.user.split('|').contains('|') ? Icons.group_outlined  &&
                                  widget.user.toString() == 'Menu'
                                      ? Icons.storefront
                                      : widget.user.split('|').length > 1
                                          ? Icons.group_outlined
                                          : Icons.qr_code_scanner,
                                  color: Colors.red,
                                ),
                                label: Text(
                                    widget.user.split('|').length > 1
                                        ? widget.user.split('|')[1].toString()
                                        : widget.user.toString(),
                                    style: GoogleFonts.lato(color: Colors.black)))
                          ]),*/

                              /* FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>trakstar(title:cart2),
                          ),
                        );
                 /* Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>trak(title:cart,title2:quantity.toString()),
                          ),
                        );*/
                },
                backgroundColor: Colors.white,
                elevation: 0.0,
                mini: true,
                child: Center(
                    child: Stack(children: [
                  Icon(Icons.receipt, color: Colors.red),
                  Positioned(
                      top: 0,
                      right: 1,
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Colors.yellow,
                          radius: 6,
                        ),
                      ))
                ])),
              )*/

                              /*FloatingActionButton(
                              mini: true,
                              backgroundColor: Colors.white,
                              elevation: 0.0,
                              child: Center(
                                  child: Stack(children: [
                                Icon(Icons.search, color: Colors.blueGrey[900]),
                              ])),
                              onPressed: () {
                                //search starts here
                                //print(title.toList());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => searchQ(
                                            misearch: sky['menu'][0]['menu'],
                                            username: widget.me,
                                            token: widget.token.toString(),
                                          )),
                                );
                              }),*/
                            ),

                            /*Chip(
                            backgroundColor: Colors.white,
                            avatar: Icon(Icons.wallet_giftcard),
                            label: Text(widget.user.split('|')[2].toString())),*/
                            body: TabBarView(
                              children: [
                                Scaffold(
                                    backgroundColor: scaffold1,
                                    body: SingleChildScrollView(
                                        child: Column(children: [
                                      ListTile(
                                          title: Text(
                                        lang2 != "Kiswahili (🇰🇪)"
                                            ? "Recommended"
                                            : "Imependekezwa Kwako",
                                        style: GoogleFonts.lato(
                                            fontSize: 20,
                                            color: text1,
                                            fontWeight: FontWeight.bold),
                                      )),
                                      Container(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(children: [
                                            ...sky['menu'][0]['menu']
                                                .map(
                                                    (i) =>
                                                        SingleChildScrollView(
                                                            child: Row(
                                                                children: [
                                                              ...i['food'].take(1).map((i) => Card(
                                                                  color: !amount3.contains(i)
                                                                      ? scaffold1
                                                                      : darkmode
                                                                          ? Colors.white12
                                                                          : Colors.amber.shade50,
                                                                  elevation: 0,
                                                                  child: Container(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            3.0),
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            Container(
                                                                              child: Card(
                                                                                color: Colors.transparent,
                                                                                elevation: 0,
                                                                                child: Column(children: [
                                                                                  Container(
                                                                                      height: 180,
                                                                                      width: 180,
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: const BorderRadius.all(Radius.circular(10.0) //                 <--- border radius here
                                                                                            ),
                                                                                        image: DecorationImage(
                                                                                          image: NetworkImage(i['image_url'].toString()),
                                                                                          fit: BoxFit.cover,
                                                                                        ),
                                                                                      ),
                                                                                      child: Stack(
                                                                                        children: [
                                                                                          Positioned(
                                                                                              bottom: 0,
                                                                                              left: 0,
                                                                                              child: Container(
                                                                                                height: 80,
                                                                                                width: 180,
                                                                                                color: !darkmode ? Colors.white12.withOpacity(0.5) : Colors.black12.withOpacity(0.5),
                                                                                                child: ListTile(
                                                                                                  title: Text(
                                                                                                    i['name'].toString(),
                                                                                                    style: GoogleFonts.lato(fontSize: 17, color: amount3.contains(i) ? text1 : text1, fontWeight: FontWeight.bold),
                                                                                                  ),
                                                                                                  subtitle: Wrap(
                                                                                                    children: [
                                                                                                      Text(ii == i['name'] ? (int.parse(i['price']) * quantity).toString() + 'KES' : i['price'].toString() + 'KES', style: GoogleFonts.lato(backgroundColor: Colors.red.withOpacity(0.5), color: text1)),
                                                                                                      Text(" ", style: GoogleFonts.lato(color: text1)),

                                                                                                      /* Text( ii == i['name']
                                                                      ? (int.parse(i['points']) *
                                                                                  quantity)
                                                                              .toString(): i['points']
                                                                              .toString() 
                                                                          ,style: GoogleFonts.lato(
                                                                            color: darkmode?Colors.amber.shade200:Colors.amber.shade900
                                                                          ),),
                                                                          Icon(Icons.diamond,color:icon1,size:17),*/
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              )),
                                                                                          Positioned(
                                                                                              right: 5,
                                                                                              top: 80,
                                                                                              child: InkWell(
                                                                                                  child: amount3.contains(i)
                                                                                                      ? const SizedBox()
                                                                                                      : CircleAvatar(
                                                                                                          child: Icon(!amount3.contains(i) ? Icons.add_shopping_cart : null, color: amount3.contains(i) ? Colors.green : Colors.green),
                                                                                                          backgroundColor: amount3.contains(i)
                                                                                                              ? !darkmode
                                                                                                                  ? Colors.grey.shade200
                                                                                                                  : Colors.amber.shade50
                                                                                                              : Colors.amber.shade50),
                                                                                                  onTap: () {
                                                                                                    //order1
                                                                                                    //

                                                                                                    amount3.contains(i)
                                                                                                        ? ''
                                                                                                        : setState(() {
                                                                                                            //prev
                                                                                                            final prev = ii;
                                                                                                            if (prev == '1') {
                                                                                                              quantity = 1;
                                                                                                            }
                                                                                                            ;
                                                                                                            cart.add([
                                                                                                              i,
                                                                                                              quantity == null ? 1 : quantity
                                                                                                            ]);
                                                                                                            //i.remove(i['image_url']);

                                                                                                            amount2.add([
                                                                                                              i['name'],
                                                                                                              i['image_url'].replaceAll(" ", ""),
                                                                                                              quantity,
                                                                                                              (int.parse(i['price']) * (quantity))
                                                                                                            ]);
                                                                                                            amount3.add(i);
                                                                                                            print("here's the " + amount3.toString());

                                                                                                            amount.add((int.parse(i['price']) * (quantity)));

                                                                                                            quantity = 1;
                                                                                                          });

                                                                                                    //_total(int.parse(i['price'])*int.parse(quantity));

                                                                                                    //print(quantity.toString());
                                                                                                    //print('Summenu'+(int.parse(i[0]['price'])*int.parse(quantity)).toString());
                                                                                                    //print(int.parse(i['price'])*quantity);

                                                                                                    //here set the state of the boolean
                                                                                                    //_increase(i['name']);

                                                                                                    SetState() {
                                                                                                      //amount.add();

                                                                                                      print(cart.length);
                                                                                                      final quantity = 1;
                                                                                                      i['price'] = (int.parse(i['price']) * (quantity)).toString();
                                                                                                      print('amount' + amount.toString());
                                                                                                      print(i[0].toString());
                                                                                                    }

                                                                                                    ;
                                                                                                  })),
                                                                                          Positioned(
                                                                                            bottom: 5,
                                                                                            right: 5,
                                                                                            child: Container(
                                                                                                height: 50,
                                                                                                width: 78,
                                                                                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                                                  const Text(""),
                                                                                                  amount3.contains(i)
                                                                                                      ? Container()
                                                                                                      : Container(
                                                                                                          //color:darkmode?Colors.black.withOpacity(0.4):Colors.white.withOpacity(0.2),
                                                                                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                                                                                                            Container(
                                                                                                              child: InkWell(
                                                                                                                  child: CircleAvatar(child: const Icon(Icons.add, color: Colors.green), radius: 15, backgroundColor: darkmode ? Colors.grey[200]?.withOpacity(0.4) : Colors.grey[200]),
                                                                                                                  onTap: () {
                                                                                                                    print(i['name']);
                                                                                                                    setState(() {
                                                                                                                      cart.contains(i['name']) ? Container() : _increase(i['name']);
                                                                                                                      print(cart);
                                                                                                                    });
                                                                                                                    print(quantity);
                                                                                                                  }),
                                                                                                            ),
                                                                                                            const Text('\t'),
                                                                                                            Text(ii == i['name'] ? quantity.toString() : '1', style: GoogleFonts.lato(color: text1, fontWeight: FontWeight.bold)),
                                                                                                            const Text('\t'),
                                                                                                            InkWell(
                                                                                                                child: CircleAvatar(child: const Icon(Icons.remove, color: Colors.green), radius: 15, backgroundColor: darkmode ? Colors.grey[200]?.withOpacity(0.4) : Colors.grey[200]),
                                                                                                                onTap: () {
                                                                                                                  //print(i['name']);
                                                                                                                  setState(() {
                                                                                                                    if (quantity > 1) {
                                                                                                                      decrease(i['name']);
                                                                                                                    }
                                                                                                                  });
                                                                                                                  print(quantity);
                                                                                                                }),
                                                                                                          ]),
                                                                                                        )
                                                                                                ])),
                                                                                          ),
                                                                                          Positioned(
                                                                                            top: 5,
                                                                                            right: 5,
                                                                                            child: Row(
                                                                                              children: [
                                                                                                Container(width: 20), //MediaQuery.of(context).size.width*.05),

                                                                                                Text(
                                                                                                  lang2 != "Kiswahili (🇰🇪)" ? 'Save on ' + '${i['save1']}%' : 'okoa ' + '${i['save1']}%',
                                                                                                  style: GoogleFonts.lato(color: darkmode ? Colors.white : Colors.black, backgroundColor: darkmode ? Colors.red : Colors.red.shade100),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ))
                                                                                ]),
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                    ),
                                                                  )

                                                                  //end
                                                                  ))
                                                            ]))),
                                          ]),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                          height: 0.08,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .9,
                                          color: text1),
                                      SizedBox(height: 5),
                                      food2.reversed
                                                  .where((op) =>
                                                      op['owner'].toString() ==
                                                      widget.me.toString())
                                                  .length <
                                              1
                                          ? ListTile(
                                              title: Text(
                                              lang2 != "Kiswahili (🇰🇪)"
                                                  ? "Recent"
                                                  : "Agizo Iliyopita",
                                              style: GoogleFonts.lato(
                                                  fontSize: 22,
                                                  color: text1,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                          : const SizedBox(),
                                      food2.reversed
                                                  .where((op) =>
                                                      op['owner'].toString() ==
                                                      widget.me.toString())
                                                  .length <
                                              1
                                          ? Container(
                                              height: 200,
                                              child: Center(
                                                  child: Text(
                                                      lang2 !=
                                                              "Kiswahili (🇰🇪)"
                                                          ? "Nothing here for now"
                                                          : "Hakuna kwa sasa",
                                                      style: GoogleFonts.lato(
                                                          color: text1,
                                                          fontWeight: FontWeight
                                                              .bold))))
                                          : Card(
                                              elevation: 0,
                                              color: scaffold1,
                                              child: Column(children: [
                                                ListTile(
                                                    title: Text(
                                                      lang2 !=
                                                              "Kiswahili (🇰🇪)"
                                                          ? "Recent"
                                                          : "Iliyopita",
                                                      style: GoogleFonts.lato(
                                                          fontSize: 20,
                                                          color: text1,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    subtitle: Text(
                                                        lang2 != "Kiswahili (🇰🇪)"
                                                            ? 'From your orders'
                                                            : "Kutoka kwa Agizo za awali",
                                                        style: GoogleFonts.lato(
                                                            color: darkmode
                                                                ? Colors.grey
                                                                : Colors.grey
                                                                    .shade900)),
                                                    trailing: food2.reversed.where((op) => op['owner'].toString() == widget.me.toString()).take(1).toList()[0]["ordertrak"].toString() ==
                                                            'ready' /*i['ordertrak'].toString() == "ready"?Checkbox(value: true, onChanged: (l){}):Checkbox(value: false, onChanged: (l){}), */
                                                        ?
                                                        /*ListTile(
        //leading: Text(i['time'].toString(),style:GoogleFonts.lato(color:Colors.black)),
        title:Text('You spent a total of:'),
        subtitle: Text(i['totalprice'].toString()+'\tKES'),//
        
        //title: Text('name',style:GoogleFonts.lato(color:Colors.black)),
        ), */
                                                        FloatingActionButton(
                                                            mini: true,
                                                            onPressed: () =>
                                                                retball(),
                                                            child: Checkbox(
                                                                value: true,
                                                                onChanged:
                                                                    (l) {}))
                                                        : FloatingActionButton(
                                                            mini: true,
                                                            onPressed: () {
                                                              retball();
                                                            },
                                                            child: Checkbox(
                                                                value: false,
                                                                onChanged: (l) {}))),
                                                ...food2.reversed
                                                    .where((op) =>
                                                        op['owner']
                                                            .toString() ==
                                                        widget.me.toString())
                                                    .take(1)
                                                    .map(
                                                        (i) //increase by the number of users
                                                            //var index = sky.indexOf(i);
                                                            =>
                                                            i['owner'].toString() !=
                                                                    widget.me
                                                                        .toString()
                                                                ? Container()
                                                                : food2.reversed
                                                                            .where((op) =>
                                                                                op['owner'].toString() ==
                                                                                widget.me
                                                                                    .toString())
                                                                            .length <
                                                                        1
                                                                    ? Container(
                                                                        child: Text(
                                                                            "Nothing here for now",
                                                                            style:
                                                                                GoogleFonts.lato(color: Colors.black)))
                                                                    : Container(
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        child: Card(
                                                                            color: scaffold1,
                                                                            elevation: 0,
                                                                            child: Column(children: [
                                                                              const SizedBox(height: 5),
                                                                              Container(height: 0.08, width: MediaQuery.of(context).size.width * .8, color: text1),
                                                                              const SizedBox(height: 5),

                                                                              /*ListTile(
                                                                              title: Text("#" + i['id'].toString())
                                                                              //title: Text('name',style:GoogleFonts.lato(color:Colors.black)),
                                                                              ),*/
                                                                              /*ListTile(
                                                                            leading: Icon(
                                                                                Icons.storefront,
                                                                                color: Colors.amber),
                                                                            title:
                                                                                Text(i['restaurantx'].toString()),
                                                                            subtitle: Text(i['table'].toString() == 'Menu'
                                                                                ? "Pickup order"
                                                                                : i['table'].toString()), //
                                                                            /*trailing: Chip(
                                                                                backgroundColor: Colors.white,
                                                                                avatar: Icon(Icons.timer_outlined, color: Colors.green),
                                                                                label: Text(i['table'] == 'Menu' ? i['ordertime'] : 'Anytime')),*/
                                                                            //title: Text('name',style:GoogleFonts.lato(color:Colors.black)),
                                                                          ),*/
                                                                              // Text(food7.toString()),
                                                                              //Text(i['food'].replaceAll("],","|").replaceAll("[","").replaceAll("]]","").split("|")[0].split(",")[0].toString()),
                                                                              ...i['food'].replaceAll("],", "|").replaceAll("[", "").replaceAll("]]", "").split("|").map((k) => ListTile(
                                                                                      title: Column(
                                                                                    children: [
                                                                                      Card(
                                                                                          elevation: 0,
                                                                                          color: !amount3.contains(i)
                                                                                              ? scaffold1
                                                                                              : darkmode
                                                                                                  ? Colors.white12
                                                                                                  : Colors.amber.shade50,
                                                                                          child: Container(
                                                                                            padding: const EdgeInsets.all(3.0),
                                                                                            child: SingleChildScrollView(
                                                                                              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                                                                                Container(
                                                                                                  child: Card(
                                                                                                    color: Colors.transparent,
                                                                                                    elevation: 0,
                                                                                                    child: Column(children: [
                                                                                                      Container(
                                                                                                        height: 80,
                                                                                                        width: 79,
                                                                                                        decoration: BoxDecoration(
                                                                                                          //color:Colors.green,
                                                                                                          borderRadius: const BorderRadius.all(const Radius.circular(10.0) //                 <--- border radius here
                                                                                                              ),
                                                                                                          image: DecorationImage(
                                                                                                            image: NetworkImage("${k.split(",")[1].toString().replaceAll(" ", "")}")
                                                                                                            //k.split(",")[1],                                                                         ),
                                                                                                            ,
                                                                                                            fit: BoxFit.cover,
                                                                                                          ),
                                                                                                        ),
                                                                                                        child: null,
                                                                                                      )
                                                                                                    ]),
                                                                                                  ),
                                                                                                ),
                                                                                                Container(
                                                                                                    width: MediaQuery.of(context).size.width > 600 ? MediaQuery.of(context).size.width * .680 : MediaQuery.of(context).size.width * .500,
                                                                                                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                                      ListTile(
                                                                                                        title: Text(
                                                                                                          k.split(",")[0],
                                                                                                          style: GoogleFonts.lato(fontSize: 17, color: amount3.contains(i) ? text1 : text1, fontWeight: FontWeight.bold),
                                                                                                        ),
                                                                                                        subtitle: Wrap(
                                                                                                          children: [
                                                                                                            Text(ii == i['name'] ? (int.parse(k.split(",")[3].toString()) * quantity).toString() + 'KES' : k.split(",")[3].toString() + 'KES',
                                                                                                                style: GoogleFonts.lato(
                                                                                                                    /*backgroundColor: Colors
                                                                          .red
                                                                          .withOpacity(
                                                                              0.1),*/
                                                                                                                    color: Colors.green)),
                                                                                                            Text(" ", style: GoogleFonts.lato(color: text1)),

                                                                                                            /* Text( ii == i['name']
                                                                        ? (int.parse(i['points']) *
                                                                                    quantity)
                                                                                .toString(): i['points']
                                                                                .toString() 
                                                                            ,style: GoogleFonts.lato(
                                                                              color: darkmode?Colors.amber.shade200:Colors.amber.shade900
                                                                            ),),
                                                                            Icon(Icons.diamond,color:icon1,size:17),*/
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                    ])),
                                                                                                Container(
                                                                                                  width: MediaQuery.of(context).size.width * .137,
                                                                                                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                                    // ListTile(),
                                                                                                    Center(
                                                                                                      child: ListTile(
                                                                                                        title: Center(child: Text(k.split(",")[2].toString(), style: GoogleFonts.lato(fontWeight: FontWeight.bold, color: text1))),
                                                                                                        //leading:,Row(children:[ CircleAvatar(child:Icon(Icons.shopping_bag,color:Colors.green),radius:15,backgroundColor:Colors.grey[200])
                                                                                                        //    ,Text('1')])
                                                                                                        //trailing: Text(ii == i['name']?(int.parse(i['price'])*quantity).toString()+'/=':i['price'].toString()+'/=',style:GoogleFonts.lato(fontSize:15,fontWeight:FontWeight.bold)),

                                                                                                        //subtitle: Text(i['price'].toString()),
                                                                                                      ),
                                                                                                    ),
                                                                                                    // ListTile()
                                                                                                  ]),
                                                                                                )
                                                                                              ]),
                                                                                            ),
                                                                                          )

                                                                                          //end
                                                                                          )
                                                                                      /* ListTile(
                                                                               leading: 
                                                                                CircleAvatar(
                                                                                  backgroundColor: Colors.transparent,
                                              radius: 35,
                                              backgroundImage: NetworkImage(
                                                k.split(",")[1].toString()
                                              ), //AtImage(i['image'],),
                                            ),
                                                                              
                                                                               title: Text(k.split(",")[1].toString()),
                                                                             ),*/

                                                                                      //  ...food7.map((lo)=>//Text(lo['name'].toString())
                                                                                      // lo['name'] ==k.split(",")[0].toString()?  Text(k.split(",")[0].toString()):SizedBox())
                                                                                      //
                                                                                      ,
                                                                                      const SizedBox(height: 10),
                                                                                      Container(height: 0.07, width: MediaQuery.of(context).size.width * .8, color: text1),
                                                                                      const SizedBox(height: 10),
                                                                                    ],
                                                                                  )
                                                                                      //Text(k.split(",")[0].toString()),

                                                                                      )),

                                                                              Container(
                                                                                height: 30,
                                                                              ),
                                                                              Container(
                                                                                height: 10,
                                                                              ),
                                                                            ])),
                                                                      )

                                                        //play within this boundaries
                                                        )
                                                    .toList()
                                              ])),
                                      ListTile(
                                          title: Text(
                                        "",
                                        style: GoogleFonts.lato(
                                            fontSize: 20,
                                            color: text1,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ]))),
                                ...sky['menu'][0]['menu']
                                    .map((i) => SingleChildScrollView(
                                            child: Column(children: [
                                          ...i['food'].map((i) => Card(
                                              color: !amount3.contains(i)
                                                  ? scaffold1
                                                  : darkmode
                                                      ? Colors.white12
                                                      : Colors.amber.shade50,
                                              elevation: 0,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: SingleChildScrollView(
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                          child: Card(
                                                            color: Colors
                                                                .transparent,
                                                            elevation: 0,
                                                            child: Column(
                                                                children: [
                                                                  Container(
                                                                      height:
                                                                          80,
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          .19,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius: const BorderRadius.all(
                                                                            Radius.circular(10.0) //                 <--- border radius here
                                                                            ),
                                                                        image:
                                                                            DecorationImage(
                                                                          image:
                                                                              NetworkImage(i['image_url'].toString()),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          null)
                                                                ]),
                                                          ),
                                                        ),
                                                        Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .351,
                                                            child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  ListTile(
                                                                    title: Text(
                                                                      i['name']
                                                                          .toString(),
                                                                      style: GoogleFonts.lato(
                                                                          fontSize:
                                                                              17,
                                                                          color: amount3.contains(i)
                                                                              ? text1
                                                                              : text1,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    subtitle:
                                                                        Wrap(
                                                                      children: [
                                                                        Text(
                                                                            ii == i['name']
                                                                                ? (int.parse(i['price']) * quantity).toString() + 'KES'
                                                                                : i['price'].toString() + 'KES',
                                                                            style: GoogleFonts.lato(
                                                                                /*backgroundColor: Colors
                                                                        .red
                                                                        .withOpacity(
                                                                            0.1),*/
                                                                                color: Colors.green)),
                                                                        Text(
                                                                            " ",
                                                                            style:
                                                                                GoogleFonts.lato(color: text1)),

                                                                        /* Text( ii == i['name']
                                                                      ? (int.parse(i['points']) *
                                                                                  quantity)
                                                                              .toString(): i['points']
                                                                              .toString() 
                                                                          ,style: GoogleFonts.lato(
                                                                            color: darkmode?Colors.amber.shade200:Colors.amber.shade900
                                                                          ),),
                                                                          Icon(Icons.diamond,color:icon1,size:17),*/
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                          width:
                                                                              20), //MediaQuery.of(context).size.width*.05),
                                                                      Text(
                                                                        lang2 != "Kiswahili (🇰🇪)"
                                                                            ? 'Save on ' +
                                                                                '${i['save1']}%'
                                                                            : 'okoa ' +
                                                                                '${i['save1']}%',
                                                                        style: GoogleFonts.lato(
                                                                            color: darkmode
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                            backgroundColor: darkmode ? Colors.white24 : Colors.orange.shade100),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    height: 10,
                                                                  ),
                                                                ])),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .37,
                                                          child: Column(
                                                              children: [
                                                                ListTile(
                                                                  //leading:
                                                                  title:
                                                                      const SizedBox(),
                                                                  //subtitle:
                                                                  trailing: InkWell(
                                                                      child: amount3.contains(i)
                                                                          ? const SizedBox()
                                                                          : Chip(
                                                                              avatar: Icon(!amount3.contains(i) ? Icons.shopping_cart_outlined : null, color: amount3.contains(i) ? Colors.green : Colors.green),
                                                                              label: lang2 != "Kiswahili (🇰🇪)" ? Text(amount3.contains(i) ? 'Added' : 'Add') : Text(amount3.contains(i) ? 'Umeweka' : 'weka'),
                                                                              backgroundColor: amount3.contains(i)
                                                                                  ?  !darkmode ? Colors.grey[200]?.withOpacity(0.4) : Colors.grey[200]?.withOpacity(0.4)
                                                                                  : Colors.white24),
                                                                      onTap: () {
                                                                        //order1
                                                                        //

                                                                        amount3.contains(i)
                                                                            ? ''
                                                                            : setState(() {
                                                                                //prev
                                                                                final prev = ii;
                                                                                if (prev == '1') {
                                                                                  quantity = 1;
                                                                                }
                                                                                ;
                                                                                cart.add([
                                                                                  i,
                                                                                  quantity == null ? 1 : quantity
                                                                                ]);
                                                                                //i.remove(i['image_url']);

                                                                                amount2.add([
                                                                                  i['name'],
                                                                                  i['image_url'].replaceAll(" ", ""),
                                                                                  quantity,
                                                                                  (int.parse(i['price']) * (quantity))
                                                                                ]);
                                                                                amount3.add(i);
                                                                                print("here's the " + amount3.toString());

                                                                                amount.add((int.parse(i['price']) * (quantity)));

                                                                                quantity = 1;
                                                                              });

                                                                        //_total(int.parse(i['price'])*int.parse(quantity));

                                                                        //print(quantity.toString());
                                                                        //print('Summenu'+(int.parse(i[0]['price'])*int.parse(quantity)).toString());
                                                                        //print(int.parse(i['price'])*quantity);

                                                                        //here set the state of the boolean
                                                                        //_increase(i['name']);

                                                                        SetState() {
                                                                          //amount.add();

                                                                          print(
                                                                              cart.length);
                                                                          final quantity =
                                                                              1;
                                                                          i['price'] =
                                                                              (int.parse(i['price']) * (quantity)).toString();
                                                                          print('amount' +
                                                                              amount.toString());
                                                                          print(
                                                                              i[0].toString());
                                                                        }

                                                                        ;
                                                                      }),
                                                                ),
                                                                ListTile(
                                                                    //leading:,Row(children:[ CircleAvatar(child:Icon(Icons.shopping_bag,color:Colors.green),radius:15,backgroundColor:Colors.grey[200])
                                                                    //    ,Text('1')])
                                                                    //trailing: Text(ii == i['name']?(int.parse(i['price'])*quantity).toString()+'/=':i['price'].toString()+'/=',style:GoogleFonts.lato(fontSize:15,fontWeight:FontWeight.bold)),

                                                                    //subtitle: Text(i['price'].toString()),
                                                                    title: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                      const Text(
                                                                          ""),
                                                                      amount3.contains(
                                                                              i)
                                                                          ? Container()
                                                                          : Container(
                                                                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                                                                                Container(
                                                                                  child: InkWell(
                                                                                      child: CircleAvatar(child: const Icon(Icons.add, color: Colors.green), radius: 15, backgroundColor: darkmode ? Colors.grey[200]?.withOpacity(0.4) : Colors.grey[200]),
                                                                                      onTap: () {
                                                                                        print(i['name']);
                                                                                        setState(() {
                                                                                          cart.contains(i['name']) ? Container() : _increase(i['name']);
                                                                                          print(cart);
                                                                                        });
                                                                                        print(quantity);
                                                                                      }),
                                                                                ),
                                                                                const Text('\t'),
                                                                                Text(ii == i['name'] ? quantity.toString() : '1', style: GoogleFonts.lato(color: text1)),
                                                                                const Text('\t'),
                                                                                InkWell(
                                                                                    child: CircleAvatar(child: const Icon(Icons.remove, color: Colors.green), radius: 15, backgroundColor: darkmode ? Colors.grey[200]?.withOpacity(0.4) : Colors.grey[200]),
                                                                                    onTap: () {
                                                                                      //print(i['name']);
                                                                                      setState(() {
                                                                                        if (quantity > 1) {
                                                                                          decrease(i['name']);
                                                                                        }
                                                                                      });
                                                                                      print(quantity);
                                                                                    }),
                                                                              ]),
                                                                            )
                                                                    ])),
                                                              ]),
                                                        )
                                                      ]),
                                                ),
                                              )

                                              //end
                                              ))
                                        ]))),
                              ],
                            ),
                            floatingActionButton: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  cart.length > 0
                                      ? Container(
                                          height: 70,
                                          width: 70,
                                          child: FloatingActionButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (context) {
                                                    return StatefulBuilder(
                                                        builder: (BuildContext
                                                                context,
                                                            StateSetter
                                                                setState /*You can rename this!*/) {
                                                      return Scaffold(
                                                        backgroundColor:
                                                            scaffold1,
                                                        appBar: AppBar(
                                                            centerTitle: true,
                                                            leading:
                                                                const SizedBox(),
                                                            title: Text("",
                                                                style: GoogleFonts.lato(
                                                                    color: Colors
                                                                        .black)),
                                                            elevation: 0.0,
                                                            backgroundColor:
                                                                scaffold1),
                                                        body: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .78,
                                                          child:
                                                              SingleChildScrollView(
                                                                  child: Column(
                                                            children: [
                                                              AppBar(
                                                                  centerTitle:
                                                                      true,
                                                                  title: Text(
                                                                      lang2 != "Kiswahili (🇰🇪)"
                                                                          ? "Cart"
                                                                          : "Mkoba",
                                                                      style: GoogleFonts.lato(
                                                                          color:
                                                                              text1)),
                                                                  elevation:
                                                                      0.0,
                                                                  backgroundColor:
                                                                      scaffold1),
                                                              Text(
                                                                  lang2 !=
                                                                          "Kiswahili (🇰🇪)"
                                                                      ? "You're planning to order :"
                                                                      : "Unapanga kununua :",
                                                                  style: GoogleFonts
                                                                      .lato(
                                                                          color:
                                                                              text1)),
                                                              ...cart.map(
                                                                //title:cart,title2:quantity.toString(),title3:amount
                                                                (i) => ListTile(
                                                                  leading:
                                                                      InkWell(
                                                                          child:
                                                                              CircleAvatar(
                                                                            backgroundColor:
                                                                                scaffold1,
                                                                            child:
                                                                                const Icon(
                                                                              Icons.delete,
                                                                              color: Colors.red,
                                                                            ),
                                                                          ),
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              amount3.remove(i);
                                                                              cart.remove(i);
                                                                              amount2.remove(i);
                                                                              amount2 = amount2;

                                                                              amount.remove((int.parse(i[0]['price']) * int.parse(i[1].toString())));
                                                                              Navigator.pop(context);
                                                                            });
                                                                          }),
                                                                  title: Text(
                                                                      i[0][
                                                                          'name'],
                                                                      style: GoogleFonts.lato(
                                                                          color:
                                                                              text1)),
                                                                  subtitle: Text(
                                                                      i[1]
                                                                          .toString(),
                                                                      style: GoogleFonts.lato(
                                                                          color:
                                                                              text1)), //
                                                                  trailing: Chip(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .yellow,
                                                                      label: Text(
                                                                          (int.parse(i[0]['price']) * int.parse(i[1].toString())).toString() +
                                                                              '\t' +
                                                                              "KES",
                                                                          style:
                                                                              GoogleFonts.lato(fontWeight: FontWeight.bold))),
                                                                ),
                                                                //amount.add((int.parse(i[0]['price'])*int.parse(i[1].toString())))
                                                              )
                                                            ],
                                                          )),
                                                        ),
                                                        //bottoma navigation bar
                                                        bottomNavigationBar:
                                                            Container(
                                                          color: scaffold1,
                                                          child: Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                .147,
                                                            child: Card(
                                                              elevation: 0,
                                                              color: scaffold1,
                                                              child: Column(
                                                                  children: [
                                                                    ListTile(
                                                                      title: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            /*Text('Total\t:'),Text(sum.toString()+'\tKES',style:GoogleFonts.lato(fontSize:25,fontWeight:FontWeight.bold ,color:Colors.green))*/
                                                                          ]),
                                                                      subtitle: titleController4.text !=
                                                                              ""
                                                                          ? const SizedBox() /*FloatingActionButton.extended(
                                                                        backgroundColor: Colors.amber,
                                                                        //icon: Icon(Icons.flatware_outlined),
                                                                        label: Text("Enter your Mpesa Phone number to complete"),
                                                                        onPressed: () {
                                                                          mpesacall();
                                                                        })*/
                                                                          : FloatingActionButton.extended(
                                                                              backgroundColor: Colors.green,
                                                                              //icon: Icon(Icons.flatware_outlined),
                                                                              label: Text(lang2 != "Kiswahili (🇰🇪)" ? "Proceed to Payments" : "Endelea ndio ulipe"),
                                                                              onPressed: () {
                                                                                startCheckout(
                                                                                    userPhone: titleController4.toString(),
                                                                                    //"254705412626",
                                                                                    amount: sum.toDouble()); //sum.toDouble()
                                                                                showModalBottomSheet(
                                                                                    context: context,
                                                                                    builder: (context) {
                                                                                      //sum = 0;
                                                                                      //var given_list = [1, 2, 3, 4, 5];
                                                                                      //this was once an issue it made the sum double
                                                                                      /*for (var i = 0; i < amount.length; i++) {
                                                                                                        sum += amount[i];
                                                                                                        };*/
                                                                                      return Scaffold(
                                                                                        backgroundColor: scaffold1,
                                                                                        appBar: AppBar(centerTitle: true, title: Text(lang2 != "Kiswahili (🇰🇪)" ? "Your Order" : "Order Yako", style: GoogleFonts.lato(color: text1)), elevation: 0.0, backgroundColor: scaffold1),
                                                                                        body: SingleChildScrollView(
                                                                                            child: Column(
                                                                                          children: [
                                                                                            Text(lang2 != "Kiswahili (🇰🇪)" ? "Your total is $sum KES" : "Jumla Yako ni $sum KES", style: GoogleFonts.lato(fontSize: 28, color: text1)),
                                                                                            const Text(""),
                                                                                            /*wild == null //wild is address name
                                                                                                ? const Text("")
                                                                                                : ListTile(title: Chip(avatar: const Icon(Icons.delivery_dining), label: Text("${wild}"))),
                                                                                            !address && wild == null
                                                                                                ? FloatingActionButton.extended(
                                                                                                    backgroundColor: Colors.teal,
                                                                                                    //icon: Icon(Icons.flatware_outlined),
                                                                                                    label: const Text('Pick delivery address'),
                                                                                                    onPressed: () {
                                                                                                      setState(
                                                                                                        () {
                                                                                                          address = true;
                                                                                                        },
                                                                                                      );
                                                                                                      showPlacePicker();
                                                                                                      //Navigator.pop(context);
                                                                                                      //Navigator.pop(context);
                                                                                                    })
                                                                                                : titleController4.text == ""
                                                                                                    ? Center(
                                                                                                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                                          Container(
                                                                                                            width: MediaQuery.of(context).size.width * .7,
                                                                                                            child: Padding(
                                                                                                              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
                                                                                                              //padding: EdgeInsets.symmetric(horizontal: 15),
                                                                                                              child: TextField(
                                                                                                                controller: titleController4,
                                                                                                                obscureText: false,
                                                                                                                decoration: InputDecoration(
                                                                                                                    filled: true,
                                                                                                                    fillColor: Colors.grey[100],
                                                                                                                    //fillColor: Colors.white,
                                                                                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),

                                                                                                                    //border: OutlineInputBorder(),
                                                                                                                    labelText: 'Mpesa phone number',
                                                                                                                    hintText: 'Enter your Mpesa Phone number'),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Container(
                                                                                                            width: MediaQuery.of(context).size.width * .1,
                                                                                                            child: FloatingActionButton(
                                                                                                              mini: true,
                                                                                                              onPressed: () {},
                                                                                                              child: const Icon(Icons.done),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ]),
                                                                                                      )
                                                                                                    : Container(
                                                                                                        child: Column(
                                                                                                        children: [
                                                                                                          works == '' ? const Text("initializing payments") : const Text("Confirm"),
                                                                                                          const ListTile(title: const Text("")),
                                                                                                          works == ''
                                                                                                              ? const Center(
                                                                                                                  child: CircularProgressIndicator(),
                                                                                                                )
                                                                                                              : ListTile(
                                                                                                                  title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                                                                                                    /*Text('Total\t:'),Text(sum.toString()+'\tKES',style:GoogleFonts.lato(fontSize:25,fontWeight:FontWeight.bold ,color:Colors.green))*/
                                                                                                                  ]),
                                                                                                                  //does not work trailing: Icon(Icons.arrow_circle_left_outlined),
                                                                                                                  subtitle: !softkey
                                                                                                                      ? FloatingActionButton.extended(
                                                                                                                          backgroundColor: Colors.teal,
                                                                                                                          //icon: Icon(Icons.flatware_outlined),
                                                                                                                          label: const Text(//Container(child: CircularProgressIndicator()):
                                                                                                                              'confirm Order'),
                                                                                                                          //    icon: Icon(Icons.arrow_circle_left_outlined),
                                                                                                                          onPressed: () {
                                                                                                                            print("${selectedTime.hour}:${selectedTime.minute + 10}");

                                                                                                                            widget.user.toString() == 'Menu'
                                                                                                                                ? showModalBottomSheet(
                                                                                                                                    context: context,
                                                                                                                                    builder: (context) {
                                                                                                                                      return const Scaffold();
                                                                                                                                    })
                                                                                                                                : '';
                                                                                                                            widget.user.split('|').length < 2
                                                                                                                                ? addata(widget.user.toString() == 'Menu' ? "Timed preorder" : "Summoning Waiter", '$sum', "${selectedTime.hour}:${selectedTime.minute}", 'ordername2')
                                                                                                                                : createAlbumx(
                                                                                                                                    '${widget.me.toString() + '|' + widget.user.toString() + '|' + sum.toString()}',
                                                                                                                                    '${amount2.toString()}',
                                                                                                                                    widget.user.split('|')[0].toString(), //,//widget.user.split('|')[0].split('/')[1].toString(),
                                                                                                                                    leo.toString());
                                                                                                                            Navigator.pop(context);
                                                                                                                            Navigator.push(context, MaterialPageRoute(builder: (context) => widget.user.toString() == 'Menu' ? screenxc2(title: "${selectedTime.hour}:${selectedTime.minute}") : screenxc2(title: "${selectedTime.hour}:${selectedTime.minute}")));
                                                                                                                            //Navigator.pop(context);
                                                                                                                            //Navigator.pop(context);
                                                                                                                            cart.clear();
                                                                                                                            setState(() {
                                                                                                                              cart.length = 0;
                                                                                                                              amount = [];
                                                                                                                            });
                                                                                                                          })
                                                                                                                      : Container(width: 20)),
                                                                                                        ],
                                                                                                      ))*/

                                                                                            //remove this section

                                                                                            FloatingActionButton.extended(
                                                                                                backgroundColor: Colors.teal,
                                                                                                //icon: Icon(Icons.flatware_outlined),
                                                                                                label: Text(//Container(child: CircularProgressIndicator()):
                                                                                                    lang2 != "Kiswahili (🇰🇪)" ? 'confirm Order' : "Thibitisha Order"),
                                                                                                //    icon: Icon(Icons.arrow_circle_left_outlined),
                                                                                                onPressed: () {
                                                                                                  print("${selectedTime.hour}:${selectedTime.minute + 10}");

                                                                                                  widget.user.toString() == 'Menu'
                                                                                                      ? showModalBottomSheet(
                                                                                                          context: context,
                                                                                                          builder: (context) {
                                                                                                            return const Scaffold();
                                                                                                          })
                                                                                                      : '';
                                                                                                  widget.user.split('|').length < 2
                                                                                                      ? addata(widget.user.toString() == 'Menu' ? "Timed preorder" : "Summoning Waiter", '$sum', "${selectedTime.hour}:${selectedTime.minute}", 'ordername2')
                                                                                                      : createAlbumx(
                                                                                                          '${widget.me.toString() + '|' + widget.user.toString() + '|' + sum.toString()}',
                                                                                                          '${amount2.toString()}',
                                                                                                          widget.user.split('|')[0].toString(), //,//widget.user.split('|')[0].split('/')[1].toString(),
                                                                                                          leo.toString());
                                                                                                  Navigator.pop(context);
                                                                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => widget.user.toString() == 'Menu' ? screenxc2(title: "${selectedTime.hour}:${selectedTime.minute}") : screenxc2(title: "${selectedTime.hour}:${selectedTime.minute}")));
                                                                                                  //Navigator.pop(context);
                                                                                                  //Navigator.pop(context);
                                                                                                  cart.clear();
                                                                                                  setState(() {
                                                                                                    cart.length = 0;
                                                                                                    amount = [];
                                                                                                  });
                                                                                                }),
                                                                                            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                                                                              //*/
                                                                                              const SizedBox(height: 20),

                                                                                              const SizedBox(height: 10),
                                                                                              ListTile(
                                                                                                  title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                                                                                    /*Text('Total\t:'),Text(sum.toString()+'\tKES',style:GoogleFonts.lato(fontSize:25,fontWeight:FontWeight.bold ,color:Colors.green))*/
                                                                                                  ]),
                                                                                                  subtitle: FloatingActionButton.extended(
                                                                                                      backgroundColor: Colors.redAccent,
                                                                                                      //icon: Icon(Icons.flatware_outlined),
                                                                                                      label: Text(lang2 != "Kiswahili (🇰🇪)" ? "Cancel" : "wacha"),
                                                                                                      onPressed: () {
                                                                                                        cart.clear();
                                                                                                        amount.clear();
                                                                                                        sum = 0;
                                                                                                        Navigator.push(
                                                                                                            context,
                                                                                                            MaterialPageRoute(
                                                                                                                builder: (context) => Rutimetable(
                                                                                                                    title: widget.title,
                                                                                                                    token: widget.token,
                                                                                                                    user: widget.user,
                                                                                                                    //final String food1;
                                                                                                                    me: widget.me,
                                                                                                                    firstname: widget.firstname,
                                                                                                                    id: widget.id)));
                                                                                                      }))

                                                                                              /*ListTile(
                                                                                    title: Row(
                                                                                        mainAxisAlignment:
                                                                                            MainAxisAlignment.end,
                                                                                        children: [
                                                                                          /*Text('Total\t:'),Text(sum.toString()+'\tKES',style:GoogleFonts.lato(fontSize:25,fontWeight:FontWeight.bold ,color:Colors.green))*/
                                                                                        ]),
                                                                                    subtitle: FloatingActionButton.extended(
                                                                                        backgroundColor: Colors.yellow[700],
                                                                                        //icon: Icon(Icons.flatware_outlined),
                                                                                        label: Text(widget.user.toString() == 'Menu' ? "set time for order" : "Other"),
                                                                                        onPressed: () {
                                                                                          sum =
                                                                                              0;
                                                                                          for (var i = 0;
                                                                                              i < amount.length;
                                                                                              i++) {
                                                                                            sum += amount[i];
                                                                                          }
                                                                                          ;
                                                                                          _selectTime(BuildContext context) async {
                                                                                            final timeOfDay = await showTimePicker(
                                                                                              context: context,
                                                                                              initialTime: selectedTime,
                                                                                              initialEntryMode: TimePickerEntryMode.dial,
                                                                                            );
                                                                                            if (timeOfDay != null && timeOfDay != selectedTime) {
                                                                                              //setState(() {
                                                                                              selectedTime = timeOfDay;
                                                                                            }
                                                                                          }
                                                                                                  
                                                                                          ;
                                                                                          _selectTime(context);
                                                                                          print("${selectedTime.hour}:${selectedTime.minute + 10}");
                                                                                                  
                                                                                          //timed order
                                                                                        }))*/
                                                                                            ]),
                                                                                          ],
                                                                                        )),
                                                                                        //bottoma navigation bar
                                                                                        bottomNavigationBar: Container(
                                                                                          height: 60,
                                                                                          child: const Align(alignment: Alignment.topCenter, child: null
                                                                                              /*Container(
                                                                        width: _bannerAd
                                                                            .size
                                                                            .width
                                                                            .toDouble(),
                                                                        height: 100,
                                                                        child: AdWidget(
                                                                            ad:
                                                                                _bannerAd,
                                                                            key:
                                                                                UniqueKey()),
                                                                      ),*/
                                                                                              ),
                                                                                        ),
                                                                                      );
                                                                                    });
                                                                                /*Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>trakstar(title:cart2),
                                                                          ),
                                                                        );*/
                                                                              } //scanQR(),

                                                                              // This trailing comma makes auto-formatting nicer for build methods.
                                                                              ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 2,
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          60,
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.topCenter,
                                                                        child:
                                                                            Container(
                                                                          width: _bannerAd
                                                                              .size
                                                                              .width
                                                                              .toDouble(),
                                                                          height:
                                                                              100,
                                                                          child:
                                                                              null /*AdWidget(
                                                        ad: _bannerAd,
                                                        key: UniqueKey())*/
                                                                          ,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 2,
                                                                    )
                                                                  ]),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                                  });
                                              /*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>trak(title:cart,title2:quantity.toString(),title3:amount),
                          ),
                        );*/
                                            },
                                            backgroundColor: Colors.green,
                                            elevation: 0.0,
                                            //mini: true,
                                            child: Center(
                                                child: Stack(
                                                    clipBehavior: Clip.none,
                                                    children: [
                                                  const Icon(
                                                      Icons
                                                          .shopping_cart_outlined,
                                                      size: 30,
                                                      color: Colors.yellow),
                                                  Positioned(
                                                      top: -3,
                                                      right: -4,
                                                      child: CircleAvatar(
                                                        radius: 6,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.red,
                                                          radius: 6,
                                                          child: Center(
                                                              child: Text(
                                                                  cart.length
                                                                      .toString(),
                                                                  style: GoogleFonts.lato(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          10)) //cartfav
                                                              ),
                                                        ),
                                                      ))
                                                ])),
                                          ),
                                        )
                                      : Container(),
                                ]))),
                  ),
                  autoPlay: true,
                  autoPlayDelay: const Duration(seconds: 3),
                ),
              ),
            ))
        : Scaffold(
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                Center(
                  child: Container(
                    // padding:EdgeInsets.all(8),
                    height: 100,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 30,
                              width: 30,
                              child: Image.asset("assets/carrot.png")),
                          Text("Freshfit",
                              style: GoogleFonts.lato(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                        ]),
                  ),
                ),
                Container(
                    height: 5,
                    width: 60,
                    child: const LinearProgressIndicator()),
              ])));
  }
}
