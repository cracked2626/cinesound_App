import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider with ChangeNotifier {
  double latitude;
  double longitude;
  bool permissionAllowed = false;
  var selectedAddress;
  var hno;
  Future<void> getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (position != null) {
      this.latitude = position.latitude;
      this.longitude = position.longitude;
      this.permissionAllowed = true;
      notifyListeners();
    } else {
      print('Permission not allowed');
    }
  }

  void onCameraMove(CameraPosition cameraPosition) async {
    this.latitude = cameraPosition.target.latitude;
    this.longitude = cameraPosition.target.longitude;
    notifyListeners();
  }

  Future<void> getMoveCamera() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      this.latitude,
      this.longitude,
    );
    this.selectedAddress = '${placemarks.first.street}, ' +
        '${placemarks.first.subLocality}, ' +
        '${placemarks.first.locality}, ' +
        '${placemarks.first.postalCode}, ' +
        '${placemarks.first.country}';
    this.hno = placemarks.length;
    // GeoCode geoCode = GeoCode();
    // final address = await geoCode.reverseGeocoding(
    //     latitude: this.latitude, longitude: this.longitude);
    // this.selectedAddress = address.streetAddress;
    // this.hno = address.city;
    print(selectedAddress);
    print(placemarks);
    notifyListeners();
  }
}
