import 'package:flutter/material.dart';

class legal1 extends StatelessWidget {
  const legal1({Key? key, required this.darkmode}) : super(key: key);
  final bool darkmode;
  @override
  Widget build(BuildContext context) {
    String a = """

FreshFit Retail is an online grocery app that offers a wide range of fresh and healthy food products to customers. Our policy is to ensure the highest quality of products, the best customer service, and the highest standards of food safety. We are committed to providing our customers with an excellent shopping experience that is both convenient and easy to use.

Product Quality:

At FreshFit Retail, we are committed to providing only the highest quality of products. Our products are sourced from reliable and trusted suppliers who adhere to strict quality control measures. We guarantee that all our products are fresh, healthy, and safe to consume. If a customer finds any product to be of unsatisfactory quality, they can return it for a full refund.

Food Safety:

We take food safety very seriously at FreshFit Retail. All our products are handled and stored according to the highest food safety standards. We ensure that our suppliers follow the necessary food safety procedures, and our products are regularly tested to ensure they meet the required standards. We also have a strict policy on the use of preservatives and additives in our products. We only use natural preservatives and additives that are safe for consumption.

Delivery:

Our delivery policy is to ensure that our customers receive their orders in a timely and efficient manner. We have a team of dedicated delivery personnel who ensure that all orders are delivered on time. We offer same-day delivery for orders placed before a certain time, and we also offer the option of scheduled deliveries for our customers' convenience.

Pricing:

We offer competitive pricing for all our products, and we guarantee that our prices are fair and reasonable. We have a policy of transparency in pricing, and we do not add any hidden charges to our customers' orders. We also offer discounts and promotions from time to time to reward our loyal customers.

Customer Service:

Our policy is to provide the best customer service to our customers. We have a team of dedicated customer service representatives who are available to assist our customers with any queries or concerns they may have. We also have a customer feedback system in place to ensure that we continually improve our services based on our customers' feedback.

Conclusion:

FreshFit Retail is committed to providing the highest quality of products, the best customer service, and the highest standards of food safety. We believe in offering our customers a convenient and easy shopping experience that is both affordable and reliable. We are confident that our policies will ensure that our customers are satisfied with our services and will continue to use our app for all their grocery needs.


""";
    return Scaffold(
      backgroundColor: darkmode?Colors.black:Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("FreshFit's Policy",style: TextStyle(color: Colors.white),),
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Center(
              child: Container(
                  padding: EdgeInsets.all(8.0), child: Text(a.toString(),style: TextStyle(color: darkmode?Colors.white:Colors.black),)))
        ],
      )),
    );
  }
}

class legal2 extends StatelessWidget {
  legal2({Key? key, required this.darkmode}) : super(key: key);
  final bool darkmode;
  @override
  Widget build(BuildContext context) {
    String a = """

Welcome to FreshFit Retail Grocery App (hereafter referred to as “App”). By accessing and using the App, you agree to comply with these terms and conditions. If you do not agree with any of the terms and conditions, please do not use the App. The App is owned and operated by FreshFit Retail Private business entreprise.

Use of the App
2.1 The App is only for personal and non-commercial use. You may not use the App for any illegal or unauthorized purpose. You agree to comply with all applicable laws while using the App.

2.2 You must register and create an account to use the App. You are responsible for maintaining the confidentiality of your account and password. You agree to notify the Company immediately if you suspect any unauthorized use of your account.

2.3 You must provide accurate and complete information while registering and creating an account. You may not use false information or impersonate any person or entity.

2.4 You agree to accept all responsibility for any activity that occurs under your account.

2.5 You may not transfer or assign your account to any other person or entity without the prior written consent of the Company.

2.6 The Company reserves the right to suspend or terminate your account without notice if it believes that you have violated these terms and conditions.

Ordering and Delivery
3.1 You may place orders for groceries through the App. The Company will process your order and deliver the groceries to the address specified by you.

3.2 The Company reserves the right to accept or reject any order.

3.3 You must provide accurate and complete information while placing an order. You may not order any item that is illegal or prohibited by law.

3.4 The Company will make every effort to deliver the groceries at the specified time. However, the Company does not guarantee the delivery time.

3.5 The Company reserves the right to cancel any order without notice if it is unable to deliver the groceries for any reason.

3.6 You agree to accept the groceries at the specified delivery address. If you are not available at the delivery address, you may appoint a representative to accept the groceries on your behalf.

3.7 You must inspect the groceries at the time of delivery and report any damages or defects to the Company within 24 hours.

Pricing and Payment
4.1 The prices of groceries listed on the App are subject to change without notice.

4.2 You agree to pay the price of the groceries as listed on the App at the time of placing an order.

4.3 You may pay for the groceries using any of the payment options listed on the App.

4.4 You agree to provide accurate and complete payment information while making a payment.

4.5 The Company reserves the right to refuse or cancel any payment if it suspects any fraudulent or unauthorized activity.

4.6 The Company may charge a delivery fee for delivering the groceries to the specified address.

Intellectual Property
5.1 The App and all its content, including but not limited to text, graphics, logos, images, software, and audio, are the property of the Company or its licensors.

5.2 You may not copy, distribute, transmit, display, perform, reproduce, publish, license, modify, create derivative works from, transfer or sell any content obtained from the App without the prior written consent of the Company.

Disclaimer of Warranties
6.1 The App is provided on an “as is” and “as available” basis without any warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose, and non-infring





""";
    return Scaffold(
      backgroundColor: darkmode?Colors.black:Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Terms and Condition",style: TextStyle(color:Colors.white),),
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Center(
              child: Container(
                  padding: EdgeInsets.all(8.0), child: Text(a.toString(),style: TextStyle(color: darkmode?Colors.white:Colors.black),)))
        ],
      )),
    );
  }
}
