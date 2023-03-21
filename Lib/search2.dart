import 'package:flutter/material.dart';
import 'menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//Rutimetable
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_helper.dart';
import 'package:http/http.dart' as http;
import 'orders.dart';
import 'preorder.dart';
//import 'mpesa.dart';
import 'thank.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'restaurants.dart';
import 'package:collection/collection.dart';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'search2.dart';
import 'package:mpesa/mpesa.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class searchQ7 extends StatefulWidget {
  searchQ7(
      {Key? key,
      required this.misearch,
      required this.me,
      required this.colorx,
      required this.username,
      required this.xme,
      required this.token})
      : super(key: key);
  List misearch;
  String username;
  Color colorx;
  bool xme;
  String me;
  String token;
  @override
  State<searchQ7> createState() => _searchQ7State();
}

class _searchQ7State extends State<searchQ7> {
  final titleController = TextEditingController();
  List ronox = [];

  String ii = '1';
  var week_area;
  var leo;
  var now;
  List<List> cart = [];
  List amount = [];
  var quantity;
  List<List> cart2 = [];
  List amount2 = [];
  List amount3 = [];

  var food2;
  late var selectedTime = TimeOfDay.now();
  var food7;
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

  void decrease(String i) {
    final prev = ii;
    ii = i;
    if (prev != ii) {
      quantity = 1;
    }
    quantity--;
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
    print('ruined sum' + zum.toString());
    print('rono' + token);
    //print(widget.token); wasn't easy but never stopped
    var headers = {
      'Authorization': 'Token ${token}',
    };
    http.Response responsev =
        await http.post(Uri.parse('http://192.168.100.12:7000/order/'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Token $token',
            },
            body: jsonEncode(<String, String>{
              'table': "search",
              'food': '${amount2.toString()}', //list for food
              'restaurantx': widget.username.toString(),
              'time': now.toString() + '\t ,' + leo.toString(),
              'owner': widget.me.toString(),
              //$sum
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
        .get(Uri.parse('http://afleet.co.ke/food/'), headers: headers);
    var xcv = jsonDecode(responsev.body);
    setState(() {
      food7 = xcv;
    });
    print(food7);
  }

  Future getWealth() async {
    String token = widget.token.toString();
    //String id = widget.userid.toString();

    //print(widget.token); wasn't easy but never stopped
    var headers = {
      'Authorization': 'Token $token',
    };
    http.Response responsev = await http
        .get(Uri.parse('http://192.168.100.12:7000/order/'), headers: headers);
    var xcv = jsonDecode(responsev.body);
    setState(() {
      food2 = xcv;
    });
    //print(food1);
  }

  /* */
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List rono = widget.misearch;
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

    void sq(List x) {
      setState(() => ronox = x);
      print(ronox);

      //rono was here 5/20/22~2:29am
      //rono was here again 6/9/22~4:15am
      //rono was here again 1/10/23~2:20pm
    }

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
            callBackURL: Uri(
                scheme: "https", host: "1234.1234.co.ke", path: "/1234.php"),
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

    @override
    void initState() {
      super.initState();
      //DateFormat('EEEE').format(date);
      week_area = DateFormat('d MMM').format(DateTime.now());
      leo = DateFormat.jm().format(DateTime.now());
      now = DateFormat('EEEE d MMM')
          .format(DateTime.now()); //returns json body from api
      print(leo);
      //this.courseblock = result1;
      titleController.text = '';
      print('search bar' + titleController.text);
    }

    return Scaffold(
        backgroundColor: widget.colorx,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: cart.length > 0
            ? FloatingActionButton.extended(
                onPressed: () {
                  showModalBottomSheet(
                      //isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(builder: (BuildContext context,
                            StateSetter setState /*You can rename this!*/) {
                          return Scaffold(
                            backgroundColor: widget.colorx,
                            appBar: AppBar(
                                centerTitle: true,
                                title: Text("Cart",
                                    style: TextStyle(color: Colors.black)),
                                elevation: 0.0,
                                backgroundColor: Colors.white),
                            body: SingleChildScrollView(
                                child: Column(
                              children: [
                                Text("You're planning to order:"),
                                ...cart.map(
                                  //title:cart,title2:quantity.toString(),title3:amount
                                  (i) => ListTile(
                                    leading: InkWell(
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            amount3.remove(i);
                                            cart.remove(i);
                                            amount2.remove(i);
                                            amount2 = amount2;

                                            amount.remove((int.parse(
                                                    i[0]['price']) *
                                                int.parse(i[1].toString())));
                                            Navigator.pop(context);
                                          });
                                        }),
                                    title: Text(i[0]['name'],
                                        style: TextStyle(color: Colors.black)),
                                    subtitle: Text(i[1].toString()), //
                                    trailing: Chip(
                                        backgroundColor: Colors.yellow,
                                        label: Text(
                                            (int.parse(i[0]['price']) *
                                                        int.parse(
                                                            i[1].toString()))
                                                    .toString() +
                                                '\t' +
                                                "KES",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))),
                                  ),
                                  //amount.add((int.parse(i[0]['price'])*int.parse(i[1].toString())))
                                )
                              ],
                            )),
                            //bottoma navigation bar
                            bottomNavigationBar: ListTile(
                              title: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    /*Text('Total\t:'),Text(sum.toString()+'\tKES',style:TextStyle(fontSize:25,fontWeight:FontWeight.bold ,color:Colors.green))*/
                                  ]),
                              subtitle: FloatingActionButton.extended(
                                  backgroundColor: Colors.green,
                                  //icon: Icon(Icons.flatware_outlined),
                                  label: Text("Order"),
                                  onPressed: () {
                                    //var sum;
                                    startCheckout(
                                        userPhone: "254705412626",
                                        amount:
                                            sum.toDouble()); //sum.toDouble()
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
                                            backgroundColor: Colors.white,
                                            appBar: AppBar(
                                                centerTitle: true,
                                                title: Text("Your Order",
                                                    style: TextStyle(
                                                        color: Colors.black)),
                                                elevation: 0.0,
                                                backgroundColor: Colors.white),
                                            body: SingleChildScrollView(
                                                child: Column(
                                              children: [
                                                Text("Your total is $sum KES",
                                                    style: TextStyle(
                                                        fontSize: 28)),
                                                Text(""),
                                                ListTile(title: Text("")),
                                                works == ''
                                                    ? Text(
                                                        "initializing payments")
                                                    : Text("Confirm"),
                                                ListTile(title: Text("")),
                                                works == ''
                                                    ? Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : ListTile(
                                                        title: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              /*Text('Total\t:'),Text(sum.toString()+'\tKES',style:TextStyle(fontSize:25,fontWeight:FontWeight.bold ,color:Colors.green))*/
                                                            ]),
                                                        //does not work trailing: Icon(Icons.arrow_circle_left_outlined),
                                                        subtitle: !softkey
                                                            ? FloatingActionButton
                                                                .extended(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .teal,
                                                                    //icon: Icon(Icons.flatware_outlined),
                                                                    label: Text(
                                                                        //Container(child: CircularProgressIndicator()):
                                                                        'confirm Order'),
                                                                    //    icon: Icon(Icons.arrow_circle_left_outlined),
                                                                    onPressed:
                                                                        () {
                                                                      print(
                                                                          "${selectedTime.hour}:${selectedTime.minute + 10}");

                                                                      widget.username.toString() ==
                                                                              'Menu'
                                                                          ? showModalBottomSheet(
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return Scaffold();
                                                                              })
                                                                          : '';
                                                                      widget.username.split('|').length < 2
                                                                              ? addata(widget.username.toString() == 'Menu' ? "Timed preorder" : "Summoning Waiter", '$sum', "${selectedTime.hour}:${selectedTime.minute}", 'ordername2')
                                                                              : '' /*createAlbumx(
                                                                              '${widget.me.toString() + '|' + widget.username.toString() + '|' + sum.toString()}',
                                                                              '${amount2.toString()}',
                                                                              widget.username.split('|')[0].toString(), //,//widget.user.split('|')[0].split('/')[1].toString(),
                                                                              leo.toString())*/
                                                                          ;
                                                                      Navigator.pop(
                                                                          context);
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => widget.username.toString() == 'Menu' ? screenxc2(title: "${selectedTime.hour}:${selectedTime.minute}") : screenxc2(title: "${selectedTime.hour}:${selectedTime.minute}")));
                                                                      //Navigator.pop(context);
                                                                      //Navigator.pop(context);
                                                                      cart.clear();
                                                                      setState(
                                                                          () {
                                                                        cart.length =
                                                                            0;
                                                                        amount =
                                                                            [];
                                                                      });
                                                                    })
                                                            : Container(
                                                                width: 20)),
                                                Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      //*/
                                                      SizedBox(height: 20),

                                                      SizedBox(height: 10),
                                                      ListTile(
                                                          title: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                /*Text('Total\t:'),Text(sum.toString()+'\tKES',style:TextStyle(fontSize:25,fontWeight:FontWeight.bold ,color:Colors.green))*/
                                                              ]),
                                                          subtitle: FloatingActionButton
                                                              .extended(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .redAccent,
                                                                  //icon: Icon(Icons.flatware_outlined),
                                                                  label: Text(widget
                                                                              .username
                                                                              .toString() ==
                                                                          'Menu'
                                                                      ? "Cancel"
                                                                      : "Cancel"),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    Navigator.pop(
                                                                        context);
                                                                    Navigator.pop(
                                                                        context);
                                                                  }))

