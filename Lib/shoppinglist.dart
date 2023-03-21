import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//void main() => runApp(MyshopL());

class MyshopL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping List',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ShoppingListPage(
        title: false,
      ),
    );
  }
}

class ShoppingListPage extends StatefulWidget {
  ShoppingListPage({Key? key,
      required this.title,
  }): super(key: key);
  final bool title;
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState(
    
  );
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  List<String> _shoppingList = [];

  @override
  void initState() {
    super.initState();
    _loadShoppingList();
  }

  _loadShoppingList() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _shoppingList = prefs.getStringList('shopping_list') ?? [];
    });
  }

  _saveShoppingList() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('shopping_list', _shoppingList);
  }

  @override
  void dispose() {
    _saveShoppingList();
    super.dispose();
  }

  void _addItem(String item) {
    setState(() {
      _shoppingList.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.title?Colors.black:Colors.white,
      appBar: AppBar(
        //leading: ,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text('Shopping List',style: TextStyle(color: !widget.title?Colors.black:Colors.white),),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: _shoppingList.length,
          itemBuilder: (context, index) {
            final item = _shoppingList[index];
            return Dismissible(
              key: Key(item),
              onDismissed: (direction) {
                setState(() {
                  _shoppingList.removeAt(index);
                });
              },
              child:Card( 
                color: Colors.transparent,
                elevation: 0,
              child:Column(children: [
              ListTile(
                //tileColor: Colors.green.withOpacity(0.4),
                leading: 
                CircleAvatar(
                  radius: 12,
                  child: Center(child: Text(_shoppingList.indexOf(item).toString()))),
                title: Text(item,
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: !widget.title?Colors.black:Colors.white,
                                          //fontWeight: FontWeight.bold
                                          
                                          ),),
                subtitle: Text(""),
              ),
              SizedBox(height: 10,),
              Container(height: 0.07,
              color: !widget.title?Colors.black:Colors.white,
              width: MediaQuery.of(context).size.width*.9,
              )
              ])));
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: Center(child: Text("Swipe to remove a product",style: TextStyle(color: !widget.title?Colors.black:Colors.white),))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final itemController = TextEditingController();
              return AlertDialog(
                title: Text('Add Item'),
                content: TextField(
                  controller: itemController,
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  FlatButton(
                    onPressed: () {
                      _addItem(itemController.text);
                      Navigator.pop(context);
                    },
                    child: Text('Add'),
                  ),
                ],
                    );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}




