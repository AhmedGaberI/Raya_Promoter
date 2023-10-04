import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:promoter_tracking_app/global/global_distance.dart';
import 'package:promoter_tracking_app/models/promoter_info_model.dart';
import 'package:promoter_tracking_app/services/location.dart';
import 'package:promoter_tracking_app/widget/custom_card.dart';

import '../api/get_promoter_info.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  Position? _currentLoaction;
  bool _isLoading = true;
  final bool _userSigndIn = false;

  late double dist = double.maxFinite;

  PromoterInfoModel? promoterInfoModel;

  Future<void> getLocation() async {
    _currentLoaction = await Location.getCurrentLocation(context);
    _isLoading = false;
    promoterInfoModel = await GetPromoterInfo()
        .getPrmomoterInfo(userName: "", password: "", deviceID: "");
    if (_currentLoaction != null && promoterInfoModel != null) {
      dist = Location.calculateDistance(
          myPos: _currentLoaction!,
          latDes: promoterInfoModel!.storeLat,
          longDes: promoterInfoModel!.storeLong);
    }
    setState(() {});
  }
  
  
  @override
  void initState() {
    getLocation();

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
            title: const Padding(
              padding: EdgeInsets.all(40.0),
              child: Text(
                "RAYA Attendance",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            )),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: CustomCard(
                              img: "assets/images/login-.png",
                              cardName: "Sign IN",
                              describtion: "Confirm Your presence",
                              function: () {
                                // calculated distance from source to dest
                                dist < Destinations.minDest
                                    ? AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.success,
                                        title: "Sign In done Successfully",
                                        btnCancelOnPress: () {
                                          // TODO
                                          Navigator.pop(context);
                                        },
                                        btnOkOnPress: () {
                                          // TO DO
                                          Navigator.pop(context);
                                        },
                                      ).show()
                                    : AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.warning,
                                        title: "Unsuccessfully Sign IN",
                                        desc: "You are out of the area",
                                        btnCancelOnPress: () {
                                          // To DO
                                          Navigator.pop(context);
                                        },
                                        btnOkOnPress: () {
                                          // To DO
                                          //Navigator.pop(context);
                                        },
                                      ).show();
                              },
                            ),
                          ),
                          Expanded(
                            child: CustomCard(
                                img: "assets/images/logoutt.png",
                                cardName: "Sign Out",
                                describtion: "Confirm Your leaving",
                                function: () {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    title: "Sign-Out done successfully",
                                    desc:
                                        "You are Sign Out at ${DateTime.now().hour}: ${DateTime.now().minute}: ${DateTime.now().second}",
                                    btnCancelOnPress: () {
                                      // To DO
                                      //Navigator.pop(context);
                                    },
                                    btnOkOnPress: () {
                                      // To Do
                                      // Navigator.pop(context);
                                    },
                                  ).show();
                                }),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
