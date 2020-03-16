import 'package:emailauth/widgets/user_edit_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserListWidget extends StatefulWidget {
  UserListWidget({Key key}) : super(key: key);

  @override
  _UserListWidgetState createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<UserListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: Firestore.instance.collection('user').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text("Loading");
          return ListView.builder(
            itemExtent: 80.0,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return _buildListItem(context, snapshot.data.documents[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      title: Text(document["name"]),
      subtitle: Text(document["email"]),
      onLongPress: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return UserEditWidget(document: document,);
        }));
      },
    );
  }
}
