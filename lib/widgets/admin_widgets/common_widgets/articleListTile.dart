import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../components/app_layout.dart';
import '../../../components/constants.dart';

class ArticleListTile extends StatelessWidget {
  final String url_img;
  final String title;
  final String content;
  const ArticleListTile({super.key, required this.url_img, required this.title, required this.content});

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
                  flex: 4,
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
                          Flexible(child: Text(
                            'Title: ${title}',
                            style: kLabelArticlesListTitle_font,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis
                          ),),

                        ],
                      ),
                      Gap(10),
                      Row(
                        children: [
                          Flexible(child: Text(
                            '$content',
                            style: kLabelArticlesListContent_font,
                            textAlign: TextAlign.start,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis

                          ),),

                        ],
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
