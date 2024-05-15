import 'dart:io';

import 'package:ato/admin_screens/articles_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../components/actions.dart';
import '../components/constants.dart';
import '../db/firebaseChatServices.dart';
import '../providers/locale_provider.dart';
import '../widgets/admin_widgets/common_widgets/genBtn.dart';
import '../widgets/admin_widgets/common_widgets/topbar.dart';
import 'admin_success_screen.dart';

class CreateArticlePage extends StatefulWidget {
  const CreateArticlePage({super.key});

  @override
  State<CreateArticlePage> createState() => _CreateArticlePageState();
}

class _CreateArticlePageState extends State<CreateArticlePage> {
  bool _isLoading = false;

  // void _showLoading() {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   // Simulate a network request or a long-running task
  //   Future.delayed(Duration(seconds: 3), () {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  // }

  bool isBeneficiaryChecked = false;
  bool isDonorChecked = false;
  TextEditingController titleTextController = new TextEditingController();
  TextEditingController contentTextController = new TextEditingController();
  XFile? _imageFile;

  addArticle(bool sendClicked, String title, String content, XFile imageFile,
      bool isDonorView, bool isBenView) async {
    FirebaseChatServices()
        .addArticle(
            title, content, File(imageFile.path), isBenView, isDonorView)
        .then((value) {
      setState(() {
        _isLoading = false;
      });

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AdminSuccessPage(
                    text: 'Article Created Successfully',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ArticlesListPage()));
                    },
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);

    bool validate() {
      bool res = false;
      if (titleTextController.text.isNotEmpty &&
          titleTextController.text.isNotEmpty &&
          _imageFile != null) {
        res = true;
      }
      return res;
    }

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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_imageFile == null)
                      Container(
                          height: 100,
                          width: 100,
                          color: Colors.black12,
                          child: IconButton(
                            onPressed: _pickImages,
                            icon: Image.asset(
                              'assets/images/ic_add.png',
                              width: 40,
                              height: 40,
                            ),
                          )),
                    if (_imageFile != null)
                      IconButton(
                        onPressed: _pickImages,
                        icon: Image.file(
                          File(_imageFile!.path),
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                  ],
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Gap(20),
                      //------------------------- title
                      Text(
                        "Enter Title :",
                        style: kLabelProfileName_font,
                      ),
                      Gap(20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Material(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(5),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            maxLines: 2,
                            controller: titleTextController,
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFC5C5C5)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: kPrimaryColor),
                                ),
                                //prefixIcon: Icon(Icons.account_circle, size: 27, color: kTextFeildIconColor),

                                fillColor: Color(0xFFFFFCFC),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey[500])),
                          ),
                        ),
                      ),
                      Gap(20),
                      //---------------------- content
                      Text(
                        "Enter Content :",
                        style: kLabelProfileName_font,
                      ),
                      Gap(20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Material(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(5),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            maxLines: 5,
                            controller: contentTextController,
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFC5C5C5)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: kPrimaryColor),
                                ),
                                //prefixIcon: Icon(Icons.account_circle, size: 27, color: kTextFeildIconColor),

                                fillColor: Color(0xFFFFFCFC),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey[500])),
                          ),
                        ),
                      ),

                      // -------------------- check Boxes
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
                                      isBeneficiaryChecked = value!;
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
                                      isDonorChecked = value!;
                                    });
                                  });
                            },
                          )
                        ],
                      ),
                      Gap(15),
                      GenBtn(
                          buttonText: 'Add',
                          onTap: () async {
                            setState(() {
                              _isLoading = true;
                            });

                            bool isValid = validate();

                            if (isValid) {
                              bool result = await addArticle(
                                  true,
                                  titleTextController.text,
                                  contentTextController.text,
                                  _imageFile!,
                                  isDonorChecked,
                                  isBeneficiaryChecked);
                              // if (result) {
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => AdminSuccessPage(
                              //             text: 'Article Created Successfully', onTap: () {(){
                              //             Navigator.pushReplacement(context, MaterialPageRoute(
                              //                 builder: (context) => ArticlesListPage()));
                              //           };  },
                              //           )));
                              // } else {
                              //   print(loc.of(Tr.failedToEnableAccount));
                              //   print("Btn Clicked");
                              // }
                            } else if (!isValid) {
                              var snackBar = SnackBar(
                                content:
                                    Text('Required fields cannot be empty'),
                                backgroundColor: Colors.redAccent,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }),
                      Gap(25),
                    ],
                  ),
                ),

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

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }
}
