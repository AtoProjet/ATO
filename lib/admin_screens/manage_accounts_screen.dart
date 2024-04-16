import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../components/constants.dart';
import '../db/firebaseChatServices.dart';
import '../widgets/admin_widgets/common_widgets/manageAccountCard.dart';
import '../widgets/admin_widgets/common_widgets/topbar.dart';

class ManageAccountsScreen extends StatefulWidget {
  const ManageAccountsScreen({super.key});

  @override
  State<ManageAccountsScreen> createState() => _ManageAccountsScreenState();
}

class _ManageAccountsScreenState extends State<ManageAccountsScreen> {
  Stream? getAllUserAccounts;
  @override
  void initState() {
    super.initState();
    onTheLoad();
  }
  onTheLoad() async {
    getAllUserAccounts = await FirebaseChatServices().getUserAccounts();
    setState(() {});
  }

  @override
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
            Gap(15),
            UserAccountsList()
            //ManageAccountCard(username: 'Johanna Doe', type: 'Donor 856475',),
          ],
        )
        ,
      ),
    );
  }

  Widget UserAccountsList() {

    return StreamBuilder(
        stream: getAllUserAccounts,
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
                    ManageAccountCard(
                      id: ds["id"],
                      username: ds["name"],
                      type: ds["role"],
                      isActive: ds["isActive"],
                    ),
                    Gap(10),
                  ],
                );
              })
              : Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _usersListView() {
    return SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.75,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              primary: false,
              children: [UserAccountsList()],
            )
          ],
        ));
  }

}
