import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:restaurants_finder_app/HomeScreens/polyline_services.dart';
import 'package:restaurants_finder_app/apputils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var utils = AppUtils();
  // ignore: prefer_typing_uninitialized_variables
  var _initialCameraPosition;
  var dataCheck = false;
  Set<Polyline> polyLines = {};
  Future<void> _drawPolyline(LatLng from, LatLng to) async {
    Polyline polyline = await PolylineService().drawPolyline(from, to);
    for (int i = 0; i < polyline.points.length - 1; i++) {
      if ((polyline.points.length - 1) / 2 == i) {
        await check(polyline.points[i].latitude, polyline.points[i].longitude);
        for (int j = 0; j <= i; j++) {
          if (i ~/ 2 == j) {
            await check(
                polyline.points[j].latitude, polyline.points[j].longitude);
            for (int k = j; k <= i; k++) {
              if (i - k ~/ 2 == k) {
                await check(
                    polyline.points[k].latitude, polyline.points[k].longitude);
              }
            }
          }
          if (i ~/ 4 == j) {
            await check(
                polyline.points[j].latitude, polyline.points[j].longitude);
          }
        }
        var distance = ((polyline.points.length - 1) -
                (polyline.points.length - 1) ~/ 2) ~/
            2;
        int k = 0;
        for (int j = i - 1; j < polyline.points.length - 1; j++) {
          k++;
          if (k == distance) {
            await check(
                polyline.points[j].latitude, polyline.points[j].longitude);
          }
          if (k == distance ~/ 2) {
            await check(
                polyline.points[j].latitude, polyline.points[j].longitude);
          }
          if (k == distance * 2) {
            await check(
                polyline.points[j].latitude, polyline.points[j].longitude);
          }
        }
      }
    }
    polyLines.add(polyline);
    dataCheck = true;
    setState(() {});
  }

  Set<Marker> allMarkers1 = {};
  var lat1 = 0.0;
  var lat2 = 0.0;
  var lng1 = 0.0;
  var lng2 = 0.0;
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  late BitmapDescriptor markerBitmap1;
  late BitmapDescriptor markerBitmap2;
  var googlePlace = GooglePlace("AIzaSyCT1_CquKvIuNoCOxbsWOBo3U4Zq_58f2Y");
  void getLoc1() async {
    SharedPreferences laat1 = await SharedPreferences.getInstance();
    SharedPreferences laat2 = await SharedPreferences.getInstance();
    SharedPreferences long1 = await SharedPreferences.getInstance();
    SharedPreferences long2 = await SharedPreferences.getInstance();
    lat1 = laat1.getDouble('currentLat1')?.toDouble() ?? 0.0;
    lat2 = laat2.getDouble('currentLat2')?.toDouble() ?? 0.0;
    lng1 = long1.getDouble('currentLong1')?.toDouble() ?? 0.0;
    lng2 = long2.getDouble('currentLong2')?.toDouble() ?? 0.0;
    _initialCameraPosition = CameraPosition(
      target: LatLng(lat1, lng1),
      zoom: 10.5,
    );
    final Uint8List markerIcon1 =
        await getBytesFromAsset('assets/starting_location.png', 60);
    final Uint8List markerIcon2 =
        await getBytesFromAsset('assets/ending_location.png', 60);
    markerBitmap1 = BitmapDescriptor.fromBytes(markerIcon1);
    markerBitmap2 = BitmapDescriptor.fromBytes(markerIcon2);
    allMarkers1.add(
      Marker(
        icon: markerBitmap2,
        markerId: const MarkerId('myMarker1'),
        draggable: false,
        onTap: () {},
        position: LatLng(lat1, lng1),
      ),
    );
    allMarkers1.add(
      Marker(
        icon: markerBitmap2,
        markerId: const MarkerId('myMarker2'),
        draggable: false,
        onTap: () {},
        position: LatLng(lat2, lng2),
      ),
    );
    LatLng starting, ending;
    starting = LatLng(lat1, lng1);
    ending = LatLng(lat2, lng2);
    _drawPolyline(starting, ending);
    await check(lat1, lng1);
    await check(lat2, lng2);
    setState(() {});
  }

  late GoogleMapController mapController;
  // ignore: non_constant_identifier_names
  void _MapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    getLoc1();
  }

  List<SearchResult> data = <SearchResult>[];
  Future<void> check(double lat, double lng) async {
    var result = await googlePlace.search.getNearBySearch(
      Location(lat: lat, lng: lng),
      500,
      type: "restaurant",
    );
    var length = result?.results?.length ?? 0;
    for (int i = 0; i < length; i++) {
      data.add(result!.results![i]);
      // if (data[i].photos != null) {
      //   await getPhotos(data[i].photos?[0].photoReference.toString(),
      //       data[i].photos?[0].height, data[i].photos?[0].width);
      // }
      print('name: ${data[i].name.toString()}');
      print('icon: ${data[i].icon.toString()}');
      print('rating: ${data[i].rating.toString()}');
      print('weekdayText : ${data[i].openingHours?.weekdayText?.toString()}');
      print('openingHours : ${data[i].openingHours?.periods?.toString()}');
      print('userRatingsTotal: ${data[i].userRatingsTotal.toString()}');
      print('vicinity: ${data[i].vicinity.toString()}');
      print('businessStatus: ${data[i].businessStatus.toString()}');
      print('formattedAddress: ${data[i].formattedAddress.toString()}');
      print('priceLevel: ${data[i].priceLevel.toString()}');
      print('reference: ${data[i].reference.toString()}');
      print(
          'htmlAttributions of photo: ${data[i].photos?[0].htmlAttributions?[0].toString()}');
      print('photoReference: ${data[i].photos?[0].photoReference.toString()}');
    }
  }

  // Future<void> getPhotos(photo, height, width) async {
  //   // ignore: prefer_interpolation_to_compose_strings
  //   print('dsdda ${photo.toString()}');
  //   var resul = await googlePlace.photos.get(photo, height, width);
  //   print('my photo:$resul');
  // }

  @override
  Widget build(BuildContext context) {
    print('data l:${data.length}');
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: _initialCameraPosition == null
                  ? const CupertinoActivityIndicator()
                  : Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          child: GoogleMap(
                            initialCameraPosition: _initialCameraPosition,
                            myLocationButtonEnabled: true,
                            zoomControlsEnabled: false,
                            markers: allMarkers1,
                            polylines: polyLines,
                            onMapCreated: _MapCreated,
                          ),
                        ),
                        if (data.isNotEmpty)
                          Container(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight * 0.4,
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  for (int i = 0; i < data.length; i++)
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Image.network(
                                              data[i].icon.toString(),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            SizedBox(
                                              width:
                                                  constraints.maxWidth * 0.65,
                                              child: Text(
                                                data[i].name.toString(),
                                                style: utils
                                                    .extraSmallTitleStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
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
