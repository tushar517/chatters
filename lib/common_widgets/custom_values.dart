import 'package:flutter/material.dart';

LinearGradient purpleGradient = const LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  stops: [0.1, 1],
  colors: [
    Color(0xffC65647),
    Color(0xff9C3FE4),
  ],
);

LinearGradient greyGradient = const LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  stops: [0.1, 0.5, 1],
  colors: [
    Color(0xff2B2329),
    Color(0xff453A42),
    Color(0xff5C5062),
  ],
);

LinearGradient textGradient = const LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [1,0],
    colors: [
      Color(0xff7C01F6),
      Color(0xffB66DFF),
    ],
);

BoxDecoration textFieldDecoration = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: [0.1, 0.5, 1],
      colors: [
        Color(0xff2B2329),
        Color(0xff453A42),
        Color(0xff5C5062),
      ],
    ),
    border: Border.all(color: Colors.white, width: 0.3),
    borderRadius: const BorderRadius.all(Radius.circular(8))
);
