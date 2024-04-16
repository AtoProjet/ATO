import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../components/app_layout.dart';
import '../../../components/constants.dart';

class EduMaterialBox extends StatelessWidget {
  const EduMaterialBox({super.key, required this.url_img, required this.text1, required this.text2});
  final String url_img;
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Material(
      child: Container(
        width: size.width * 0.9,

        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
        decoration: BoxDecoration(
          color: kQuoteBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 15, 5, 10),
          child: Row(
            children: [
              Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      Container(
                        width: 250,
                        height: 120,
                    child: Image.network(url_img,fit: BoxFit.cover,

                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },

                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(2),
                        //   image: DecorationImage(
                        //     image: AssetImage("assets/images/$url_img.jpeg"),
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                      )

                      )],
                  )),
              Gap(15),
              Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                '$text1',
                                style: kLabelEduMaterialContent_font,
                                textAlign: TextAlign.center,
                                maxLines: 3,
                              ),
                              Text(
                                '$text2',
                                style: kLabelEduMaterialContent_font,
                                textAlign: TextAlign.center,
                                maxLines: 3,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Gap(10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.add_circle, size: 25, color: kAddButtonColor,),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
