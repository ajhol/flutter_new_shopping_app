import 'package:ex1/widget/add_list_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ex1/screens/home.dart';
import 'package:ex1/widget/show_list_product.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  //Explicit
  String login = '...';
  Widget currentWidget = ShowListProduct();
  // Method
  @override
  void initState() {
    super.initState();
    findDisplyaName();
  }

  Widget showListProduct() {
    return ListTile(
      leading: Icon(
        Icons.list,
        size: 36,
        color: Colors.purple,
      ),
      title: Text('List Product'),
      subtitle: Text('Show All List Product'),
      onTap: () {
        setState(() {
          currentWidget = ShowListProduct();
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget showAddList() {
    return ListTile(
      leading: Icon(
        Icons.playlist_add,
        size: 36,
        color: Colors.green,
      ),
      title: Text('Add List Product'),
      subtitle: Text('Add new Product to Database'),
      onTap: () {
        setState(() {
          currentWidget = AddListProduct();
        });
        Navigator.of(context).pop();
      },
    );
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
    return Text(
      'login by $login',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget showAppName() {
    return Text(
      'Loh Shopping Mall',
      style: TextStyle(
          color: Colors.white,
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
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/shop.jpg'),
          fit: BoxFit.cover,
        )),
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
        children: [
          showHead(),
          showListProduct(),
          showAddList(),
        ],
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
      body: currentWidget,
      drawer: showDrawer(),
    );
  }
}
