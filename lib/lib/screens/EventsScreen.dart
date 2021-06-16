import 'package:at_tylers_demo/utils/constants.dart';
import 'package:flutter/material.dart';
import '../service/client_sdk_service.dart';
import 'package:at_events_flutter/at_events_flutter.dart';

class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  ClientSdkService clientSdkService = ClientSdkService.getInstance();
  String activeAtSign;
  GlobalKey<ScaffoldState> scaffoldKey;
  bool isAuthenticated;

  @override
  void initState() {
    scaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();

    try {
      activeAtSign =
          clientSdkService.atClientServiceInstance.atClient.currentAtSign;
      initializeEventService();
      isAuthenticated = true;
    } catch (e) {
      isAuthenticated = false;
      print('not authenticated');
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alertDialogContent();
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Second Screen')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Center(
              child: Text(
                'Welcome $activeAtSign!',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextButton(
            onPressed: () {
              bottomSheet(
                  CreateEvent(), MediaQuery.of(context).size.height * 0.9);
            },
            child: Container(
              height: 40,
              child:
                  Text('Create event', style: TextStyle(color: Colors.black)),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => EventScreen(),
              ));
            },
            child: Container(
              height: 40,
              child: Text('Event list', style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }

  void initializeEventService() {
    initialiseEventService(clientSdkService.atClientServiceInstance.atClient,
        rootDomain: MixedConstants.ROOT_DOMAIN);
  }

  void bottomSheet(
    T,
    double height,
  ) async {
    await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        shape: StadiumBorder(),
        builder: (BuildContext context) {
          return Container(
            height: height,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12.0),
                topRight: const Radius.circular(12.0),
              ),
            ),
            child: T,
          );
        });
  }

  Widget alertDialogContent() {
    return AlertDialog(
      title: Text('you are not authenticated'),
      actions: [
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: Text('Ok', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
