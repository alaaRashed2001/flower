import 'package:flower/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constant/colors.dart';
import '../widgets/custom_appbar.dart';

class DetailsScreen extends StatefulWidget {
  final ProductModel product;
  const DetailsScreen({super.key, required this.product});
  @override

  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isShowMore = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: const Text("Details Screen"),
        centerTitle: true,
        actions: const [
          ProductsAndPrice(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(widget.product.imagePath),
             SizedBox(height: 12.h,),
             Text(
                '\$ ${widget.product.price}',
              style:  TextStyle(
                fontSize: 20.sp,
              ),
            ),
             SizedBox(height: 16.h,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF8181),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child:  Text(
                        'New',
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                   SizedBox(width: 8.w,),
                  Row(
                    children:  [
                       Icon(
                          Icons.star,
                        size: 26.r,
                        color: Color(0xFFFFBF00),
                      ),
                       Icon(
                          Icons.star,
                        size: 26.r,
                        color: Color(0xFFFFBF00),
                      ),
                       Icon(
                          Icons.star,
                        size: 26.r,
                        color: const Color(0xFFFFBF00),
                      ),
                       Icon(
                          Icons.star,
                        size: 26.r,
                        color: const Color(0xFFFFBF00),
                      ),
                       Icon(
                          Icons.star,
                        size: 26.r,
                        color: const Color(0xFFFFBF00),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children:  [
                       InkWell(
                         onTap: (){
                           ///
                         },
                         child: Icon(
                            Icons.edit_location,
                          size: 20.r,
                          color: Colors.black45,
                      ),
                       ),
                       SizedBox(width: 3.w,),
                      Text(
                          widget.product.location,
                        style:  TextStyle(
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
              Padding(
              padding:  const EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  'Details',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 24.sp,
                  ),
                ),
              ),
            ),
             Text(
              widget.product.description,
              style:  TextStyle(
                fontSize: 16.sp,
              ),
              maxLines: isShowMore ? 3 : null,
              overflow: TextOverflow.fade,
            ),
            TextButton(
                onPressed: (){
                  setState(() {
                    isShowMore = !isShowMore;
                  });
                },
                child:  Text(
                  isShowMore ? 'Show more' : 'Show less',
                  style:  TextStyle(
                  fontSize: 16.sp,
                ),),
            ),
          ],
        ),
      ),
    );
  }
}
