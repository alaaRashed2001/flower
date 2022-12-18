import 'dart:io';
import 'package:flower/firebase/product_fb_controller.dart';
import 'package:flower/model/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flower/helper/snackbar.dart';
import 'package:flower/shared_preferences/shared_preferences.dart';
import 'package:flower/views/widgets/my_button.dart';
import 'package:flower/views/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename;
import '../../../constant/colors.dart';

class AddProducts extends StatefulWidget {
  final ProductModel? product;

  const AddProducts({
    required this.product,
    Key? key,
  }) : super(key: key);

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
    priceEditingController = TextEditingController(
        text: widget.product != null ? widget.product!.price.toString() : '');
    titleEditingController = TextEditingController(
        text: widget.product != null ? widget.product!.title : '');
    stateEditingController = TextEditingController();
    locationEditingController = TextEditingController(
        text: widget.product != null ? widget.product!.location : '');
    descriptionEditingController = TextEditingController(
        text: widget.product != null ? widget.product!.description : '');
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
      appBar: AppBar(
        backgroundColor: green,
        title: Text(widget.product == null ? "Add Product" : "Update Product"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 180.w,
                      height: 180.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8.r)),
                      child: (imgPath == null)
                          ? const Center(child: Text("No img selected"))
                          : Image.file(
                              imgPath!,
                              fit: BoxFit.cover,
                            ),
                    ),
                    PositionedDirectional(
                      bottom: 0,
                      start: 0,
                      child: Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(30.r)),
                        child: InkWell(
                          onTap: () {
                            choose2UploadImage();
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
                SizedBox(height: 12.h),
                MyTextField(
                  hintText: 'Title',
                  controller: titleEditingController,
                ),
                SizedBox(height: 16.h),
                MyTextField(
                  hintText: 'Price',
                  controller: priceEditingController,
                  textInputType: TextInputType.number,
                ),
                SizedBox(height: 16.h),
                MyTextField(
                  hintText: 'location',
                  controller: locationEditingController,
                ),
                SizedBox(height: 16.h),
                MyTextField(
                  hintText: 'description',
                  controller: descriptionEditingController,
                ),
                SizedBox(height: 24.h),
                MyButton(
                    title: widget.product == null
                        ? 'Add Product'
                        : 'Update Product',
                    backgroundColor: Color(0xFFFFA4D3),
                    isLoading: loading,
                    onPressed: () async {
                      await addProduct();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool loading = false;

  ///////////////////////////////////////////////////////////////

  choose2UploadImage() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(22),
            height: 200.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    await uploadImage(ImageSource.camera);
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 30,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        'From Camera',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                InkWell(
                  onTap: () async {
                    await uploadImage(ImageSource.gallery);
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.photo,
                        size: 30,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        'From Gallery',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontSize: 18),
                    ))
              ],
            ),
          );
        });
  }

  File? imgPath;
  String? imgName;
  String? urlImg;

  uploadImage(ImageSource source) async {
    final pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
        });
      } else {
        showSnackBar(context, message: "NO img selected", error: true);
      }
    } catch (e) {
      showSnackBar(context, message: "Error => $e", error: true);
    }
  }

  Future<void> addProduct() async {
    setState(() {
      loading = true;
    });
    try {
      final storageRef = FirebaseStorage.instance.ref(imgName);
      await storageRef.putFile(imgPath!);
      urlImg = await storageRef.getDownloadURL();

      if (widget.product == null) {
        await ProductFbController().createProduct(getProduct);
      } else {
        await ProductFbController().updateProduct(getProduct);
      }

      showSnackBar(
        context,
        message: widget.product == null ? "Product Added" : "Product Updated",
        error: false,
      );
      Navigator.pop(context);
    } catch (e) {
      showSnackBar(
        context,
        message: widget.product == null ? "Failed Adding" : "Failed Updating",
        error: true,
      );
    }
    setState(() {
      loading = false;
    });
  }

  ProductModel get getProduct {
    ProductModel productModel = ProductModel();
    productModel.id =
        widget.product == null ? DateTime.now().toString() : widget.product!.id;
    productModel.title = titleEditingController.text;
    productModel.price = num.parse(priceEditingController.text);
    productModel.location = locationEditingController.text;
    productModel.description = descriptionEditingController.text;
    productModel.sellerId = SharedPreferencesController().getUId;
    productModel.imagePath = urlImg ?? '';
    return productModel;
  }
}
