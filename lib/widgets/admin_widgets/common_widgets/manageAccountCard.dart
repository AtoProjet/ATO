import 'package:ato/admin_screens/accountActionConfirmationScreen.dart';
import 'package:ato/admin_screens/donatedItems_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../components/actions.dart';
import '../../../components/app_layout.dart';
import '../../../components/constants.dart';
import '../../../db/firebaseChatServices.dart';
import '../../../providers/locale_provider.dart';

class ManageAccountCard extends StatefulWidget {
  final String id;
  final String username;
  final String type;
  final bool isActive;
  const ManageAccountCard(
      {super.key,
      required this.username,
      required this.type,
      required this.id,
      required this.isActive});

  @override
  State<ManageAccountCard> createState() => _ManageAccountCardState();
}

class _ManageAccountCardState extends State<ManageAccountCard> {
  // ----------- Disable Account
  Future<bool> disableAccount(String id) async {
    bool isUpdated = false;

    await FirebaseChatServices().disableUserAccount(id).then((value) {
      isUpdated = true;
    });
    setState(() {});
    return isUpdated;
  }

  // ----------- Enable Account
  Future<bool> enableAccount(String id) async {
    bool isUpdated = false;

    await FirebaseChatServices().enableUserAccount(id).then((value) {
      isUpdated = true;
    });
    setState(() {});
    return isUpdated;
  }

  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    final size = AppLayout.getSize(context);
    return Material(
      child: Container(
        width: size.width * 0.9,
        margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 0),
        decoration: BoxDecoration(
          color: kQuoteBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 15, 5, 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 27,
                        child: Icon(
                          Icons.account_circle,
                          size: 50,
                        ),
                        //backgroundImage:
                        //AssetImage("assets/appicons/femaleicon.png"),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.username}",
                        style: kLabelManageAccountUserName_font,
                      ),
                      Gap(5),
                      if (widget.type == "Beneficiary")
                        Text(
                          loc.of(Tr.beneficiary),
                          style: kLabelManageAccountType_font,
                        ),
                      if (widget.type == "Donor")
                        Text(
                          loc.of(Tr.donor),
                          style: kLabelManageAccountType_font,
                        ),
                      // Text(
                      //   "${widget.type}",
                      //   style: kLabelManageAccountType_font,
                      // ),
                      Gap(3),
                      Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                          ),
                          Gap(5),
                          Text(
                            loc.of(Tr.supportMustBeReviewed),
                            style: kLabelManageAccountGen_font,
                          ),
                        ],
                      ),
                      Gap(4),
                      TextButton(
                        onPressed: () {
                          goToScreen(context, DonatedItemsPage());
                        },
                        child: Text(
                          loc.of(Tr.donatedItems),
                          style: kLabelManageAccountGen_font,
                        ),
                      ),

                      Gap(4),
                      Row(
                        children: [
                          Icon(
                            Icons.logout,
                          ),
                          Gap(5),
                          if (widget.isActive)
                            TextButton(
                              child: Text(loc.of(Tr.disableAccount),
                                  style: kLabelManageAccountDisable_font),
                              onPressed: () async {
                                bool result = await disableAccount(widget.id);
                                if (result) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AccountActionConfirmation(
                                                  action:
                                                      loc.of(Tr.disabled))));
                                } else {
                                  print(loc.of(Tr.failedToDisableAccount));
                                }
                              },
                            ),
                          if (!widget.isActive)
                            TextButton(
                              child: Text(loc.of(Tr.enableAccount),
                                  style: kLabelManageAccountEnable_font),
                              onPressed: () async {
                                bool result = await enableAccount(widget.id);
                                if (result) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AccountActionConfirmation(
                                                  action: loc.of(Tr.enabled))));
                                } else {
                                  print(loc.of(Tr.failedToEnableAccount));
                                }
                              },
                            ),
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
