import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promoter_tracking_app/services/db.dart';
import 'package:promoter_tracking_app/widget/card_item.dart';

import '../controller/cart_controller.dart';
import '../models/cart_item_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _cartController = Get.put(CartController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartController.getTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 2, 43, 77),
          toolbarHeight: 50,
          elevation: 10,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
          ),
          title: const Text(
            "Cart",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<List<CartItemModel>?>(
          future: DatabaseHelper.getAllItems(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return SellCardItem(
                        modelName: snapshot.data![index].modelName,
                        totalPrice: snapshot.data![index].price,
                        quantity: snapshot.data![index].quantity,
                        onLongPress: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            title: "Deleting Cart!",
                            desc: "Are you sure to delete this cart",
                            btnCancelOnPress: () {},
                            btnOkOnPress: () async {
                              // delete this Cart Item
                              await DatabaseHelper.deleteItem(
                                  snapshot.data![index]);
                              _cartController.getItemCount();
                              _cartController.getTotalPrice();
                              setState(() {});
                            },
                          ).show();
                        },
                      );
                    },
                  ),
                  Positioned(
                    top: 570,
                    left: 90,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      width: 215,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 197, 211, 210),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, left: 5),
                        child: GetBuilder<CartController>(
                          builder: (_) => Text(
                            "Total Price: ${_cartController.totalPrice.value}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16.0,
                    right: 120.0,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 46, 114, 48),
                          child: IconButton(
                            onPressed: () {
                              log('ok');
                            },
                            icon: const Icon(
                              Icons.done_all_rounded,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 243, 32, 17),
                          child: IconButton(
                            onPressed: () async {
                              // Handle button press
                              await DatabaseHelper.clearCartTable();
                              _cartController.getItemCount();
                              _cartController.getTotalPrice();
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.delete,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          }),
        ),
      ),
    );
  }
}
