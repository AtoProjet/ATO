import 'package:flutter/material.dart';

class Topbar extends StatelessWidget {
  final Function()? onTap;
  final bool isBack;
  const Topbar({super.key, this.onTap, required this.isBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 15),
      alignment: Alignment.bottomRight,
      width: double.infinity,
      height: 100.0,
      child: SizedBox(
        height: 80,
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (isBack) GestureDetector(
              onTap: onTap,
              child: Icon(
                Icons.arrow_back,
              ),
            ),
            Image(
              image: AssetImage('assets/images/ic_logo.jpg'),
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
