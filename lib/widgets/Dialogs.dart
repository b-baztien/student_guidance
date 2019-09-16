import 'package:flutter/material.dart';
class Dialogs{
  waiting(BuildContext context,String title,String description){
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(description)
                  ],
                ),
              ),
            );
          }
      );
  }
}