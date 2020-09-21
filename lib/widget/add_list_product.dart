import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ex1/screens/my_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddListProduct extends StatefulWidget {
  AddListProduct({Key key}) : super(key: key);

  @override
  _AddListProductState createState() => _AddListProductState();
}

class _AddListProductState extends State<AddListProduct> {
  //Field
  File file;
  String name, detail, urlPicture;

  //Method

  Widget upLoadButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: RaisedButton.icon(
            color: Colors.deepOrange,
            onPressed: () {
              print('You click upload');
              if (file == null) {
                showAlert(
                    'Non Choose Picture', 'Please Click Camera or Gallery');
              } else if (name == null ||
                  name.isEmpty ||
                  detail == null ||
                  detail.isEmpty) {
                showAlert('Have Space', 'Please Fill Every Blank');
              } else {
                // Upload Value To Firebase
                uploadPictureToStorage();
              }
            },
            icon: Icon(
              Icons.cloud_upload,
              color: Colors.white,
            ),
            label: Text(
              'Upload Data to Firebase',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> uploadPictureToStorage() async {
    Random random = Random();
    int i = random.nextInt(100000);
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    StorageReference storageReference =
        firebaseStorage.ref().child('Product/product$i.jpg');
    StorageUploadTask storageUploadTask = storageReference.putFile(file);
    urlPicture =
        await (await storageUploadTask.onComplete).ref.getDownloadURL();
    print('urlPicture = $urlPicture');
    insertValueToFireStore();
  }

  Future<void> insertValueToFireStore() async {
    Firestore firestore = Firestore.instance;
    Map<String, dynamic> map = Map();
    map['Name'] = name;
    map['Detail'] = detail;
    map['PathImage'] = urlPicture;
    await firestore.collection('Product').document().setData(map).then((value) {
      print('Insert Success');
      MaterialPageRoute route = MaterialPageRoute(
        builder: (value) => MyService(),
      );
      Navigator.of(context).pushAndRemoveUntil(route, (value) => false);
    });
  }

  Future<void> showAlert(String title, String message) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }

  Widget nameForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: TextField(
        onChanged: (String string) {
          name = string.trim();
        },
        decoration: InputDecoration(
            helperText: 'Type Your Name Of Product',
            icon: Icon(Icons.motorcycle),
            labelText: 'Name Product'),
      ),
    );
  }

  Widget detailForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: TextField(
        onChanged: (value) {
          detail = value.trim();
        },
        decoration: InputDecoration(
            helperText: 'Type Your Detail Of Product',
            icon: Icon(Icons.details),
            labelText: 'Detail Product'),
      ),
    );
  }

  Widget cameraButton() {
    return IconButton(
      icon: Icon(
        Icons.add_a_photo,
        size: 36,
        color: Colors.purple,
      ),
      onPressed: () {
        chooseImage(ImageSource.camera);
      },
    );
  }

  Future<void> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker.pickImage(
        source: imageSource,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Widget galleryButton() {
    return IconButton(
      icon: Icon(
        Icons.add_photo_alternate,
        size: 36,
        color: Colors.red,
      ),
      onPressed: () {
        chooseImage(ImageSource.gallery);
      },
    );
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        cameraButton(),
        galleryButton(),
      ],
    );
  }

  Widget showImage() {
    return Container(
      padding: EdgeInsets.all(20),
      // color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: file == null ? Image.asset('images/pic.png') : Image.file(file),
    );
  }

  Widget showContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          showImage(),
          showButton(),
          nameForm(),
          detailForm(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          showContent(),
          upLoadButton(),
        ],
      ),
    );
  }
}
