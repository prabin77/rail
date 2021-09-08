import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.725066557420057, 85.32611744221296),
    zoom: 14.4746,
  );

  static final CameraPosition _khajuri = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(26.64245917817401, 86.11490076401445),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  static final CameraPosition _inarwa = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(26.61539899467346, 86.14092048390512),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static final CameraPosition _mahinathpur = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(26.663327795317514, 86.06452346856264),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static final CameraPosition _sahidSajornagar = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(26.669191052082372, 86.04740207926162),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static final CameraPosition _baidehi = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(26.679238072668074, 86.02422041073487),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static final CameraPosition _deuriparbaha = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(26.701739891880635, 85.9939671367431),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static final CameraPosition _janakpur = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(26.733875721403564, 85.9369513817704),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Column(
              children: [
                Row(children: [
                  RaisedButton(
                    onPressed: _goToKhajuri,
                    child: Text('Khajuri'),
                  ),
                  RaisedButton(
                    onPressed: _goToInarwa,
                    child: Text('Inarwa'),
                  ),
                  RaisedButton(
                    onPressed: _goToMahinathpur,
                    child: Text('Mahinathpur'),
                  ),
                  RaisedButton(
                    onPressed: _goToJanakpur,
                    child: Text('Janakpur'),
                  ),
                ]),
                Row(children: [
                  RaisedButton(
                    onPressed: _goToSahidSarojnagar,
                    child: Text('Sahid Sarojnagar, Duhabi'),
                  ),
                  RaisedButton(
                    onPressed: _goToBaidehi,
                    child: Text('Baidehi, Itaharwa'),
                  ),
                ]),
                Row(
                  children: [
                    RaisedButton(
                      onPressed: _goToDeuriParbaha,
                      child: Text('Deuri parbaha'),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),

      // GoogleMap(
      //   mapType: MapType.hybrid,
      //   initialCameraPosition: _kGooglePlex,
      //   onMapCreated: (GoogleMapController controller) {
      //     _controller.complete(controller);
      //   },
      // ),
    );
  }

  Future<void> _goToKhajuri() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_khajuri));
  }

  Future<void> _goToInarwa() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_inarwa));
  }

  Future<void> _goToMahinathpur() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_mahinathpur));
  }

  Future<void> _goToSahidSarojnagar() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_sahidSajornagar));
  }

  Future<void> _goToBaidehi() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_baidehi));
  }

  Future<void> _goToDeuriParbaha() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_deuriparbaha));
  }

  Future<void> _goToJanakpur() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_janakpur));
  }
}
