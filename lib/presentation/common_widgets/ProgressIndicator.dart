import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {

  const CustomProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withAlpha(200),
      child:const Center(
        child: SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            color: Colors.purple,
          ),
        ),
      ),
    );
  }
}
