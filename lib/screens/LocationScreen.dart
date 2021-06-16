import 'package:flutter/material.dart';
import '../service/client_sdk_service.dart';
import 'package:at_location_flutter/at_location_flutter.dart';

class LocationScreen extends StatefulWidget {
  static final String id = 'LocationScreen';
  String activeAtSign = '';
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  ClientSdkService clientSdkService = ClientSdkService.getInstance();
  String activeAtSign = '';
  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  void initState() {
    getAtSignAndInitContacts();
    scaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Contacts')),
      body: Center(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton(
                      child: Text('Location'),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => HomeScreen(),
                        ));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getAtSignAndInitContacts() async {
    String currentAtSign = await ClientSdkService.getInstance().getAtSign();
    setState(() {
      activeAtSign = currentAtSign;
    });
    initializeLocationService(clientSdkService.atClientServiceInstance.atClient,
        activeAtSign, NavService.navKey);
  }
}

class NavService {
  static GlobalKey<NavigatorState> navKey = GlobalKey();
}

// To request location from an atsign:

// await sendRequestLocationNotification(receiver);
// To share location from an atsign and duration of share in minutes:

// await sendShareLocationNotification(receiver, 30);
