import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  String _mapStyle = '';
  Set<Marker> markers = {};
  StreamSubscription<Position>? _positionStream;
  bool _isPermissionGranted = false;
  LatLng? _currentLocation;

  @override
  void initState() {
    _loadMapStyle();
    _checkPermissionRequest();
    super.initState();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(32.889767097833335, 13.187688398307397),
    zoom: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationEnabled: _isPermissionGranted,
        style: _mapStyle,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) async {
          _controller.complete(controller);
          BitmapDescriptor customIcon = await _customeMapIcon();
          setState(() {
            markers.addAll({
              Marker(
                markerId: const MarkerId('1'),
                position: const LatLng(32.88432919344257, 13.19593041792051),
                icon: customIcon,
                onTap:
                    () => ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Test1'))),
              ),
              Marker(
                markerId: const MarkerId('2'),
                position: const LatLng(32.87796314843565, 13.19048244573026),
                icon: customIcon,
                onTap:
                    () => ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Test2'))),
              ),
            });
          });
        },
        markers: markers,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _moveLocation(LatLng(32.324309990087784, 15.104600219666661));
        },
      ),
    );
  }

  void _moveLocation(LatLng target) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: target, zoom: 12)),
    );
  }

  Future _loadMapStyle() async {
    final String style = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/map_style.json');
    setState(() {
      _mapStyle = style;
    });
  }

  Future<BitmapDescriptor> _customeMapIcon() async {
    return await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/map-markers/home-marker.png',
    );
  }

  _checkPermissionRequest() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      setState(() {
        _isPermissionGranted = true;
      });
      _getUserLocation();
    } else {
      setState(() {
        _isPermissionGranted = false;
      });
    }
  }

  void _getUserLocation() async {
    if (!_isPermissionGranted) {
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });

    _moveLocation(
      _currentLocation ?? LatLng(32.889767097833335, 13.187688398307397),
    );

    _startTracking();
  }

  void _startTracking() async {
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    ).listen((Position position) {
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });
      _controller.future.then((controller) {
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target:
                  _currentLocation ??
                  LatLng(32.889767097833335, 13.187688398307397),
              zoom: 12,
            ),
          ),
        );
      });
    });
  }
}
