import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:promoter_tracking_app/pages/attendance_page.dart';
import 'package:promoter_tracking_app/pages/order_history.dart';
import 'package:promoter_tracking_app/pages/order_page.dart';

import '../widget/custom_card.dart';

Position? currentLocation;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // get permission from user
  Future<void> getPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permission are permanently deined');
    }
  }

  @override
  void initState() {
    getPermission();
    super.initState();
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
          title: const Center(
            child: Text(
              "Home Page",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CustomCard(
                        img: "assets/images/fingerprint.png",
                        cardName: "RAYA Attendance",
                        describtion: "confirm your presence",
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AttendancePage(),
                            ),
                          );
                        },
                      ),
                      CustomCard(
                        img: "assets/images/shopping-cart.png",
                        cardName: "Make Order ",
                        describtion: "collect order and access shopping cart",
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => OrderPage(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  CustomCard(
                    img: "assets/images/orderhistory.png",
                    cardName: "Order History",
                    describtion: "check closed order",
                    function: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OrderHistory(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
