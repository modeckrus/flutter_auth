import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserEditWidget extends StatefulWidget {
  UserEditWidget({Key key, @required this.document}) : super(key: key);
  final DocumentSnapshot document;
  @override
  _UserEditWidgetState createState() => _UserEditWidgetState(document);
}

class _UserEditWidgetState extends State<UserEditWidget> {
  final DocumentSnapshot document;
  final TextEditingController _emailController = TextEditingController();

  _UserEditWidgetState(this.document);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit user'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                  child: Text(
                '${document["name"]}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autovalidate: true,
                    autocorrect: false,
                  ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: RaisedButton(
                  child: Text("Change email"),
                  onPressed: (){
                    Firestore.instance.runTransaction((transaction)async{
                      DocumentSnapshot freshSnap = await transaction.get(document.reference);
                      await transaction.update(freshSnap.reference, {
                        'email': _emailController.text
                      });
                    });
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
