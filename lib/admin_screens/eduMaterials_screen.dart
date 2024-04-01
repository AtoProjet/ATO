import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../components/constants.dart';
import '../widgets/admin_widgets/common_widgets/eduMaterialBox.dart';

class EduMaterialScreen extends StatefulWidget {


  const EduMaterialScreen({super.key});

  @override
  State<EduMaterialScreen> createState() => _EduMaterialScreenState();
}

class _EduMaterialScreenState extends State<EduMaterialScreen> {

  late String  url_img;
  final storage = FirebaseStorage.instance;
  @override
  void initState(){
    super.initState();
    url_img = '';
    print('Inside init state');
    getImageUrl();
}

Future<void> getImageUrl() async {
final ref = storage.ref().child('BackgroundImages/books.jpeg');
final url  = await ref.getDownloadURL();
print('Inside getImageUrl');
setState(() {
  url_img = url;
});
}

  Widget build(BuildContext context) {
    //var ref = FirebaseStorage.instance.ref().child("gs://ato-project-b6bf2.appspot.com/BackgroundImages/books.jpeg");
    //String url_img = "";
    //ref.getDownloadURL().then((loc) => setState(() => url_img = loc));

    print ("the url image is : "+ url_img);

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
                child:  Image(
                  image: AssetImage('assets/images/ic_logo.jpg'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Gap(0),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10,10,20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Types Of Educational",
                        style: kLabelEduMaterialsH_font,),
                      Text("Materials",
                        style: kLabelEduMaterialsH_font,),
                    ],
                  )
                ],
              ),
            ),
            Gap(20),
            EduMaterialBox(url_img: url_img, text1: 'Articles with', text2: 'Pictures',),
            Gap(18),
            EduMaterialBox(url_img: url_img, text1: 'Announcement', text2: 'of Campaigns',),

          ],
        ),
      ),
    );
  }
}
