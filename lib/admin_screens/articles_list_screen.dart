import 'package:ato/admin_screens/create_article_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../components/constants.dart';
import '../db/firebaseChatServices.dart';
import '../providers/locale_provider.dart';
import '../widgets/admin_widgets/common_widgets/articleListTile.dart';
import '../widgets/admin_widgets/common_widgets/topbar.dart';
import 'articles_screen.dart';

class ArticlesListPage extends StatefulWidget {
  const ArticlesListPage({super.key});

  @override
  State<ArticlesListPage> createState() => _ArticlesListPageState();
}

class _ArticlesListPageState extends State<ArticlesListPage> {
  final storage = FirebaseStorage.instance;
  String imgUrl = "";

  Future<String> getImageUrl(String imageName) async {
    final ref = storage.ref().child("articles/" + imageName);
    final url = await ref.getDownloadURL();
    imgUrl = url;
    // if (url is String) {
    //   imgUrl = url;
    // }
    return imgUrl;
  }

  Stream? getArticlesList;

  @override
  void initState() {
    super.initState();
    onTheLoad();
  }

  onTheLoad() async {
    getArticlesList = await FirebaseChatServices().getArticlesList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 15, 30),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateArticlePage()));
          },
          //foregroundColor: kPrimaryBtnColor,
          backgroundColor: kPrimaryBtnColor,
          child: const Icon(Icons.add),
        ),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Topbar(
              isBack: true,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Gap(5),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 5, 5, 0),
              child: Text(
                loc.of(Tr.articles),
                style: kLabelEduMaterialsH_font,
              ),
            ),
            Gap(15),
            ArticlesList(loc)
            //ManageAccountCard(username: 'Johanna Doe', type: 'Donor 856475',),
          ],
        ),
      ),
    );
  }

  Widget ArticlesList(LocaleProvider loc) {
    return StreamBuilder(
        stream: getArticlesList,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];

                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ArticlesPage(
                                          articleId: ds["id"],
                                        )));
                          },
                          child: ArticleListTile(
                            url_img: ds["img"],
                            title: ds["title"],
                            content: ds["content"],
                          ),
                        ),
                        // FutureBuilder<String>(
                        //     future: getImageUrl("articles.jpeg"),
                        //     builder:
                        //         (BuildContext context, AsyncSnapshot<String> snapshot) {
                        //       if (snapshot.hasError)
                        //         return Text("ERROR: ${snapshot.error}");
                        //       if (!snapshot.hasData)
                        //         return Center(child: CircularProgressIndicator());
                        //
                        //       var data = snapshot.data;
                        //       return GestureDetector(
                        //         onTap: (){
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) => ArticlesPage(articleId: ds["id"],)));
                        //         },
                        //         child: ArticleListTile(
                        //
                        //           url_img: ds["img"],
                        //           title: ds["title"],
                        //           content: ds["content"],
                        //         ),
                        //       );
                        //     }),
                        Gap(10),
                      ],
                    );
                  })
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }
}
