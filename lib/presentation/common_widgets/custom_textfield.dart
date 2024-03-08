import 'package:chat_app/presentation/common_widgets/custom_values.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String prefixIcon;
  final Function(String) onValueChange;
  final bool isObscure;
  final bool isPassword;
  final bool isHint;
  const CustomTextField({
    super.key,
    required this.label,
    required this.prefixIcon,
    required this.onValueChange,
    required this.isObscure,
    this.isPassword = false,
    this.isHint = true
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscure = true;

  @override
  void initState() {
    super.initState();
    obscure = widget.isObscure;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
              color: Color(0xffA4A4A4),
              fontSize: 15,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: textFieldDecoration,
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.isHint?widget.label:'',
                hintStyle: const TextStyle(
                  color: Color(0xffA4A4A4),
                ),
                isDense: true,
                prefixIcon: Image(image: AssetImage(widget.prefixIcon)),
                contentPadding: const EdgeInsets.only(left: 10),
                suffixIcon: widget.isPassword
                    ? IconButton(
                      icon: Icon(
                        obscure ? Icons.visibility : Icons.visibility_off,
                        size: 24,
                      ),
                      onPressed: (){
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                    )
                    : SizedBox()),
            cursorColor: Colors.white,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            onChanged: widget.onValueChange,
            obscureText: obscure,
            style: const TextStyle(color: Colors.white60),
          ),
        ),
      ],
    );
  }
}
