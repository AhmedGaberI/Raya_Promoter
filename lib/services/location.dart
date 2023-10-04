import 'package:geolocator/geolocator.dart';

class Location {
  static Future<Position> getCurrentLocation(dynamic ctx) async {
    bool serivceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serivceEnabled) {
      await Geolocator.openLocationSettings();
    }
    return await Geolocator.getCurrentPosition();
  }

  // calculate distance between the source and destinacion
  static double calculateDistance(
      {required Position myPos,
      required double latDes,
      required double longDes}) {
    return Geolocator.distanceBetween(
        myPos.latitude, myPos.longitude, latDes, longDes);
  }

  // static void showLocationServiceAlertDialog(ctx) {
  //   showDialog(
  //     context: ctx,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Location Service Disabled'),
  //         content: const Text(
  //             'Please enable location services to use this feature.'),
  //         actions: <Widget>[
  //           ElevatedButton(
  //             child: const Text('Cancel'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           ElevatedButton(
  //             child: const Text('Open Settings'),
  //             onPressed: () async {

  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
