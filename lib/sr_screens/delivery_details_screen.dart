import 'package:ato/components/actions.dart';
import 'package:ato/components/styles.dart';
import 'package:ato/components/widgets/buttons.dart';
import 'package:ato/components/widgets/global.dart';
import 'package:ato/db/references.dart';
import 'package:ato/models/order.dart';
import 'package:ato/models/user.dart';
import 'package:ato/providers/cart_provider.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:ato/sr_screens/success_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class DeliveryDetailsScreen extends StatefulWidget {
  static Tr title = Tr.deliveryDetails;

  const DeliveryDetailsScreen({super.key});

  @override
  State<DeliveryDetailsScreen> createState() => _DeliveryDetailsScreenState();
}

class _DeliveryDetailsScreenState extends State<DeliveryDetailsScreen> {
  String? _error;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  late String formattedDate;
  late String formattedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime= const TimeOfDay(hour: 0, minute: 0);
    formattedDate= '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}';
    formattedTime = '${_selectedTime.hour < 10 ? '0${_selectedTime.hour}' : _selectedTime.hour}:${_selectedTime.minute < 10 ? '0${_selectedTime.minute}' : _selectedTime.minute}';

  }

  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    CartProvider cart = Provider.of(context);

    setAsFullScreen(true);
    if (cart.items.isEmpty) {
      return Center(child: Text(
        loc.of(Tr.yourCartIsEmpty), textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24),));
    }
    return
      atoScaffold(context: context,
    title: loc.of(DeliveryDetailsScreen.title),
    showAppBar: true,
    showAppBarBackground: false,
    body:
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("The item will be delivered by the donor"),
            const Gap(20),
            const Text("Select Delivery Date:"),
            Container(
              padding: const EdgeInsets.only(right: 12, left: 12, bottom: 16),
              alignment: Alignment.centerLeft,
              child: OutlinedButton(
                onPressed: () => _selectDate(context),
                style: buttonStyle(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      formattedDate,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Gap(20),
                    const Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
              ),
            ),
            const Text("Select Delivery Time:"),
            Container(
              padding: const EdgeInsets.only(right: 12, left: 12, bottom: 8),
              alignment: Alignment.centerLeft,
              child: OutlinedButton(
                onPressed: () => _selectTime(context),
                style: buttonStyle(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      formattedTime,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Gap(20),
                    const Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 200,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: atoDarkMaterialButton(
                    onPressed: () {
                      submit(context,cart, loc);
                    },
                    text: loc.of(Tr.continueText),
                    color: buttonColor),
              ),
            ),

          ]),
      )
      );
  }

  Future<void> upload(OrderModel order) async {
    try {
      await Fire.orderRef.doc(order.id).set(order.toMap());
      setState(() {
        _error = null;

      });
    }
    catch (err) {
      setState(() {
        _error = err.toString();
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      selectableDayPredicate: (DateTime date) {
        return date.isAfter(DateTime.now().subtract(const Duration(days: 1)));
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        formattedDate= '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}';
      });
    }
  }
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,

    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        formattedTime = '${_selectedTime.hour < 10 ? '0${_selectedTime.hour}' : _selectedTime.hour}:${_selectedTime.minute < 10 ? '0${_selectedTime.minute}' : _selectedTime.minute}';
      });
    }
  }

Future<void> submit(BuildContext context, CartProvider cart, LocaleProvider loc) async {
  OrderModel orderModel = OrderModel(
      beneficiaryId: UserModel.user!.id,
      pickedItems: cart.pickedItems,
    deliveryDate: formattedDate,
    deliveryTime: formattedTime,

  );
  await upload(orderModel);
  if(_error== null) {
    cart.clear();
    if(context.mounted) {
      goToScreen(context, SuccessScreen(message: Tr.thankYou));
    }
  }
  else{
    if(context.mounted) {
      atoToastError(context, _error!);
    }
  }
}
}
