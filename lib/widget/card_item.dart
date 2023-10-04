import 'package:flutter/material.dart';

class SellCardItem extends StatelessWidget {
  String modelName;
  double totalPrice;
  int quantity;
  VoidCallback onLongPress;
  SellCardItem({
    Key? key,
    required this.modelName,
    required this.totalPrice,
    required this.quantity,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      child: Card(
        elevation: 10,
        margin: const EdgeInsetsDirectional.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      modelName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      '$totalPrice',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: const Color.fromARGB(255, 182, 30, 19),
                child: Text('$quantity'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
