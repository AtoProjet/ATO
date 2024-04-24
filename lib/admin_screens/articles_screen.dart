import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../components/constants.dart';
import '../db/firebaseChatServices.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  late QuerySnapshot articleInfo;
  @override
  void initState() {
    super.initState();
    //onTheLoad();
  }
  onTheLoad() async {
    articleInfo = await FirebaseChatServices().getArticlesDetails();
    setState(() {});
  }

  Future<QuerySnapshot> getArticleInfo() async{
    articleInfo = await FirebaseChatServices().getArticlesDetails();
  print("This article trigger");
    return articleInfo;
  }
  final storage = FirebaseStorage.instance;
  String imgUrl = "";
  Future<String> getImageUrl(String imageName) async {
    final ref = storage.ref().child("BackgroundImages/"+imageName);
    final url = await ref.getDownloadURL();
    if (url is String) {
      imgUrl = url;
    }
    print("This getImageUrl trigger");
    return imgUrl;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
        ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.bottomRight,
              width: double.infinity,
              height: 100.0,
              child: SizedBox(
                height: 80,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ProfileScreen()));
                        Navigator.pop(context);
                      },
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
            ),
            Gap(5),
            Padding(
              padding: const EdgeInsets.fromLTRB(25,5,5,0),
              child: Text('Articles', style: kLabelEduMaterialsH_font,),
            ),
            Gap(10),
            FutureBuilder<QuerySnapshot>(
                future: getArticleInfo(),
                builder:
                    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return Text("ERROR: ${snapshot.error}");
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());

                  late QuerySnapshot data = snapshot.data!;
                  return Container(
                    decoration: BoxDecoration(
                      color: kQuoteBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.fromLTRB(20, 15, 20, 10),
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(

                      children: [
                        FutureBuilder<String>(
                            future: getImageUrl("articles.jpeg"),
                            builder:
                                (BuildContext context, AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasError)
                                return Text("ERROR: ${snapshot.error}");
                              if (!snapshot.hasData)
                                return Center(child: CircularProgressIndicator());

                              var data = snapshot.data;
                              return Container(
                                  width: 250,
                                  height: 150,
                                  child: Image.network(data!,fit: BoxFit.fill,

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

                              );
                            }),
                        Gap(20),
                        RichText(text: TextSpan(children: <TextSpan>[

                          TextSpan(text: "Title :",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                          TextSpan(text: " ${data.docs[0]["title"]}",style: const TextStyle( color: Colors.black))
                        ])),
                        Gap(20),
                        RichText(text: TextSpan(children: <TextSpan>[

                          TextSpan(text: "Content :",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                          TextSpan(text: " ${data.docs[0]["content"]}",style: const TextStyle( color: Colors.black))
                        ])),
                        Gap(20),
                      ],
                    ),
                  );
                }),

            //ManageAccountCard(username: 'Johanna Doe', type: 'Donor 856475',),
          ],
        )
        ,
      ),
    );
  }
}
