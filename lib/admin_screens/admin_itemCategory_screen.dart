import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../components/constants.dart';
import '../components/styles.dart';
import '../components/widgets/images.dart';
import '../db/firebaseChatServices.dart';
import '../providers/locale_provider.dart';
import '../widgets/admin_widgets/common_widgets/topbar.dart';

class AdminItemCategoryPage extends StatefulWidget {
  const AdminItemCategoryPage({super.key});

  @override
  State<AdminItemCategoryPage> createState() => _AdminItemCategoryPageState();
}

List<Map<String, dynamic>> catList = [];
Future<List<Map<String, dynamic>>> getItemCat() async {
  catList = await FirebaseChatServices().getItemCategories();
  print(catList);
  //setState(() {});
  return catList;
}

final FirebaseChatServices _serv = FirebaseChatServices();

class _AdminItemCategoryPageState extends State<AdminItemCategoryPage> {
  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
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
                "Categories",
                style: kLabelEduMaterialsH_font,
              ),
            ),
            Gap(10),

            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.80,
              width: MediaQuery.sizeOf(context).width,
              child: StreamBuilder(
                stream: _serv.getItemCatStream(),
                builder: (context, snapshot) {
                  var dataa = snapshot.data?.docs ?? [];
                  if (dataa.isEmpty) {
                    return const Center(
                      child: Text("No Categories"),
                    );
                  }
                  else{
                    return ListView.builder(
                      itemCount: dataa.length,
                      itemBuilder: (context, index) {
                        var data = dataa[index].data();

                        return Container(
                          padding:
                          const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 120.0),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                            itemCount: dataa.length,
                            itemBuilder: (context, index) {
                              print(dataa[index]["isView"]);
                              return atoCategoryCard(
                                  dataa[index]["catName"],
                                  loc,
                                  dataa[index]["isView"],
                                  dataa[index]["id"]);
                            },
                          ),
                        );
                      },
                    );
                  }

                },
              ),
            ),

            // FutureBuilder<List<Map<String, dynamic>>>(
            //     future: getItemCat(),
            //     builder: (BuildContext context,
            //         AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            //       if (snapshot.hasError) return Text("ERROR: ${snapshot.error}");
            //       if (!snapshot.hasData)
            //         return Center(child: CircularProgressIndicator());
            //
            //       var data = snapshot.data!;
            //       return Container(
            //         padding: const EdgeInsets.fromLTRB(16.0,16.0,16.0,120.0),
            //         width: MediaQuery.of(context).size.width,
            //         height: MediaQuery.of(context).size.height,
            //         child: ListView.builder(
            //           itemCount: data.length,
            //           itemBuilder: (context, index) {
            //
            //             if(data[index]["isView"] == true){
            //               return atoCategoryCard(data[index]["catName"], loc);
            //             }
            //
            //
            //           },
            //         ),
            //       );
            //
            //
            //       //   Column(
            //       //   children: [
            //       //     ...atoCategoryCardList(loc, data)
            //       //   ],
            //       // );
            //
            //     })

            //ManageAccountCard(username: 'Johanna Doe', type: 'Donor 856475',),
          ],
        ),
      ),
    );
  }

  Card atoCategoryCard(cat, LocaleProvider loc, isView, id) {
    return Card(
      elevation: 5,
      margin:
          const EdgeInsetsDirectional.symmetric(horizontal: 4, vertical: 20),
      child: Container(
        height: 120,
        padding: const EdgeInsetsDirectional.fromSTEB(2, 4, 10, 4),
        width: screenSize(context).width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: cardBackgroundColor,
        ),
        child: Row(
          children: [
            Container(
              height: 110,
              width: screenSize(context).width / 2 - 40,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                image: atoAssetOfCategory("$cat.jpg"),
              ),
            ),
            SizedBox(
              height: 90,
              width: screenSize(context).width / 2 - 30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    loc.ofStr(cat),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon(
                      //   Icons.person,
                      //   size: 28,
                      // ),

                      Gap(5),
                      Checkbox(
                          activeColor: kPrimaryColor,
                          value: isView,
                          onChanged: (value) {
                            print(value);
                            print("trying to change");
                            _serv.updateItemCat(id, value!);
                            setState(() {
                              //isDonorChecked = value;
                            });
                          }),
                      // StatefulBuilder(
                      //   builder: (BuildContext context,
                      //       void Function(void Function()) setState) {
                      //     return Checkbox(
                      //         activeColor: kPrimaryColor,
                      //         value: isView,
                      //         onChanged: (value) {
                      //           print(value);
                      //           print("trying to change");
                      //           _serv.updateItemCat(id, value!);
                      //           setState(() {
                      //
                      //             //isDonorChecked = value;
                      //           });
                      //         });
                      //   },
                      // ),
                      Text(
                        "View",
                        style: kLabelManageAccountUserName_font,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
