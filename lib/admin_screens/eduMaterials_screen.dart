import 'dart:async';

import 'package:ato/admin_screens/articles_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../components/constants.dart';
import '../providers/locale_provider.dart';
import '../widgets/admin_widgets/common_widgets/eduMaterialBox.dart';

class EduMaterialScreen extends StatefulWidget {
  const EduMaterialScreen({super.key});

  @override
  State<EduMaterialScreen> createState() => _EduMaterialScreenState();
}

class _EduMaterialScreenState extends State<EduMaterialScreen> {

  final storage = FirebaseStorage.instance;
  String imgUrl = "";


  Future<String> getImageUrl(String imageName) async {
    final ref = storage.ref().child("BackgroundImages/"+imageName);
    final url = await ref.getDownloadURL();
    imgUrl = url;
    // if (url is String) {
    //   imgUrl = url;
    // }
    return imgUrl;
  }

  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);

    //var ref = FirebaseStorage.instance.ref().child("gs://ato-project-b6bf2.appspot.com/BackgroundImages/books.jpeg");
    //String url_img = "";
    //ref.getDownloadURL().then((loc) => setState(() => url_img = loc));



    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              alignment: Alignment.bottomRight,
              width: double.infinity,
              height: 120.0,
              child: const SizedBox(
                height: 80,
                child: Image(
                  image: AssetImage('assets/images/ic_logo.jpg'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Gap(0),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      loc.of(Tr.typesOfEducationalMaterials),
                      style: kLabelEduMaterialsH_font,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
            Gap(20),
            FutureBuilder<String>(
                future: getImageUrl("books.jpeg"),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasError)
                    return Text("ERROR: ${snapshot.error}");
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());

                  var data = snapshot.data;
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ArticlesPage()));
                    },
                    child: EduMaterialBox(

                      url_img: data!,
                      text1: loc.of(Tr.articlesWithPictures),
                    ),
                  );
                }),
            Gap(18),
            FutureBuilder<String>(
                future: getImageUrl("books.jpeg"),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasError)
                    return Text("ERROR: ${snapshot.error}");
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());

                  var data = snapshot.data;
                  return EduMaterialBox(
                    url_img: data!,
                    text1: loc.of(Tr.announcementOfCampaigns),
                  );
                }),

            // EduMaterialBox(url_img: url_img, text1: 'Articles with', text2: 'Pictures',),
            // Gap(18),
            // EduMaterialBox(url_img: url_img, text1: 'Announcement', text2: 'of Campaigns',),
          ],
        ),
      ),
    );
  }
}