                                                      /*ListTile(
                                                                          title: Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.end,
                                                                              children: [
                                                                                /*Text('Total\t:'),Text(sum.toString()+'\tKES',style:TextStyle(fontSize:25,fontWeight:FontWeight.bold ,color:Colors.green))*/
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
                icon: Center(
                    child: Stack(clipBehavior: Clip.none, children: [
                  Icon(Icons.shopping_cart_outlined, color: Colors.yellow),
                  Positioned(
                      top: -3,
                      right: -4,
                      child: CircleAvatar(
                        radius: 6,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 6,
                          child: Center(
                              child: Text(cart.length.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10)) //cartfav
                              ),
                        ),
                      ))
                ])),
                label: Text("Continue"),
              )
            : Container(),
        // backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90.0), // here the desired height
          child: AppBar(
            elevation: 0.0,
            backgroundColor: widget.colorx,
            leading: Container(),
            centerTitle: true,
            flexibleSpace: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(),
                  //Text(widget.misearch.toString()),
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * 7,
                    color: widget.colorx,
                    child: Padding(
                      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                      padding: EdgeInsets.symmetric(horizontal: 15),
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
                            prefixIcon: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back,
                                    color: widget.xme
                                        ? Colors.white
                                        : Colors.black)),
                            suffixIcon: woz
                                ? InkWell(
                                    child: Icon(Icons.close,
                                        color: widget.xme
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
                            fillColor: !widget.xme
                                ? Colors.white
                                : Colors.grey.shade800,
                            //fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(60.0)),
                            //labelText: 'Search',
                            hintText: 'Type to Search and see suggestions'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: ronox != ''
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Wrap(
                      spacing: 5.0,
                      children: [...chosen.map((d) => Chip(label: Text(d)))],
                    ),
                    //Text(ronox.toString()),
                    ...ronox.map((i) => Card(
                        color: !widget.xme
                            ? !amount3.contains(i)
                                ? Colors.white
                                : Colors.amber.shade50
                            : !amount3.contains(i)
                                ? Colors.black
                                : Colors.amber.shade50,
                        elevation: 0,
                        child: Container(
                          padding: EdgeInsets.all(3.0),
                          child: Row(children: [
                            Container(
                                height: MediaQuery.of(context).size.width * .19,
                                width: MediaQuery.of(context).size.width * .19,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          10.0) //                 <--- border radius here
                                      ),
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(i['image_url'].toString()),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: null),
                            Container(
                              width: MediaQuery.of(context).size.width * .77,
                              child: Column(children: [
                                ListTile(
                                  //leading:
                                  title: Text(
                                    i['name'].toString(),
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                      color: widget.xme
                                          ? amount3.contains(i)
                                              ? Colors.black
                                              : Colors.white
                                          : amount3.contains(i)
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                  ),
                                  //subtitle:
                                  trailing: InkWell(
                                      child: Chip(
                                          avatar: Icon(
                                              !amount3.contains(i)
                                                  ? Icons.shopping_cart_outlined
                                                  : null,
                                              color: amount3.contains(i)
                                                  ? Colors.green
                                                  : Colors.green),
                                          label: Text(amount3.contains(i)
                                              ? 'Added'
                                              : 'Add'),
                                          backgroundColor: amount3.contains(i)
                                              ? Colors.amber.shade50
                                              : Colors.yellow.withOpacity(0.2)),
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
                                                  quantity == null
                                                      ? 1
                                                      : quantity
                                                ]);
                                                //i.remove(i['image_url']);

                                                amount2.add([
                                                  i['name'],
                                                  quantity,
                                                  (int.parse(i['price']) *
                                                      (quantity))
                                                ]);
                                                amount3.add(i);
                                                print("here's the " +
                                                    amount3.toString());

                                                amount.add(
                                                    (int.parse(i['price']) *
                                                        (quantity)));

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
                                          i['price'] = (int.parse(i['price']) *
                                                  (quantity))
                                              .toString();
                                          print('amount' + amount.toString());
                                          print(i[0].toString());
                                        }

                                        ;
                                      }),
                                ),
                                ListTile(
                                    //leading:,Row(children:[ CircleAvatar(child:Icon(Icons.shopping_bag,color:Colors.green),radius:15,backgroundColor:Colors.grey[200])
                                    //    ,Text('1')])
                                    //trailing: Text(ii == i['name']?(int.parse(i['price'])*quantity).toString()+'/=':i['price'].toString()+'/=',style:TextStyle(fontSize:15,fontWeight:FontWeight.bold)),

                                    //subtitle: Text(i['price'].toString()),
                                    title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                      Text(
                                          ii == i['name']
                                              ? (int.parse(i['price']) *
                                                          quantity)
                                                      .toString() +
                                                  'KES'
                                              : i['price'].toString() + 'KES',
                                          style: TextStyle(
                                            color: widget.xme
                                                ? amount3.contains(i)
                                                    ? Colors.black
                                                    : Colors.white
                                                : amount3.contains(i)
                                                    ? Colors.white
                                                    : Colors.black,
                                          )),
                                      amount3.contains(i)
                                          ? Container()
                                          : Container(
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                      child: InkWell(
                                                          child: CircleAvatar(
                                                              child: Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .green),
                                                              radius: 15,
                                                              backgroundColor:
                                                                  Colors.grey[
                                                                      200]),
                                                          onTap: () {
                                                            print(i['name']);
                                                            setState(() {
                                                              cart.contains(
                                                                      i['name'])
                                                                  ? Container()
                                                                  : _increase(i[
                                                                      'name']);
                                                              print(cart);
                                                            });
                                                            print(quantity);
                                                          }),
                                                    ),
                                                    Text('\t'),
                                                    Text(
                                                      ii == i['name']
                                                          ? quantity.toString()
                                                          : '1',
                                                      style: TextStyle(
                                                        color: widget.xme
                                                            ? amount3
                                                                    .contains(i)
                                                                ? Colors.black
                                                                : Colors.white
                                                            : amount3
                                                                    .contains(i)
                                                                ? Colors.white
                                                                : Colors.black,
                                                      ),
                                                    ),
                                                    Text('\t'),
                                                    InkWell(
                                                        child: CircleAvatar(
                                                            child: Icon(
                                                                Icons.remove,
                                                                color: Colors
                                                                    .green),
                                                            radius: 15,
                                                            backgroundColor:
                                                                Colors
                                                                    .grey[200]),
                                                        onTap: () {
                                                          //print(i['name']);
                                                          setState(() {
                                                            if (quantity > 1) {
                                                              decrease(
                                                                  i['name']);
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
                        )

                        //end
                        ))
                    //Text('xcd' + ronox.toString()),
                  ],
                ),
              )
            : Scaffold(
                body: Column(
                children: [
                  ListTile(
                    title: Text(''),
                  ),
                ],
              )));
  }
}
