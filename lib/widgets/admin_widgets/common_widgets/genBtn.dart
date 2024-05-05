import 'package:ato/components/constants.dart';
import 'package:flutter/material.dart';

import '../../../components/app_layout.dart';

class GenBtn extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  const GenBtn({super.key, this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return InkWell(
        onTap: onTap,
        child: Container(
          width: size.width * 0.4,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: kPrimaryBtnColor,
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
