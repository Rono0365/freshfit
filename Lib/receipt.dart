import 'package:flutter/material.dart';

class traktar extends StatelessWidget {
  const traktar(
      {Key? key,
      required this.title,
      required this.title1,
      required this.darkmode,
      required this.text1,
      required this.scaffold1})
      : super(key: key);
  final List title;
  final String title1;
  final bool darkmode;
  final Color text1;
  final Color scaffold1;
  @override
  Widget build(BuildContext context) {
    List ttkes = [];
    List list_price = [];
    //var total => title[1].fold(0, (e, t) => e + t);
    print(title1.toString());
    //final xc =Todo;
    //ttkes.add((int.parse(i['price'])*int.parse(title2)));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(children: [
          Text("Stuff i've Ordered",
              style: TextStyle(backgroundColor: Colors.black45)),
          InkWell(
              child: Tab(
                  //onPressed:(){},
                  /*icon:CircleAvatar(
                                      backgroundColor: Colors.yellow,
                                      
                                      child: CircleAvatar(
                                        child: Icon(Icons.store,
                                          color: Colors.green),
                                          backgroundColor: Colors.white,
                                      
                                    )),*/
                  child: Text(
            "",
            style: TextStyle(color: Colors.black),
          ))),
        ]),
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ...title.reversed
                .where((op) => op['owner'].toString() == title1.toString())
                .map((i)
                        //var index = sky.indexOf(i);
                        =>
                        i['owner'].toString() != title1.toString()
                            ? Container()
                            : Card(
                                elevation: 0.9,
                                child: Column(children: [
                                  ListTile(
                                    leading: Text(i['time'].toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 21)),
                                    //trailing:Text(i['restaurantx'].toString())
                                    //title: Text('name',style:TextStyle(color:Colors.black)),
                                  ),
                                  ListTile(
                                    //leading: Text(i['time'].toString(),style:TextStyle(color:Colors.black)),
                                    title: Text("You Ordered:"),
                        

                                    //title: Text('name',style:TextStyle(color:Colors.black)),
                                  ),
                                  ...i['food']
                                      .replaceAll("],", "|")
                                      .replaceAll("[", "")
                                      .replaceAll("]]", "")
                                      .split("|")
                                      .map((k) => ListTile(
                                              title: Column(
                                            children: [
                                              Card(
                                                  elevation: 0,
                                                  color:  Colors.white12
                                                      ,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(3.0),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
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
                                                                        width:
                                                                            79,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          //color:Colors.green,
                                                                          borderRadius: BorderRadius.all(
                                                                              Radius.circular(10.0) //                 <--- border radius here
                                                                              ),
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                NetworkImage("${k.split(",")[1].toString().replaceAll(" ", "")}")
                                                                            //k.split(",")[1],                                                                         ),
                                                                            ,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            null,
                                                                      )
                                                                    ]),
                                                              ),
                                                            ),
                                                            Container(
                                                                width: MediaQuery.of(context)
                                                                            .size
                                                                            .width >
                                                                        600
                                                                    ? MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        .680
                                                                    : MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        .500,
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      ListTile(
                                                                        title:
                                                                            Text(
                                                                         "${k.split(
                                                                              ",")[0]}",
                                                                          style: TextStyle(
                                                                              fontSize: 17,
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        subtitle: Text(
                                                                          k.split(
                                                                              ",")[3],
                                                                          style: TextStyle(
                                                                              fontSize: 17,),
                                                                        ),
                                                                       
                                                                        /* subtitle: Wrap(
                                                                                                                                        children: [
                                                                                                                                          Text((int.parse(k.split(",")[3].toString()) * quantity).toString() + 'KES' : k.split(",")[3].toString() + 'KES',
                                                                                                                                              style: TextStyle(
                                                                                                                                                  /*backgroundColor: Colors
                                                                          .red
                                                                          .withOpacity(
                                                                              0.1),*/
                                                                                                                                                  color: Colors.green)),
                                                                                                                                          Text(" ", style: TextStyle(color: text1)),

                                                                                                                                          /* Text( ii == i['name']
                                                                        ? (int.parse(i['points']) *
                                                                                    quantity)
                                                                                .toString(): i['points']
                                                                                .toString() 
                                                                            ,style: TextStyle(
                                                                              color: darkmode?Colors.amber.shade200:Colors.amber.shade900
                                                                            ),),
                                                                            Icon(Icons.diamond,color:icon1,size:17),*/
                                                                                                                                        ],
                                                                                                                                      ),*/
                                                                      ),
                                                                      
                                                                    ])),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .137,
                                                              child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    // ListTile(),
                                                                    Center(
                                                                      child:
                                                                          ListTile(
                                                                        title: Center(
                                                                            child:
                                                                                Text(k.split(",")[2].toString(), style: TextStyle(fontWeight: FontWeight.bold, color: text1))),
                                                                        //leading:,Row(children:[ CircleAvatar(child:Icon(Icons.shopping_bag,color:Colors.green),radius:15,backgroundColor:Colors.grey[200])
                                                                        //    ,Text('1')])
                                                                        //trailing: Text(ii == i['name']?(int.parse(i['price'])*quantity).toString()+'/=':i['price'].toString()+'/=',style:TextStyle(fontSize:15,fontWeight:FontWeight.bold)),

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
                                              SizedBox(height: 10),
                                              Container(
                                                  height: 0.07,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .8,
                                                  color: text1),
                                              SizedBox(height: 10),
                                            ],
                                          )
                                              //Text(k.split(",")[0].toString()),

                                              )),
                                  ListTile(
                                    //leading: Text(i['time'].toString(),style:TextStyle(color:Colors.black)),
                                    title: Text('You spent a total of:'),
                                    subtitle: Text(i['totalprice'].toString() +
                                        '\tKES'), //

                                    //title: Text('name',style:TextStyle(color:Colors.black)),
                                  ),
                                ]))

                    //play within this boundaries
                    ),
          ],
        )),
      ),
      /*bottomNavigationBar:Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
         children:[InkWell(child:Tab(
           //onPressed:(){},
                                    icon:CircleAvatar(
                                      backgroundColor: Colors.yellow,
                                      
                                      child: CircleAvatar(
                                        child: Icon(Icons.store,
                                          color: Colors.green),
                                          backgroundColor: Colors.white,
                                      
                                    )),
                                    child: Text(
                                      "Orders",
                                      style: TextStyle(color: Colors.black),
                                    ))),
                                    
                                    /*InkWell(child:Tab(
                                    icon: CircleAvatar(
                                      child: Icon(Icons.restaurant,
                                          color: Colors.green),
                                      backgroundColor: Colors.yellow,
                                    ),
                                    child: Text(
                                      "Menu",
                                      style: TextStyle(color: Colors.black),
                                    )),onTap:(){
                                      Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>Rutimetable(
                                                  title:'1',
                                                  token: widget.token,
                                                  user:'Restaurant Menu'
                                                )
                                                    
                                                ), //MaterialPageRoute
                                          );


                                   
                                    }),
                                    InkWell(child:Tab(
                                    icon: CircleAvatar(
                                      child: Icon(Icons.query_stats,
                                          color: Colors.green),
                                      backgroundColor: Colors.yellow,
                                    ),
                                    child: Text(
                                      "Data",
                                      style: TextStyle(color: Colors.black),
                                    )),onTap:(){
                                      Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>stats(
                                                  title:'1',
                                                  token: widget.token,
                                                  user:'Restaurant Menu'
                                                )
                                                    
                                                ), //MaterialPageRoute
                                          );


                                   
                                    })*/
                                    
                                    ]),*/
      /*floatingActionButton: FloatingActionButton(
        backgroundColor:Colors.green,//.withOpacity(0.9),
        onPressed: (){
          //getWeather();
          //rono = false;
        },//_incrementCounter,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),*/ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
