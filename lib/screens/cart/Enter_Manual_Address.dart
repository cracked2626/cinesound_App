import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Config/config.dart';
import 'package:shop_app/screens/details/components/custom_app_bar.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'components/customTextFIeld.dart';

class EnterAddress extends StatefulWidget {
  static const String routeName = 'enterAddress';
  @override
  _EnterAddressState createState() => _EnterAddressState();
}

void saveLocationData(address) async {
  await EcommerceApp.firestore
      .collection('users')
      .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .update({
    'userAddress': address,
  });
}

class _EnterAddressState extends State<EnterAddress> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _hnoTextEditingController = TextEditingController();
  TextEditingController _streetTextEditingController = TextEditingController();
  TextEditingController _pinCodeTextEditingController = TextEditingController();
  TextEditingController _cityTextEditingController = TextEditingController();
  TextEditingController _buildingNameTextEditingController =
      TextEditingController();
  TextEditingController _landmarkTextEditingController =
      TextEditingController();
  TextEditingController _stateTextEditingController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // width: double.infinity,
      appBar: CustomAppBar(
        title: 'Add Address',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FieldName(
                                text: 'H.No/Flat No.',
                              ),
                              CustomTextField(
                                controller: _hnoTextEditingController,
                                hintText: "",
                                textInputType: TextInputType.streetAddress,

                                // width: 100.0,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FieldName(
                                text: 'Pincode',
                              ),
                              CustomTextField(
                                controller: _pinCodeTextEditingController,
                                hintText: "",
                                textInputType: TextInputType.streetAddress,
                                // width: 100.0,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FieldName(
                                text: 'City',
                              ),
                              CustomTextField(
                                controller: _cityTextEditingController,
                                hintText: "",
                                textInputType: TextInputType.streetAddress,
                                // width: 100.0,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FieldName(
                                text: 'State',
                              ),
                              CustomTextField(
                                controller: _stateTextEditingController,
                                hintText: "",
                                textInputType: TextInputType.streetAddress,
                                // width: 100.0,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FieldName(
                          text: 'Locality / Area / Street',
                        ),
                        CustomTextField(
                          controller: _streetTextEditingController,
                          hintText: "",
                          textInputType: TextInputType.streetAddress,
                          // width: 100.0,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FieldName(
                          text: 'Building Name (optional)',
                        ),
                        CustomTextField(
                          controller: _buildingNameTextEditingController,
                          hintText: "",
                          textInputType: TextInputType.streetAddress,
                          // width: 100.0,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FieldName(
                          text: 'Landmark (optional)',
                        ),
                        CustomTextField(
                          controller: _landmarkTextEditingController,
                          hintText: "",
                          textInputType: TextInputType.streetAddress,
                          // width: 100.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: ElevatedButton(
                  onPressed: () {
                    var address = '${_hnoTextEditingController.text.trim()}, ' +
                        '${_buildingNameTextEditingController.text.trim()}, ' +
                        '${_landmarkTextEditingController.text.trim()}, ' +
                        '${_streetTextEditingController.text.trim()}, ' +
                        '${_cityTextEditingController.text.trim()}, ' +
                        '${_stateTextEditingController.text.trim()}, ' +
                        '${_pinCodeTextEditingController.text.trim()}';
                    print(address);
                    saveLocationData(address);
                    clearData();
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: 'Address Saved Successfully');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Save Address',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ],
      ),
    );
  }

  clearData() {
    _hnoTextEditingController.clear();
    _streetTextEditingController.clear();
    _pinCodeTextEditingController.clear();
    _cityTextEditingController.clear();
    _buildingNameTextEditingController.clear();
    _landmarkTextEditingController.clear();
    _stateTextEditingController.clear();
  }
}

class FieldName extends StatelessWidget {
  FieldName({
    @required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: Offset(0.0, 5.0),
            blurRadius: 30.0,
          ),
        ],
      ),
      // padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
      child: Text(
        text,
        style: TextStyle(color: Colors.grey, fontSize: 12.0),
      ),
    );
  }
}
