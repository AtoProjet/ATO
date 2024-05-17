import 'dart:async';

import 'package:ato/admin_screens/admin_success_screen.dart';
import 'package:ato/widgets/admin_widgets/common_widgets/topbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../components/constants.dart';
import '../db/firebaseChatServices.dart';
import '../models/user.dart';
import '../providers/locale_provider.dart';
import '../widgets/admin_widgets/common_widgets/genBtn.dart';
import '../widgets/admin_widgets/common_widgets/myBtn1.dart';
import 'accountActionConfirmationScreen.dart';
import 'articles_list_screen.dart';

class ArticlesPage extends StatefulWidget {
  final String articleId;
  const ArticlesPage({super.key, required this.articleId});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}
final FirebaseChatServices _serv = new FirebaseChatServices();
class _ArticlesPageState extends State<ArticlesPage> {
  bool _isLoading = false;
  late QuerySnapshot articleInfo;
  bool? isBeneficiaryChecked;
  bool? isDonorChecked;

  onTheLoad() async {
    articleInfo =
        await FirebaseChatServices().getArticlesDetails(widget.articleId);
    setState(() {});
  }

  Future<bool> updateArticleIsView(
      String articleId, bool isDonorView, bool isBenView) async {
    bool isUpdated = false;

    await FirebaseChatServices()
        .updateArticleIsView(articleId, isDonorView, isBenView)
        .then((value) {
      setState(() {
        _isLoading = false;
      });
      isUpdated = true;
    });
    setState(() {});
    return isUpdated;
  }

  Future<QuerySnapshot> getArticleInfo() async {
    articleInfo =
        await FirebaseChatServices().getArticlesDetails(widget.articleId);
    print("This article trigger");
    // setState(() {
    print("The check is  : " +
        articleInfo.docs[0]["isBeneficiaryView"].toString());
    isBeneficiaryChecked = articleInfo.docs[0]["isBeneficiaryView"];
    isDonorChecked = articleInfo.docs[0]["isDonorView"];
    // });
    return articleInfo;
  }

