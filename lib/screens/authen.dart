import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  //Explicit

  //Method

  Widget backButton() {
    return IconButton(
        icon: Icon(
          Icons.navigate_before,
          size: 40,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        });
  }

  Widget content() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          showAppName(),
          emailText(),
          passwordText(),
        ],
      ),
    );
  }

  Widget showAppName() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        showLogo(),
        showText(),
      ],
    );
  }

  Widget showLogo() {
    return Container(
      width: 48,
      height: 48,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showText() {
    return Text(
      'Loh Shoppin Mail',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blue.shade700,
        fontFamily: 'Mansalva',
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget emailText() {
    return Container(
      width: 250,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            size: 36,
            color: Colors.blue.shade700,
          ),
          labelText: 'Email:',
          labelStyle: TextStyle(color: Colors.blue.shade700),
        ),
      ),
    );
  }

  Widget passwordText() {
    return Container(
      width: 250,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            size: 36,
            color: Colors.blue.shade700,
          ),
          labelText: 'Password:',
          labelStyle: TextStyle(color: Colors.blue.shade700),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            backButton(),
            content(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade700,
        child: Icon(Icons.navigate_next, size: 36),
        onPressed: () {},
      ),
    );
  }
}
