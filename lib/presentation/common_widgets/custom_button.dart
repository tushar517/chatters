import 'package:chat_app/presentation/common_widgets/custom_values.dart';
import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  final double width;
  final Function() onPress;
  final String btntext;
  final bool isEnable;
  const CustomButton({super.key, required this.width, required this.onPress, required this.btntext, required this.isEnable});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.only(left: 20,right: 20),
      decoration: BoxDecoration(
          gradient: (isEnable)?purpleGradient:greyGradient,
          borderRadius:const BorderRadius.all(Radius.circular(15)),
      ),
      child: IgnorePointer(
        ignoring: (!isEnable),
        child: MaterialButton(
          onPressed: onPress,
          minWidth: double.infinity,
          child:Text(
            btntext,
            style:const TextStyle(color: Colors.white),
          )
        ),
      ),
    );
  }
}
