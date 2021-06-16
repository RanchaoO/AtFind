import 'package:flutter/material.dart';
import '../service/client_sdk_service.dart';
import '../utils/constants.dart';
import 'package:at_contacts_flutter/at_contacts_flutter.dart';

class MyContactsScreen extends StatefulWidget {
  static final String id = 'MyContactsScreen';
  String activeAtSign = '';
  @override
  _MyContactsScreenState createState() => _MyContactsScreenState();
}

class _MyContactsScreenState extends State<MyContactsScreen> {
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
                      child: Text('contacts'),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ContactsScreen(),
                        ));
                      },
                    ),
                    ElevatedButton(
                      child: Text('Blocked contacts'),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => BlockedScreen(),
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
    initializeContactsService(clientSdkService.atClientInstance, activeAtSign,
        rootDomain: MixedConstants.ROOT_DOMAIN);
  }
}

// cannot block a contact