  final storage = FirebaseStorage.instance;
  String imgUrl = "";
  Future<String> getImageUrl(String imageName) async {
    final ref = storage.ref().child("articles/" + imageName);
    final url = await ref.getDownloadURL();
    imgUrl = url;
    return imgUrl;
  }

  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    UserModel user = UserModel.user!;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                Topbar(
                    isBack: true,
                    onTap: () {
                      Navigator.pop(context);
                    }),
                Gap(5),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 25, 0),
                  child: Text(
                    loc.of(Tr.articles),
                    style: kLabelEduMaterialsH_font,
                  ),
                ),
                Gap(10),
                FutureBuilder<QuerySnapshot>(
                    future: getArticleInfo(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError)
                        return Text("ERROR: ${snapshot.error}");
                      if (!snapshot.hasData)
                        return Center(child: CircularProgressIndicator());

                      late QuerySnapshot data = snapshot.data!;
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: kQuoteBackgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.fromLTRB(20, 15, 20, 10),
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Column(
                              children: [
                                Container(
                                    width: 250,
                                    height: 150,
                                    child: Image.network(
                                      data.docs[0]["img"], fit: BoxFit.fill,

                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                .expectedTotalBytes !=
                                                null
                                                ? loadingProgress
                                                .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
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
                                    )),
                                // FutureBuilder<String>(
                                //     future: getImageUrl("articles.jpeg"),
                                //     builder: (BuildContext context,
                                //         AsyncSnapshot<String> snapshot) {
                                //       if (snapshot.hasError)
                                //         return Text("ERROR: ${snapshot.error}");
                                //       if (!snapshot.hasData)
                                //         return Center(
                                //             child: CircularProgressIndicator());
                                //
                                //       var dataa = snapshot.data;
                                //       return Container(
                                //           width: 250,
                                //           height: 150,
                                //           child: Image.network(
                                //             data.docs[0]["img"], fit: BoxFit.fill,
                                //
                                //             loadingBuilder: (BuildContext context,
                                //                 Widget child,
                                //                 ImageChunkEvent? loadingProgress) {
                                //               if (loadingProgress == null)
                                //                 return child;
                                //               return Center(
                                //                 child: CircularProgressIndicator(
                                //                   value: loadingProgress
                                //                               .expectedTotalBytes !=
                                //                           null
                                //                       ? loadingProgress
                                //                               .cumulativeBytesLoaded /
                                //                           loadingProgress
                                //                               .expectedTotalBytes!
                                //                       : null,
                                //                 ),
                                //               );
                                //             },
                                //
                                //             // decoration: BoxDecoration(
                                //             //   borderRadius: BorderRadius.circular(2),
                                //             //   image: DecorationImage(
                                //             //     image: AssetImage("assets/images/$url_img.jpeg"),
                                //             //     fit: BoxFit.cover,
                                //             //   ),
                                //             // ),
                                //           ));
                                //     }),
                                Gap(20),
                                RichText(
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: "${loc.of(Tr.title)} :",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      TextSpan(
                                          text: " ${data.docs[0]["title"]}",
                                          style: const TextStyle(color: Colors.black))
                                    ])),
                                Gap(20),
                                RichText(
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: "${loc.of(Tr.content)} :",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      TextSpan(
                                          text: " ${data.docs[0]["content"]}",
                                          style: const TextStyle(color: Colors.black))
                                    ])),
                                Gap(20),
                              ],
                            ),
                          ),
                          if(user.role == "Admin")
                            Column(
                              children: [
                                Gap(10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Icon(
                                    //   Icons.person,
                                    //   size: 28,
                                    // ),
                                    Center(
                                      child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(28)),
                                          child: Image.asset(
                                            "assets/images/ic_user_female.jpg",
                                            width: 28,
                                            height: 28,
                                            fit: BoxFit.cover,
                                            alignment: Alignment.center,
                                          )),
                                    ),
                                    Gap(10),
                                    Text(
                                      "Beneficiary",
                                      style: kLabelManageAccountUserName_font,
                                    ),
                                    Gap(5),
                                    StatefulBuilder(
                                      builder: (BuildContext context,
                                          void Function(void Function()) setState) {
                                        return Checkbox(
                                            activeColor: kPrimaryColor,
                                            value: isBeneficiaryChecked,
                                            onChanged: (value) {
                                              setState(() {
                                                isBeneficiaryChecked = value;
                                              });
                                            });
                                      },
                                    )
                                  ],
                                ),
                                Gap(5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Icon(
                                    //   Icons.person,
                                    //   size: 28,
                                    // ),
                                    Center(
                                      child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(28)),
                                          child: Image.asset(
                                            "assets/images/ic_user_male.jpg",
                                            width: 28,
                                            height: 28,
                                            fit: BoxFit.cover,
                                            alignment: Alignment.center,
                                          )),
                                    ),
                                    Gap(10),
                                    Text(
                                      "Donor",
                                      style: kLabelManageAccountUserName_font,
                                    ),
                                    Gap(5),
                                    StatefulBuilder(
                                      builder: (BuildContext context,
                                          void Function(void Function()) setState) {
                                        return Checkbox(
                                            activeColor: kPrimaryColor,
                                            value: isDonorChecked,
                                            onChanged: (value) {
                                              setState(() {
                                                isDonorChecked = value;
                                              });
                                            });
                                      },
                                    )
                                  ],
                                ),
                                Gap(15),
                                GenBtn(
                                    buttonText: 'Save Changes',
                                    onTap: () async {

                                      setState(() {
                                        _isLoading = true;
                                      });

                                      bool result = await updateArticleIsView(
                                          data.docs[0]["id"],
                                          isDonorChecked!,
                                          isBeneficiaryChecked!);


                                      if (result) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AdminSuccessPage(
                                                        text: "Updated Successfully !", onTap: () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => ArticlesListPage()));


                                                    },)));
                                      } else {
                                        print(loc.of(Tr.failedToEnableAccount));
                                        print("Btn Clicked");
                                      }
                                    }),
                                Gap(15),
                                GenBtn(
                                    buttonText: 'Delete Article',
                                    onTap: () async {


                                      showDialog(
                                          barrierLabel: "ok",
                                          barrierDismissible: true,
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text("Warning"),
                                            content: Text("Are you sure, You want to delete the item permanantly",
                                            ),
                                            actions: [
                                              TextButton(
                                                child:
                                                Text("Ok"),
                                                onPressed: () {
                                                  // isLoad = !isLoad;
                                                  //                                               // print(isLoad);
                                                  // Timer(Duration(seconds: 3), () {
                                                  //   print("Yeah, this line is printed after 3 seconds");
                                                  // });
                                                  setState(() {
                                                    _isLoading = true;
                                                  });

                                                  _serv.deleteArticle(data.docs[0]["id"]);
                                                  setState(() {
                                                    _isLoading = false;
                                                  });

                                                  Navigator.pop(context);
                                                  Navigator.pop(context);

                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => ArticlesListPage())
                                                  );


                                                },

                                              ),
                                              TextButton(
                                                child: Text("Cancel"),
                                                onPressed: () {
                                                  Navigator.of(context,
                                                      rootNavigator: true)
                                                      .pop('dialog');
                                                },

                                              ),
                                            ],
                                          ));

                                    }),
                                Gap(25),
                              ],
                            ),

                        ],
                      );
                    }),

                //ManageAccountCard(username: 'Johanna Doe', type: 'Donor 856475',),
              ],
            ),
            if (_isLoading)
              Container(
                height: double.infinity,
                color: Colors.black
                    .withOpacity(0.5), // Semi-transparent background
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
