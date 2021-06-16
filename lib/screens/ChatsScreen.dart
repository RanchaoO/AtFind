import 'package:at_chat_flutter/at_chat_flutter.dart';
import 'package:at_tylers_demo/screens/ChatWithAtsign.dart';
import 'package:at_tylers_demo/screens/onboarding.dart';
import 'package:flutter/material.dart';
import '../service/client_sdk_service.dart';
import 'ChatWithAtsign.dart';
import '../utils/constants.dart';

class ChatsScreen extends StatefulWidget {
  static final String id = 'ChatsScreen';
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  ClientSdkService clientSdkService = ClientSdkService.getInstance();
  String activeAtSign = '';
  GlobalKey<ScaffoldState> scaffoldKey;
  String chatWithAtSign;
  bool showOptions = false;
  bool isEnabled = true;

  @override
  void initState() {
    // TODO: Call function to initialize chat service.
    getAtSignAndInitializeChat();
    scaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text(
                'Welcome $activeAtSign!',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Row(
                          children: [Text('Delete $activeAtSign')],
                        ),
                        content: Text('Press Yes to confirm'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                              await ClientSdkService.getInstance()
                                  .deleteAtSignFromKeyChain();
                              await Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  OnboardingScreen.id,
                                  (Route<dynamic> route) => false);
                            },
                            child: Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No'),
                          )
                        ],
                      );
                    });
              },
              child: Text('Remove $activeAtSign'),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text('Choose an @sign to chat with'),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                decoration:
                    InputDecoration(hintText: 'Enter an @sign to chat with'),
                onChanged: (value) {
                  chatWithAtSign = value;
                },
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            showOptions
                ? Column(
                    children: [
                      SizedBox(height: 20.0),
                      TextButton(
                        onPressed: () {
                          var _res = checkForValidAtsignAndSet();
                          if (_res == true)
                            scaffoldKey.currentState
                                .showBottomSheet((context) => ChatScreen());
                        },
                        child: Container(
                          height: 40,
                          child: Text('Open chat in bottom sheet'),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          var _res = checkForValidAtsignAndSet();
                          if (_res == true)
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatWithAtsign()));
                        },
                        child: Container(
                          height: 40,
                          child: Text('Navigate to chat screen'),
                        ),
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          if (chatWithAtSign != null &&
                              chatWithAtSign.trim() != '') {
                            // TODO: Call function to set receiver's @sign
                            setAtsignToChatWith();
                            setState(() {
                              showOptions = true;
                            });
                          } else {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [Text('@sign Missing!')],
                                    ),
                                    content: Text('Please enter an @sign'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Close'),
                                      )
                                    ],
                                  );
                                });
                          }
                        },
                        child: Container(
                          height: 40,
                          child: Text('Chat options'),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  checkForValidAtsignAndSet() {
    if (chatWithAtSign != null && chatWithAtSign.trim() != '') {
      // TODO: Call function to set receiver's @sign
      setAtsignToChatWith();
      setState(() {
        showOptions = true;
      });
      return true;
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: [Text('@sign Missing!')],
              ),
              content: Text('Please enter an @sign'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'),
                )
              ],
            );
          });
    }
  }

  // TODO: Write function to initialize the chatting service
  getAtSignAndInitializeChat() async {
    String currentAtSign = await clientSdkService.getAtSign();
    setState(() {
      activeAtSign = currentAtSign;
    });
    // List<String> allAtSigns = at_demo_data.allAtsigns;
    // allAtSigns.remove(activeAtSign);
    // setState(() {
    //   atSigns = allAtSigns;
    // });
    initializeChatService(
        clientSdkService.atClientServiceInstance.atClient, activeAtSign,
        rootDomain: MixedConstants.ROOT_DOMAIN);
  }

  // TODO: Write function that determines whom you are chatting with
  setAtsignToChatWith() {
    // print(activeAtSign);
    // print(chatWithAtSign);
    setChatWithAtSign(chatWithAtSign);
  }
}
