import 'dart:io';

import 'package:ato/db/consts.dart';
import 'package:ato/models/cloth_item.dart';
import 'package:ato/models/item.dart';
import 'package:ato/models/user.dart';
import 'package:ato/providers/locale_provider.dart';
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
  XFile? _imageFile;
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
      body: Card(
        margin: EdgeInsets.all(16),
        child: Center(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 64.0),
            shrinkWrap: false,
            scrollDirection: Axis.vertical,
            children: [
              if (_error != null)
                Text(
                  _error!,
                  style: const TextStyle(color: Colors.red),
                ),
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
                        height: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                ],
              ),
              TextField(
                  decoration: InputDecoration(
                    errorText: _nameError,
                    labelText: loc.of(Tr.name),
                  ),
                  keyboardType: TextInputType.text,
                  controller: _nameController),
              TextField(
                controller: _descriptionController,
                maxLines: null,
                minLines: 2,
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
              TextField(
                  decoration: InputDecoration(
                    errorText: _quantityError,
                    labelText: loc.of(Tr.quantity),
                  ),
                  keyboardType: TextInputType.number,
                  controller: _quantityController),
              SizedBox(
                height: 20,
              ),
              Text("${loc.of(Tr.forG)}:"),
              Wrap(
                alignment: WrapAlignment.start,
                children: [
                  for (int i = 0; i < genders.length; i++)
                    SizedBox(
                      width: 120,
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
                alignment: WrapAlignment.start,
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
                alignment:
                    loc.isAr() ? Alignment.centerRight : Alignment.centerLeft,
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
                        hasError = true;
                        setState(() {
                          _nameError = loc.of(Tr.nameIsRequired);
                        });
                      }
                      String description = _descriptionController.text;
                      if (description.isEmpty) {
                        hasError = true;
                        setState(() {
                          _detailsError = loc.of(Tr.descriptionIsRequired);
                        });
                      }

                      int quantity = _quantityController.text as int;
                      if (quantity == 0) {
                        hasError = true;
                        setState(() {
                          _quantityError = loc.of(Tr.quantityIsRequired);
                        });
                      }
                      if (!hasError) {
                        ItemModel item;
                        if ([Tr.clothes.name, Tr.shoesAndBags.name]
                            .contains(cat)) {
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
                              color: _selectedColor.value);
                        } else {
                          item = ItemModel(
                              name: name,
                              category: cat,
                              quantity: quantity,
                              donorId: UserModel.user!.id,
                              details: description,
                              //TODO
                              image: "");
                        }
                        uploadItem(_imageFile!, item);
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
      ),
    );
  }

  Future<void> _pickImages() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  void uploadItem(XFile imageFile, ItemModel item) {
    //TODO
  }
}
