import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;
import 'package:promoter_tracking_app/api/get_all_models.dart';
import 'package:promoter_tracking_app/api/get_item_descriptions.dart';
import 'package:promoter_tracking_app/models/category_model.dart';
import 'package:promoter_tracking_app/models/item_model.dart';
import 'package:promoter_tracking_app/pages/cart_page.dart';
import 'package:promoter_tracking_app/widget/custom_card.dart';
import 'package:promoter_tracking_app/widget/item_card_describtion.dart';

import '../api/get_all_categories.dart';
import '../controller/cart_controller.dart';
import '../models/cart_item_model.dart';
import '../services/db.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final List<String> _categories = [];
  List<String> _models = [];
  ItemModel? itemModel;
  final Map<String, String> _catIDs = {};

  String? selectedCategory;
  String? selectedModel;
  double totalPrice = 0.0;
  int? quntaity;

  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final _cartController = Get.put(CartController());

  Future<void> getCategories() async {
    List<CategoryModel> allCategories =
        await GetAllCatgories().getAllCategories();
    for (var category in allCategories) {
      _categories.add(category.categoryName);
      _catIDs[category.categoryName] = category.id.toString();
    }

    setState(() {});
  }

  final snackBar = const SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text('Item Added successfully to Cart'));

  Future<void> getModels() async {
    _models =
        await GetAllModels().getAllModels(catID: _catIDs[selectedCategory]!);
    setState(() {});
  }

  Future<void> getItemDescription() async {
    itemModel = await GetItemDescriptions()
        .getItemDesriptions(modelName: selectedModel!);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    getCategories();
    _cartController.getItemCount();
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
          title: const Padding(
            padding: EdgeInsets.all(0.0),
            child: Text(
              "Orders",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              textAlign: TextAlign.right,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 40,
                top: 10,
              ),
              child: badges.Badge(
                badgeContent: GetBuilder<CartController>(
                  builder: (_) => Text(
                    '${_cartController.itemCount.value}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const CartPage()));
                  },
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Select Category',
                    style: GoogleFonts.actor(
                      textStyle: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    //padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 235, 231, 231),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton(
                      isDense: true,
                      borderRadius: BorderRadius.circular(10),
                      dropdownColor: const Color.fromARGB(255, 239, 241, 241),
                      underline: const SizedBox(),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      isExpanded: true,
                      value: selectedCategory,
                      items: _categories
                          .map<DropdownMenuItem<String?>>(
                              (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.toString()),
                                  ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedModel = null;
                          selectedCategory = value!;

                          itemModel = null;
                          getModels();
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Select Model',
                    style: GoogleFonts.actor(
                      textStyle: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    //padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 235, 231, 231),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton(
                      isDense: true,
                      borderRadius: BorderRadius.circular(10),
                      dropdownColor: const Color.fromARGB(255, 246, 248, 248),
                      underline: const SizedBox(),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      isExpanded: true,
                      value: selectedModel,
                      items: _models
                          .map<DropdownMenuItem<String?>>(
                              (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.toString()),
                                  ))
                          .toList(),
                      onChanged: (value) {
                        setState(
                          () {
                            selectedModel = value!;
                            itemModel = null;
                          },
                        );
                      },
                    ),
                  ),
                  selectedModel != null
                      ? FutureBuilder<ItemModel>(
                          future: GetItemDescriptions()
                              .getItemDesriptions(modelName: selectedModel!),
                          builder: ((context, snapshot) {
                            if (snapshot.hasData) {
                              return Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    ItemCard(
                                      itemModel: ItemModel(
                                          price: snapshot.data!.price,
                                          capacity: snapshot.data!.capacity,
                                          code: snapshot.data!.code,
                                          color: snapshot.data!.color,
                                          country: snapshot.data!.country,
                                          type: snapshot.data!.type,
                                          power: snapshot.data!.power,
                                          warranty: snapshot.data!.warranty,
                                          otherDescriptions:
                                              snapshot.data!.otherDescriptions),
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Quantity ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        Flexible(
                                          child: TextFormField(
                                            onChanged: (value) {
                                              if (value != "") {
                                                setState(() {
                                                  totalPrice =
                                                      double.parse(value);
                                                });
                                              } else {
                                                setState(() {
                                                  totalPrice = 0;
                                                });
                                              }
                                            },
                                            controller: _controller,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter quntity';
                                              }
                                              return null;
                                            },
                                            maxLength: 3,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(),
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                          ),
                                        ),
                                        Text(
                                          "Total Price ${totalPrice * double.parse(snapshot.data!.price)} ",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              // TO DO
                                            },
                                            child: const Text("Sell Item")),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              CartItemModel cartItemModel =
                                                  CartItemModel(
                                                      modelName: selectedModel!,
                                                      price: (double.parse(
                                                              snapshot.data!
                                                                  .price) *
                                                          int.parse(_controller
                                                              .text)),
                                                      quantity: int.parse(
                                                          _controller.text));

                                              List<Map<String, dynamic>> res =
                                                  await DatabaseHelper
                                                      .getItemByModel(
                                                          modelName:
                                                              cartItemModel
                                                                  .modelName);

                                              // this is the quntatiy of items saved before in database
                                              int oldq = res.isNotEmpty
                                                  ? res[0]['quantity']
                                                  : 0;

                                              // calculate the new quntatiy
                                              int newq =
                                                  (cartItemModel.quantity) +
                                                      oldq;

                                              res.isNotEmpty
                                                  ? (await DatabaseHelper
                                                          .updateItem(CartItemModel(
                                                              id: res[0]['id'],
                                                              modelName:
                                                                  selectedModel!,
                                                              price: newq *
                                                                  cartItemModel
                                                                      .price,
                                                              quantity: newq))
                                                      //cartItemModel.quantity += q;
                                                      )
                                                  : await DatabaseHelper
                                                      .addItem(cartItemModel);

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              _cartController.getItemCount();

                                              setState(() {
                                                selectedModel = null;

                                                _controller.value =
                                                    TextEditingValue.empty;
                                                totalPrice = 0;
                                              });
                                            }
                                          },
                                          child: const Text("Add to cart"),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return CustomCard(
                                  img: 'assets/images/page-not-found.png',
                                  cardName: "Item Not Found",
                                  describtion:
                                      "this item doesn't found please refer to admin",
                                  function: () {});
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
