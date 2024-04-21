import 'dart:io';

import 'package:ato/db/consts.dart';
import 'package:ato/models/cloth_item.dart';
import 'package:ato/models/item.dart';
import 'package:ato/models/user.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:ato/components/styles.dart';
import 'package:ato/components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddItemScreen extends StatefulWidget {
  static String title = "Add Items";
  final String category;

  const AddItemScreen({super.key, required this.category});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  int _characterCount = 0;
  String? _error;
  String? _nameError;
  String? _quantityError;
  String? _detailsError;
  final int maxCharacters = 1000;
  final List<XFile> _imageFiles = List.empty();
  final picker = ImagePicker();
  String _selectedGender = "men";
  String _selectedSize = "M";
  Color _selectedColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    String cat = widget.category;
    String title = loc.ofStr(cat);
    return atoScaffold(
      context: context,
      showAppBarBackground: false,
      title: title,
      body: Center(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16.0,16.0,16.0,64.0),
          shrinkWrap: false,
          scrollDirection: Axis.vertical,
          children: [
            if(_error != null)
            Text(_error!, style: const TextStyle(color: Colors.red),),
            Container(
              width: screenSize(context).width - 20,
              height: 140,
              padding: const EdgeInsets.all(10),
              color: cardBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenSize(context).width * 0.5,
                    child: TextField(
                      controller: _descriptionController,
                      maxLines: null,
                      minLines: 7,
                      maxLength: maxCharacters,
                      onChanged: (text) {
                        setState(() {
                          _characterCount = text.length;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: loc.of(Tr.description),
                        counterText: '$_characterCount/$maxCharacters',
                        errorText: _detailsError,

                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _pickImages,
                        icon: _imageFiles.isEmpty
                            ? Image.asset(
                          'assets/images/ic_add.png',
                          width: 40,
                          height: 40,
                        )
                            : Stack(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: Expanded(
                                child: ListView.builder(
                                  itemCount: _imageFiles.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.file(
                                        File(_imageFiles[index].path),
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Container(
                              height: 100,
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 20,
                                alignment: Alignment.bottomCenter,
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(4)),
                                  shape: BoxShape.rectangle,
                                  color: Colors.grey,
                                ),
                                child: Text(
                                  '${_imageFiles.length}/4',
                                  style: const TextStyle(
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TextField(
                decoration: InputDecoration(
                  errorText: _nameError,
                  labelText: loc.of(Tr.name),
                ),
                keyboardType: TextInputType.text,
                controller: _nameController
            ),
            TextField(
                decoration: InputDecoration(
                  errorText: _quantityError,
                  labelText: loc.of(Tr.quantity),
                ),
                keyboardType: TextInputType.number,
                controller: _quantityController
            ),

            Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                for (int i = 0; i < genders.length; i++)
                  SizedBox(
                    width: 100,
                    child: atoRadioButton(
                      onChange: (choice) {
                        setState(() {
                          _selectedGender = choice;
                        });
                      },
                      text: loc.ofStr(genders[i]),
                      val: genders[i],
                      groupValue: _selectedGender,
                    ),
                  )
              ],
            ),
            Text("${loc.of(Tr.size)}:"),
            Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                for (int i = 0; i < sizes.length; i++)
                  SizedBox(
                    width: 80,
                    child: atoRadioButton(
                      onChange: (choice) {
                        setState(() {
                          _selectedSize = choice;
                        });
                      },
                      groupValue: _selectedSize,
                      text: sizes[i],
                      val: sizes[i],
                    ),
                  )
              ],
            ),
            Text("${loc.of(Tr.color)}:"),
            Container(
              alignment: loc.isAr() ? Alignment.centerRight : Alignment
                  .centerLeft,
              child: SizedBox(
                width: 120,
                child: atoColorPickerButton(
                    context: context,
                    selectedColor: _selectedColor,
                    onChange: (color) {
                      setState(() {
                        _selectedColor = color;
                      });
                    }),
              ),
            ),
            const SizedBox(height: 48),
            Center(
              child: SizedBox(
                width: 200,
                child: atoDarkMaterialButton(
                  onPressed: () {
                    bool hasError = false;
                    String name = _nameController.text;
                    if (name.isEmpty) {
                      hasError= true;
                      setState(() {
                        _nameError = loc.of(Tr.nameIsRequired);
                      });
                    }
                    String description = _descriptionController.text;
                    if (description.isEmpty) {
                      hasError= true;
                      setState(() {
                        _detailsError = loc.of(Tr.descriptionIsRequired);
                      });
                    }

                    int quantity = _quantityController.text as int;
                    if (quantity == 0) {
                      hasError= true;
                      setState(() {
                        _quantityError = loc.of(Tr.quantityIsRequired);
                      });
                    }
                    if(!hasError) {
                      ItemModel item;
                      if ([Tr.clothes.name, Tr.shoesAndBags.name].contains(
                          cat)) {
                        item = ClothModel(
                            name: _nameController.text,
                            category: cat,
                            quantity: quantity,
                            donorId: UserModel.user!.id,
                            details: description,
                            //TODO
                            image: "",
                            size: _selectedSize,
                            forGender: _selectedGender,
                            color: _selectedColor.value
                        );
                      }
                      else {
                        item = ItemModel(name: name,
                            category: cat,
                            quantity: quantity,
                            donorId: UserModel.user!.id,
                            details: description,
                            //TODO
                            image: "");
                      }
                      uploadItem(_imageFiles, item);
                    }
                  },
                  fontSize: 16,
                  text: loc.of(Tr.addItem),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImages() async {
    final pickedFiles = await picker.pickMultiImage();
    _imageFiles.clear();
    setState(() {
      for (XFile file in pickedFiles) {
        if (_imageFiles.length < 4) {
          _imageFiles.add(file);
        }
      }
    });
  }

  void uploadItem(List<XFile> imageFiles, ItemModel item) {
    //TODO

  }
}
