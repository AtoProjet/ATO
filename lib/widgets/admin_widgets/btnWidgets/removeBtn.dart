
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../components/constants.dart';

class RemoveBtn extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  const RemoveBtn({Key? key, this.onTap, required this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: kRemoveButtonColor,
            borderRadius: BorderRadius.circular(8),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.5),
            //     spreadRadius: 1,
            //     blurRadius: 2,
            //     offset: Offset(0, 1), // changes position of shadow
            //   ),
            // ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$buttonText",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Gap(7),
                Icon(Icons.highlight_remove, size: 25, color: kLightGrayColor,)
              ],
            ),
          ),
        ));
  }
}