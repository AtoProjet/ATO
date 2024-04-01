import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../components/constants.dart';

class NavigationBars extends StatelessWidget {
  const NavigationBars({super.key, required this.barText, required this.iconvalue, required this.onPress});
  final String barText;
  final int iconvalue;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(

              children: [
                Icon(IconData(iconvalue, fontFamily: 'MaterialIcons'),size: 25,color: kNavigationBarPrimaryColor,),
                Gap(15),
                Text(
                  '$barText',
                  style: TextStyle(
                      color: kNavigationBarPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
            Icon(Icons.chevron_right, size: 25,color: kNavigationBarPrimaryColor,),
          ],
        ),
      ),
    );
  }
}
