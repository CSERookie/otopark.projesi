import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MapsSample extends StatefulWidget {
  @override
  _MapsSampleState createState() => _MapsSampleState();
}

class _MapsSampleState extends State<MapsSample> {
  bool pressAttention = false;
  bool pressAttention1 = false;
  final Set<Marker> _markers = Set();
  final double _zoom = 10;
  CameraPosition _initialPosition =
      CameraPosition(target: LatLng(26.8206, 30.8025));
  MapType _defaultMapType = MapType.normal;
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTOPARKIM'),
        centerTitle: true,
      ),
      drawer: _drawer(),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            markers: _markers,
            mapType: _defaultMapType,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
          ),
          Container(
            margin: EdgeInsets.only(top: 80, right: 10),
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                    child: Icon(Icons.layers),
                    elevation: 5,
                    backgroundColor: Colors.teal[200],
                    onPressed: () {
                      _changeMapType();
                      print('Changing the Map Type');
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      elevation: 16.0,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("OTOPARKIM"),
            accountEmail: Text("info@otoparkim.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/otoparkim.jpg'),
              
            ),
         
          ),
          ListTile(
            title: new Text("Favoriler"),
            leading: new Icon(Icons.star),
          ),
          Divider(),
          ListTile(
            onTap: () {
              _goToNewYork();
              Navigator.of(context).pop();
            },
            title: new Text("Maçka Katlı Otopark"),
            trailing: new Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: () {
              _goToNewDelhi();
              Navigator.of(context).pop();
            },
            title: new Text("Karaköy Katlı Otopark"),
            trailing: new Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: () {
              _goToLondon();
              Navigator.of(context).pop();
            },
            title: new Text("Büyük Beşiktaş Otopark"),
            trailing: new Icon(Icons.arrow_forward_ios),
          ),
         
        ],
      ),
    );
  }

  Future<void> _goToNewYork() async {
    double lat = 41.0470365;
    double long = 28.9906308;
    GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('Maçka'),
            position: LatLng(lat, long),
            infoWindow:
                InfoWindow(title: 'MAÇKA', snippet: 'Maçka Katlı Otopark')),
      );
    });
  }

  Future<void> _goToNewDelhi() async {
    double lat = 41.0229803;
    double long = 28.9770661;
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('KARAKÖY'),
          position: LatLng(lat, long),
          infoWindow:
              InfoWindow(title: 'KARAKÖY', snippet: 'Karaköy Katlı Otopark'),
          onTap: () => _onButtonPressed(),
        ),
      );
    });
  }

  Future<void> _goToLondon() async {
    double lat = 41.0447782;
    double long = 29.0055095;
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('BEŞİKTAŞ'),
            position: LatLng(lat, long),
            infoWindow:
                InfoWindow(title: 'BEŞİKTAŞ', snippet: 'Büyük Beşiktaş Otopark')),
      );
    });
  }

  void _onButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Doluluk Oranı',
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 30, right: 25, bottom: 15, top: 7),
                  child: LinearPercentIndicator(
                    width: 290,
                    animation: true,
                    lineHeight: 20.0,
                    animationDuration: 2000,
                    percent: 0.9,
                    center: Text("90.0%"),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Colors.greenAccent,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.monetization_on),
                  title: Text('SAAT    /    2₺'),
                ),
                ListTile(leading: Icon(Icons.people),title: Text('638 ziyaretçi'),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(23),
                      color: Colors.red,
                      child: Text('O1'),
                    ),
                    Container(
                      padding: EdgeInsets.all(23),
                      color: Colors.red,
                      child: Text('O2'),
                    ),
                    SizedBox(
                      width: 75,
                      height: 67,
                      child: RaisedButton(
                        child: Text('O3'),
                        textColor: Colors.black,
                        color: pressAttention ? Colors.green : Colors.white,
                        onPressed: () =>
                            setState(() => pressAttention = !pressAttention),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(23),
                      color: Colors.red,
                      child: Text('O4'),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(25),
                        color: Colors.red,
                        child: Text('T1'),
                      ),
                      SizedBox(
                      width: 75,
                      height: 67,
                      child: RaisedButton(
                        child: Text('T2'),
                        textColor: Colors.black,
                        color: pressAttention1 ? Colors.green : Colors.white,
                        onPressed: () =>
                            setState(() => pressAttention1 = !pressAttention1),
                      ),
                    ),
                      Container(
                        padding: EdgeInsets.all(25),
                        color: Colors.red,
                        child: Text('T3'),
                      ),
                      Container(
                        padding: EdgeInsets.all(25),
                        color: Colors.red,
                        child: Text('T4'),
                      ),
                    ]),
                    Padding(padding: EdgeInsets.all(10),),
                    

              ]);
        });
  }
}
