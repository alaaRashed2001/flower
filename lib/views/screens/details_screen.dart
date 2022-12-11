import 'package:flower/model/item_model.dart';
import 'package:flutter/material.dart';

import '../../constant/colors.dart';

class DetailsScreen extends StatefulWidget {
  final ItemModel product;
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(widget.product.imagePath),
            const SizedBox(height: 12,),
             Text(
                '\$ ${widget.product.price}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF8181),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                        'New',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Row(
                    children: const [
                       Icon(
                          Icons.star,
                        size: 26,
                        color: Color(0xFFFFBF00),
                      ),
                       Icon(
                          Icons.star,
                        size: 26,
                        color: Color(0xFFFFBF00),
                      ),
                       Icon(
                          Icons.star,
                        size: 26,
                        color: Color(0xFFFFBF00),
                      ),
                       Icon(
                          Icons.star,
                        size: 26,
                        color: Color(0xFFFFBF00),
                      ),
                       Icon(
                          Icons.star,
                        size: 26,
                        color: Color(0xFFFFBF00),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children:  [
                      const Icon(
                          Icons.edit_location,
                        size: 20,
                        color: Colors.black45,
                      ),
                      const SizedBox(width: 3,),
                      Text(
                          widget.product.location,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
             const Padding(
              padding:  EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  'Details',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ),
             Text(
              'A flower, sometimes known as a bloom or blossom, is the reproductive structure found in flowering plants (plants of the division Angiospermae). The biological function of a flower is to facilitate reproduction, usually by providing a mechanism for the union of sperm with eggs. Flowers may facilitate outcrossing (fusion of sperm and eggs from different individuals in a population) resulting from cross-pollination or allow selfing (fusion of sperm and egg from the same flower) when self-pollination occurs.',
              style: const TextStyle(
                fontSize: 16,
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
                  style: const TextStyle(
                  fontSize: 16,
                ),),
            ),
          ],
        ),
      ),
    );
  }
}
