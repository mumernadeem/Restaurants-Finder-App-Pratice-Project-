import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:restaurants_finder_app/apputils.dart';
import 'package:restaurants_finder_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var utils = AppUtils();
  var locationPointAController = TextEditingController();
  var locationPointBController = TextEditingController();
  var validatorCheck1 = false;
  var validatorCheck2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    width: constraints.maxWidth * 0.4,
                    height: constraints.maxHeight * 0.2,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/splash_logo.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        Text(
                          'Enter the Starting Point:',
                          style: utils.mediumBoldStyle(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  utils.iconTextField(
                    width: constraints.maxWidth * 0.9,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12.0),
                    textColor: Colors.black,
                    borderColor: Colors.black,
                    borderWidth: 1.0,
                    check: false,
                    obscureText: false,
                    obscuringCharacter: '&',
                    height: 50.0,
                    onTap: () {},
                    onChanged: (text) {},
                    hintText: 'Location Name',
                    controller: locationPointAController,
                    keyboardType: TextInputType.text,
                    prefixIcon: const Icon(
                      Icons.location_pin,
                      size: 27,
                      color: Colors.red,
                    ),
                  ),
                  if (validatorCheck1 == true)
                    const SizedBox(
                      height: 5,
                    ),
                  if (validatorCheck1 == true)
                    const Text(
                      'Please Enter Starting Point Location Name',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        Text(
                          'Enter the Ending Point:',
                          style: utils.mediumBoldStyle(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  utils.iconTextField(
                    width: constraints.maxWidth * 0.9,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12.0),
                    textColor: Colors.black,
                    borderColor: Colors.black,
                    borderWidth: 1.0,
                    check: false,
                    obscureText: false,
                    obscuringCharacter: '&',
                    height: 50.0,
                    onTap: () {},
                    onChanged: (text) {},
                    hintText: 'Location Name',
                    controller: locationPointBController,
                    keyboardType: TextInputType.text,
                    prefixIcon: const Icon(
                      Icons.location_pin,
                      size: 27,
                      color: Colors.green,
                    ),
                  ),
                  if (validatorCheck2 == true)
                    const SizedBox(
                      height: 5,
                    ),
                  if (validatorCheck2 == true)
                    const Text(
                      'Please Enter Ending Point Location Name',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  const SizedBox(
                    height: 60,
                  ),
                  utils.button(
                    text: 'Start',
                    width: constraints.maxWidth * 0.75,
                    buttonColor: Colors.orangeAccent,
                    textColor: Colors.white,
                    height: 55.0,
                    borderRadius: BorderRadius.circular(30.0),
                    onTap: () async {
                      if (locationPointAController.text.isEmpty) {
                        validatorCheck1 = true;
                        setState(() {});
                      }
                      if (locationPointBController.text.isEmpty) {
                        validatorCheck2 = true;
                        setState(() {});
                      }
                      if (locationPointAController.text.isNotEmpty &&
                          locationPointBController.text.isNotEmpty) {
                        EasyLoading.show(status: 'loading...');
                        var googleGeocoding = GoogleGeocoding(
                            "AIzaSyCT1_CquKvIuNoCOxbsWOBo3U4Zq_58f2Y");
                        List<Component>? components1;
                        var pLocation = await googleGeocoding.geocoding.get(
                            locationPointAController.text, components1 ?? []);
                        List<Component>? components2;
                        var dLocation = await googleGeocoding.geocoding.get(
                            locationPointBController.text, components2 ?? []);
                        if (pLocation!.status == 'OK' &&
                            dLocation!.status == 'OK') {
                          SharedPreferences currentlat1 =
                              await SharedPreferences.getInstance();
                          SharedPreferences currentlat2 =
                              await SharedPreferences.getInstance();
                          SharedPreferences currentlong1 =
                              await SharedPreferences.getInstance();
                          SharedPreferences currentlong2 =
                              await SharedPreferences.getInstance();
                          currentlat1.setDouble("currentLat1",
                              pLocation.results![0].geometry!.location!.lat!);
                          currentlat2.setDouble("currentLat2",
                              dLocation.results![0].geometry!.location!.lat!);
                          currentlong1.setDouble("currentLong1",
                              pLocation.results![0].geometry!.location!.lng!);
                          currentlong2.setDouble("currentLong2",
                              dLocation.results![0].geometry!.location!.lng!);
                          EasyLoading.dismiss();
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamed(context, mapScreen);
                        } else {
                          EasyLoading.showError('Address is wrong');
                        }
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
