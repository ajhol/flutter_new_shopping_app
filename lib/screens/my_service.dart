import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ex1/screens/home.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  //Explicit
  String login = '...';
  // Method
  @override
  void initState() {
    super.initState();
    findDisplyaName();
  }

  Future<void> findDisplyaName() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    setState(() {
      login = firebaseUser.displayName;
    });
    print('login = $login');
  }

  Widget showLogin() {
    return Text('Login by $login');
  }

  Widget showAppName() {
    return Text(
      'Loh Shopping Mall',
      style: TextStyle(
          color: Colors.blue.shade700,
          fontFamily: 'Mansalva',
          fontWeight: FontWeight.bold,
          fontSize: 18),
    );
  }

  Widget showLogo() {
    return Container(
      width: 80,
      height: 80,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showHead() {
    return DrawerHeader(
        child: Column(
      children: [
        showLogo(),
        showAppName(),
        SizedBox(height: 6),
        showLogin(),
      ],
    ));
  }

  Widget showDrawer() {
    return Drawer(
      child: ListView(
        children: [showHead()],
      ),
    );
  }

  Widget signOutButton() {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      tooltip: 'Sign Out',
      onPressed: () {
        myAlert();
      },
    );
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are You Sure ?'),
            content: Text('Do You Want Sign Out?'),
            actions: [cancelButton(), okButton()],
          );
        });
  }

  Widget okButton() {
    return FlatButton(
      onPressed: () {
        Navigator.of(context).pop();
        processSignOut();
      },
      child: Text('OK'),
    );
  }

  Future<void> processSignOut() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut().then((response) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Home());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  Widget cancelButton() {
    return FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('Cancel'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
        actions: [signOutButton()],
      ),
      body: Text('Body'),
      drawer: showDrawer(),
    );
  }
}
