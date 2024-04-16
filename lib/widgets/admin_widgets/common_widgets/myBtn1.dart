import 'package:flutter/material.dart';

class MyBtn1 extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  const MyBtn1({super.key, this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(horizontal: 55),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: Text(
              "$buttonText",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ));
  }
}
