import 'package:flutter/material.dart';
import 'package:promoter_tracking_app/models/item_model.dart';
import 'package:promoter_tracking_app/widget/custom_text.dart';

// ignore: must_be_immutable
class ItemCard extends StatelessWidget {
  ItemModel itemModel;
  ItemCard({super.key, required this.itemModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .79,
            child: SizedBox(
              width: 100,
              height: 160,
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: CustomText(
                                  txt: "Price : ${itemModel.price}")),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child:
                                  CustomText(txt: "Type : ${itemModel.type}")),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomText(
                                  txt: "Pwoer : ${itemModel.power}")),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: CustomText(
                                  txt: "Capacity : ${itemModel.capacity}")),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomText(
                                  txt: "Country : ${itemModel.country}")),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: CustomText(
                                  txt: "Color : ${itemModel.color}")),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomText(
                                  txt: "Warranty : ${itemModel.warranty}")),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Text(
                        itemModel.otherDescriptions,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 95, 93, 93)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Positioned(
            right: 95,
            top: -70,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SizedBox(
                  // width: 220,
                  // height: 100,
                  child: Image.asset(
                    'assets/images/procurement.png',
                    width: 130,
                    height: 110,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
