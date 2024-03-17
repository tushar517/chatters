import 'package:flutter/material.dart';

void showSnackBar(BuildContext context,String content,bool isSuccess){
  ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(isSuccess?Icons.check_circle_outline:Icons.cancel_outlined,color: Colors.white,),
              SizedBox(width: 10,),
              Text(content)
            ],
          ),
          backgroundColor: isSuccess?Colors.greenAccent:Colors.redAccent,
        )
      );
}