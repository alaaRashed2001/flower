import 'dart:io';
import 'package:flower/firebase/product_fb_controller.dart';
import 'package:flower/model/product_model.dart';

import 'package:flower/helper/snackbar.dart';
import 'package:flower/views/widgets/my_button.dart';
import 'package:flower/views/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constant/colors.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> with SnackBarHelper {
  late TextEditingController priceEditingController;
  late TextEditingController titleEditingController;

  late TextEditingController stateEditingController;

  late TextEditingController locationEditingController;

  late TextEditingController descriptionEditingController;
  @override
  void initState() {
    priceEditingController = TextEditingController();
    titleEditingController = TextEditingController();
    stateEditingController = TextEditingController();
    locationEditingController = TextEditingController();
    descriptionEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    priceEditingController.dispose();
    titleEditingController.dispose();
    stateEditingController.dispose();
    locationEditingController.dispose();
    descriptionEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: green,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 180,
                      height: 180,

                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Center(
                          child: (imgPath == null)
                              ? const Text("No img selected")
                              : Image.file(imgPath!)),
                    ),
                    PositionedDirectional(
                      bottom: 0,
                      start: 0,
                      child:  Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: InkWell(
                          onTap: ()async{
                            await uploadImage();
                          },
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                MyTextField(
                    hintText: 'Title',
                    controller: titleEditingController,
                    validator: (v) {}),
                const SizedBox(
                  height: 16,
                ),
                MyTextField(
                    hintText: 'Price',
                    controller: priceEditingController,
                    validator: (v) {}),
                const SizedBox(
                  height: 16,
                ),
                MyTextField(
                    hintText: 'location',
                    controller: locationEditingController,
                    validator: (v) {}),
                const SizedBox(
                  height: 16,
                ),
                MyTextField(
                    hintText: 'description',
                    controller: descriptionEditingController,
                    validator: (v) {}),
                const SizedBox(
                  height: 24,
                ),
                MyButton(
                    title: 'Add Product',
                    backgroundColor: Colors.white,
                    onPressed: () async{
                      await createNewProduct();

                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  File? imgPath;
  uploadImage() async {
    final pickedImg = await ImagePicker().pickImage(source: ImageSource.camera);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
        });
        // String imgName = basename(pickedImg.path);
        // print(imgPath);
        // print(imgName);
      } else {
        showSnackBar(context, message: "NO img selected", error: true);
      }
    } catch (e) {
      showSnackBar(context, message: "Error => $e", error: true);
    }
  }

  Future<void> createNewProduct()async{
    await ProductFbController().createProduct(getProduct());
  }

  ProductModel getProduct(){
    ProductModel productModel = ProductModel();
    // id
    // imagePath
   productModel.title = titleEditingController.text;
   productModel.price = priceEditingController.text as num;
   productModel.location = locationEditingController.text;
   productModel.description = descriptionEditingController.text;
    return productModel;
  }
}
