import 'dart:io';
import 'dart:ui';

import 'package:ato/components/actions.dart';
import 'package:ato/components/widgets/buttons.dart';
import 'package:ato/db/consts.dart';
import 'package:ato/models/cloth_item.dart';
import 'package:ato/models/item.dart';
import 'package:ato/models/user.dart';
import 'package:ato/providers/item_provider.dart';
import 'package:ato/providers/locale_provider.dart';
import 'package:ato/components/widgets/global.dart';
import 'package:ato/sr_screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
  String? _nameError;
  String? _quantityError;
  String? _detailsError;
  final int maxCharacters = 1000;
  XFile? _imageFile;
  String _selectedGender = "men";
  String _selectedSize = "M";
  Color _selectedColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    LocaleProvider loc = Provider.of(context);
    ItemProvider ipo= Provider.of(context);
    String cat = widget.category;
    bool isCloth= cat== clothCat|| cat== shoesAndBagsCat;
    String title = loc.ofStr(cat);
    return atoScaffold(
      context: context,
      showAppBarBackground: false,
      isLoading: ipo.loading,
      title: title,
      body: Card(
        margin: const EdgeInsets.all(16),
        child: Center(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 64.0),
            shrinkWrap: false,
            scrollDirection: Axis.vertical,
            children: [
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
              Row(
                children: [
                  SizedBox(
                    width: 180,
                    child: TextField(
                        decoration: InputDecoration(
                          errorText: _nameError,
                          labelText: loc.of(Tr.name),
                        ),
                        keyboardType: TextInputType.text,
                        controller: _nameController),
                  ),
                  Gap(10),
                  SizedBox(
                    width: 100,
                    child: TextField(
                        decoration: InputDecoration(
                          errorText: _quantityError,
                          labelText: loc.of(Tr.quantity),
                        ),
                        keyboardType: TextInputType.number,
                        controller: _quantityController),
                  ),
                ],
              ),
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
              if(isCloth)
              Text("${loc.of(Tr.forG)}:"),
              if(isCloth)
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

              if(isCloth)
              Text("${loc.of(Tr.size)}:"),
              if(isCloth)
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
              if(isCloth)
              Text("${loc.of(Tr.color)}:"),
              if(isCloth)
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
                      int  errors = 0;
                      String name = _nameController.text;
                      errors+= name.isEmpty? 1: 0;
                      setState(() {
                        _nameError = name.isEmpty? loc.of(Tr.quantityIsRequired): null;
                      });
                      String description = _descriptionController.text;
                      errors+= description.isEmpty? 1: 0;
                      setState(() {
                        _detailsError = description.isEmpty? loc.of(Tr.descriptionIsRequired): null;
                      });
                      String quanText= _quantityController.text;
                      int quantity= 0;
                      try {
                        quantity = int.parse(quanText);
                      } catch (ignore){
                        errors+= 1;
                      }
                      setState(() {
                        _quantityError = quantity==0? loc.of(Tr.quantityIsRequired): null;
                      });
                      if(_imageFile== null){
                        atoToastError(context, "Image is required!");
                        errors+=1;
                      }
                      if (errors== 0) {
                        ItemModel item;
                        if (isCloth) {
                          item = ClothModel(
                              name: _nameController.text,
                              category: cat,
                              quantity: quantity,
                              donorId: UserModel.user!.id,
                              details: description,
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
                              image: "");
                        }
                        uploadItem(context,_imageFile!, item, loc, ipo);
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
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Future<void> uploadItem(BuildContext context, XFile imageFile, ItemModel item,LocaleProvider loc, ItemProvider ipo) async {
   await ipo.upload(item, File(imageFile.path));
   if(ipo.error.isNotEmpty){
     if(context.mounted) {
       atoToastError(context, ipo.error);
     }
   }
   else{
     if(context.mounted){
       atoToastSuccess(context, loc.of(Tr.itemAddedSuccessfully));
       goBack(context);
     }
   }

  }
}
