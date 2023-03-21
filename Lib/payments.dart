import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _deliveryAddress;
  late String _userName;
  late String _contactInfo;
  late DateTime _deliveryDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Information'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Delivery Address',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a delivery address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _deliveryAddress = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'User Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a user name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _userName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Contact Information',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter contact information';
                  }
                  return null;
                },
                onSaved: (value) {
                  _contactInfo = value!;
                },
              ),
              Container(
                padding: EdgeInsets.only(top: 16.0),
                child: RaisedButton(
                  child: Text('Select Delivery Date'),
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _deliveryDate = selectedDate;
                      });
                    }
                  },
                ),
              ),
              
              Container(
                padding: EdgeInsets.only(top: 16.0),
                child: RaisedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // TODO: Add code to submit payment information
                      print('Delivery Address: $_deliveryAddress');
                      print('User Name: $_userName');
                      print('Contact Information: $_contactInfo');
                      print('Delivery Date: $_deliveryDate');
}
},
),
),
],
),
),
),
);
}
}
