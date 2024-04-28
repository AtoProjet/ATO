import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../providers/locale_provider.dart';

class Topbar extends StatelessWidget {
  final Function()? onTap;
  final bool isBack;
  const Topbar({super.key, this.onTap, required this.isBack});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    return Container(
      padding: EdgeInsets.only(left: 10, top: 15),
      alignment: provider.isEn()
          ? Alignment.bottomRight
          : Alignment.bottomLeft,
      width: double.infinity,
      height: 100.0,
      child: SizedBox(
        height: 80,
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (isBack) Row(
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: Icon(
                    Icons.arrow_back,
                  ),
                ),
                Gap(180),
              ],
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
