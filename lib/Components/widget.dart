import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:mentor_app/Utils/color.dart';

Widget body(context, {Widget? child}) {
  double height = MediaQuery.sizeOf(context).height;
  return Scaffold(
    body: Stack(
      children: [
        Container(
          height: height / 1.5,
          decoration: BoxDecoration(color: mainColor),
          child: child,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: height / 2,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(100))),
              child: child,
            ),
          ],
        )
      ],
    ),
  );
}

toast({required String? text}) {
  return BotToast.showText(
      text: text ?? '',
      contentColor: Colors.grey.shade800,
      textStyle: const TextStyle(color: Colors.white, fontSize: 15));
}
