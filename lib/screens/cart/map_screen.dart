import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Config/config.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/counter_providers/location_provider.dart';
import 'package:shop_app/screens/cart/Enter_Manual_Address.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = 'mapScreen';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng currentLocation;
  GoogleMapController _mapController;
  bool _locating = false;

  void saveLocationData(locationData) async {
    await EcommerceApp.firestore
        .collection('users')
        .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .update({
      'userAddress': locationData.selectedAddress,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locationData = Provider.of<LocationProvider>(context);
    setState(() {
      currentLocation = LatLng(locationData.latitude, locationData.longitude);
    });
    void onCreated(GoogleMapController controller) {
      setState(() {
        _mapController = controller;
      });
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentLocation,
                zoom: 14.4746,
              ),
              zoomControlsEnabled: true,
              minMaxZoomPreference: MinMaxZoomPreference(1.5, 20.8),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.terrain,
              mapToolbarEnabled: true,
              onCameraMove: (CameraPosition position) {
                setState(() {
                  print('i am omving');
                  _locating = true;
                });
                locationData.onCameraMove(position);
              },
              onMapCreated: onCreated,
              onCameraIdle: () {
                setState(() {
                  _locating = false;
                });
                locationData.getMoveCamera();
              },
            ),
            Center(
              child: Container(
                height: 50.0,
                margin: EdgeInsets.only(bottom: 40.0),
                child: Image.asset(
                  'assets/icons/addressMarker.png',
                  color: Colors.black,
                ),
              ),
            ),
            locationData.selectedAddress != null
                ? Positioned(
                    bottom: 0.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      // height: 200.0,
                      color: Colors.white,
                      padding: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _locating
                                ? LinearProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).primaryColor),
                                    backgroundColor: Colors.transparent,
                                  )
                                : Container(),
                            TextButton.icon(
                              onPressed: () {
                                //
                              },
                              icon: Icon(
                                Icons.location_searching,
                                color: Colors.black,
                              ),
                              label: Text(
                                _locating
                                    ? "Locating...."
                                    : locationData.selectedAddress,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            TextButton.icon(
                              icon: Icon(Icons.location_on),
                              label: Text(
                                'Enter address manually',
                                // style: TextStyle(color: Colors.grey),
                              ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, EnterAddress.routeName);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 10.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width - 40,
                                child: AbsorbPointer(
                                  absorbing: _locating ? true : false,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      saveLocationData(locationData);
                                      Fluttertoast.showToast(
                                          msg: 'Address Saved Successfully');
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(_locating
                                              ? Colors.grey
                                              : kPrimaryColor),
                                    ),
                                    child: Text('Confirm Location'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
