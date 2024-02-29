import 'package:chat_app/common_widgets/custom_values.dart';
import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  final double width;
  final Function() onPress;
  final String btntext;
  final bool isEnable;
  final bool isLoading;
  const CustomButton({super.key, required this.width, required this.onPress, required this.btntext, required this.isEnable, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.only(left: 20,right: 20),
      decoration: BoxDecoration(
          gradient: (isEnable && !isLoading)?purpleGradient:greyGradient,
          borderRadius:const BorderRadius.all(Radius.circular(15)),
      ),
      child: IgnorePointer(
        ignoring: (!isEnable || isLoading),
        child: MaterialButton(
          onPressed: onPress,
          minWidth: double.infinity,
          child: (!isLoading)?Text(
            btntext,
            style:const TextStyle(color: Colors.white),
          ):const CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
