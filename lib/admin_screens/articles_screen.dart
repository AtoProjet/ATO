import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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

    return articleInfo;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
        ListView(
          shrinkWrap: true,
          children: [
            Container(
              alignment: Alignment.bottomRight,
              width: double.infinity,
              height: 100.0,
              child: const SizedBox(
                height: 80,
                child:  Image(
                  image: AssetImage('assets/images/ic_logo.jpg'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Gap(5),
            Padding(
              padding: const EdgeInsets.fromLTRB(25,5,5,0),
              child: Text('Manage Accounts', style: kLabelEduMaterialsH_font,),
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
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      
                      children: [
                        Text("Title : ${data.docs[0]["title"]}"),
                        Gap(10),
                        Text("Content : ${data.docs[0]["content"]}")
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
