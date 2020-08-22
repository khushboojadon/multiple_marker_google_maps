import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multiple_marker_google_maps/UI/home.dart';
import 'package:multiple_marker_google_maps/service/api.dart';

class PointsonMap extends StatefulWidget {
  @override
  _PointsonMapState createState() => _PointsonMapState();
}

class _PointsonMapState extends State<PointsonMap> {
  Completer<GoogleMapController> _controller = Completer();
  Api _api = Api();

  static const LatLng _center = const LatLng(2.7311, 75.88929999999999);

  final Set<Marker> _markers = {};

  // List<LatLng> coord = [
  //   LatLng(45.521563, -122.677433),
  //   LatLng(45.655757, -122.867867),
  //   LatLng(45.45435, -122.4535)
  // ];
  MapType _currentMapType = MapType.terrain;

  List<LatLng> list = [];
  getdata() async {
    final data = await _api.getdetails();
    final wayPorts = data.location;

    wayPorts.forEach((element) {
      var lat = double.parse(element.lat);
      var lon = double.parse(element.longg);
      list.add(LatLng(lat, lon));
    });
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getdata();
    });
  }

  _onAddMarkerButtonPressed() {
    setState(() {
      for (LatLng co in list) {
        _markers.add(
          Marker(
            // This marker id can be anything that uniquely identifies each marker.
            markerId: MarkerId(co.toString()),
            position: co,
            infoWindow: InfoWindow(
              title: '${list.toString()}',
              snippet: '5 Star Rating',
            ),
            icon: BitmapDescriptor.defaultMarker,
          ),
        );
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Point on Map'),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 5.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
              //  onCameraMove: _onCameraMove,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: "btn1",
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.people, size: 36.0),
                    ),
                    SizedBox(height: 16.0),
                    FloatingActionButton(
                      onPressed: _onAddMarkerButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.add_location, size: 36.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
