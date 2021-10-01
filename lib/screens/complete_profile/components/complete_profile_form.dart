import 'package:fiksii/components/custom_suffix_icon.dart';
import 'package:fiksii/components/default_button.dart';
import 'package:fiksii/components/firebase_state.dart';
import 'package:fiksii/screens/login_success/login_success_screen.dart';
import 'package:fiksii/screens/profile/components/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

import 'package:fiksii/.env.dart';


class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({Key? key}) : super(key: key);

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  // Image? _fotoProfil;
  String? _namaPengguna;
  String? _namaBisnis;
  String? _kategoriBisnis;
  String? _address;
  int? _tarifOngkir;

  late GoogleMapController _googleMapController;
  Marker? _location;


  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  void addError({required String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({required String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void _addMarker(LatLng pos) async {
    setState(() {
      _location = Marker(
        markerId: MarkerId('location'),
        infoWindow: InfoWindow(title: 'Origin'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: pos,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // String imagePath = '';
    return Form(
      key: _formKey,
      child: Column(
        children: [
        //   (false) ? Container(
        // height: SizeConfig.screenWidth * 0.5,
        // width: SizeConfig.screenWidth * 0.5,
        // decoration:BoxDecoration(
        //     color: Colors.grey,
        //     shape: BoxShape.circle,
        //     image: DecorationImage(
        //     image: CachedNetworkImageProvider(imagePath,)
        // ))) :
        //   Container(
        //     height: SizeConfig.screenWidth * 0.5,
        //     width: SizeConfig.screenWidth * 0.5,
        //     decoration:BoxDecoration(
        //       color: Colors.grey,
        //       shape: BoxShape.circle
        //     ),
        //   ),
          ProfilePic(diameter: SizeConfig.screenWidth * 0.5,),
          SizedBox(height: getProportionateScreenHeight(40),),
          buildFirstNameFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildLastNameFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildKategoriBisnisFormField(),
          SizedBox(height: getProportionateScreenHeight(30),),
          buildPhoneNumberFormField(),
          SizedBox(
            height: getProportionateScreenHeight(15),
          ),
          Align(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('Lokasi Bisnis:'),
            ),
            alignment: Alignment.centerLeft,
          ),
          SizedBox(height: getProportionateScreenHeight(5),),
          buildMapWidget(),
          SizedBox(height: getProportionateScreenHeight(25),),
          buildAdressFormField(),
          SizedBox(height: getProportionateScreenHeight(40),),
          Consumer<FirebaseState>(
            builder: (context, value, child) {
            return DefaultButton(
                text: "Continue",
                press: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // TODO Go To OTP Screen
                    bool completeProfileSuccess = await value.completeRegistration(_namaPengguna!, _namaBisnis!, _kategoriBisnis!, _location!, _address!, _tarifOngkir!, context);
                    if (completeProfileSuccess) Navigator.popAndPushNamed(context, LoginSuccessScreen.routeName);
                  }
                }
            );
            },
          ),
        ],
      ),
    );
  }

  Widget buildMapWidget() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          // color: Colors.green,
          width: double.infinity,
          height: getProportionateScreenHeight(200),
          child:
          Stack(
            children: [
              GoogleMap(    //TODO Location Picker
                onMapCreated: (controller) => _googleMapController = controller,
                markers: {if (_location != null) _location!},
                onLongPress: _addMarker,
                initialCameraPosition: CameraPosition(target: LatLng(-2.5,118), zoom: 3.45),

                zoomControlsEnabled: false,
                scrollGesturesEnabled: false,
                rotateGesturesEnabled: false,
                zoomGesturesEnabled: false,

              ),
              TextButton(
                  onPressed: () async {
                    LocationResult? result = await showLocationPicker(
                      context,
                      APIKEY,
                      initialCenter: LatLng(-2.5,118),
                      initialZoom: 5,
                      layersButtonEnabled: true,
                      desiredAccuracy: LocationAccuracy.best,
                    );
                    if (result?.latLng != null) {
                      _addMarker(result!.latLng!);
                      _googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _location!.position, zoom: 14.5)));
                    }
                  },
                child: Container(width: double.infinity, height: double.infinity,),
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith((states) => Colors.black12)
                ),
              )
            ],
          ),
        ),
    );
  }


  TextFormField buildAdressFormField() {
    return TextFormField(
        onSaved: (newValue) => _address = newValue!,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kAdressNullError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kEmailNullError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: "Alamat Bisnis",
            labelStyle: TextStyle(color: Color(0xFF8B8B8B)),
            hintText: "Alamat Bisnis",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSuffixIcon(
              svgIcon: "assets/icons/Location point.svg",
            )
        )
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
        // keyboardType: TextInputType.number,

        keyboardType: TextInputType.number,
        onSaved: (newValue) => _tarifOngkir = int.parse(newValue!),
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPhoneNumberNullError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kPhoneNumberNullError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: "Tarif Ongkir/km",
            labelStyle: TextStyle(color: Color(0xFF8B8B8B)),
            hintText: "Tarif Ongkir/km",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSuffixIcon(
              svgIcon: "assets/icons/Phone.svg",
            )));
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
        onSaved: (newValue) => _namaBisnis = newValue!,
        decoration: InputDecoration(
            labelText: "Nama Bisnis",
            labelStyle: TextStyle(color: Color(0xFF8B8B8B)),
            hintText: "Nama Bisnis",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSuffixIcon(
              svgIcon: "assets/icons/Shop Icon.svg",
              color: Colors.black,
            )));
  }

  TextFormField buildKategoriBisnisFormField() {
    return TextFormField(
        onSaved: (newValue) => _kategoriBisnis = newValue!,
        decoration: InputDecoration(
            labelText: "Kategori Bisnis",
            labelStyle: TextStyle(color: Color(0xFF8B8B8B)),
            hintText: "Kategori Bisnis",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSuffixIcon(
              svgIcon: "assets/icons/Shop Icon.svg",
              color: Colors.black,
            )));
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
        onSaved: (newValue) => _namaPengguna = newValue!,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kNameNullError);
          }
          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kNameNullError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: "Nama",
            labelStyle: TextStyle(color: Color(0xFF8B8B8B)),
            hintText: "Nama Pengguna",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSuffixIcon(
              svgIcon: "assets/icons/User.svg",
            )));
  }
}
