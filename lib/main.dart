import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newshayrii/2-secpage.dart';
import 'package:newshayrii/splash_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import 'favoriteshayri.dart';
import 'package:animate_do/animate_do.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MaterialApp(
    title: "Hindi Shayari",
    home: splashscreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class newshayarii extends StatefulWidget {
  const newshayarii({Key? key}) : super(key: key);

  @override
  State<newshayarii> createState() => _newshayariiState();
}

class _newshayariiState extends State<newshayarii> {
  bool isDarkModeEnabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forpermission();
  }

  Future<void> forpermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await [
        Permission.storage,
      ].request();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }
  }

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

  toggleMenu([bool end = false]) {
    if (end) {
      final _state = _endSideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    } else {
      final _state = _sideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    double statusbar = MediaQuery.of(context).padding.top;
    double appbar = kToolbarHeight;
    double bodyheight = theight - appbar;

    return SideMenu(
      key: _endSideMenuKey,
      inverse: true,
      closeIcon: Icon(Icons.cancel_outlined, color: Colors.white, size: 35),
      // end side menu
      background: Colors.grey.withOpacity(0.3),
      type: SideMenuType.slideNRotate,
      menu: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: buildMenu(),
      ),
      onChange: (_isOpened) {
        setState(() => isOpened = _isOpened);
      },
      child: SideMenu(
        key: _sideMenuKey,
        closeIcon: Icon(Icons.cancel_outlined, color: Colors.white, size: 35),
        menu: buildMenu(),
        type: SideMenuType.slideNRotate,
        onChange: (_isOpened) {
          setState(() => isOpened = _isOpened);
        },
        child: IgnorePointer(
          ignoring: isOpened,
          child: WillPopScope(
            onWillPop: () {
              return showExitPopup(context);
            },
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => toggleMenu(),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => toggleMenu(true),
                  )
                ],
                backgroundColor: Colors.black.withOpacity(0.9),
                title: Text('Hindi Shayari'),
              ),
              body: Container(
                  height: bodyheight,
                  width: twidth,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("image/back.jpg"),
                          fit: BoxFit.fill)),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: Shayricatalog.length,
                    itemBuilder: (context, index) {
                      return FadeInUp(
                        delay: Duration(milliseconds: 500),
                        child: Card(
                          elevation: 0.0,
                          margin: EdgeInsets.fromLTRB(12, 10, 12, 10),
                          color: Colors.white.withOpacity(0.25),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13)),
                          shadowColor: Colors.grey,
                          child: ListTile(
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        top: 200,
                                        bottom: 200,
                                        right: 20,
                                        left: 20),
                                    color: Colors.transparent,
                                    child: CircleAvatar(
                                      backgroundImage:
                                          AssetImage('image/p${index + 1}.jpg'),
                                    ),
                                  );
                                },
                              );
                            },
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return secpage(Shayricatalog, index);
                                },
                              ));
                            },
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25,
                              backgroundImage:
                                  AssetImage('image/p${index + 1}.jpg'),
                            ),
                            trailing: Icon(
                              Icons.arrow_right,
                              color: Colors.white,
                              size: 25,
                            ),
                            title: Text('  ${Shayricatalog[index]}',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 22)),
                          ),
                        ),
                      );
                    },
                  )),
            ),
          ),
        ),
      ),
    );
  }

  bool isOpened = false;

  Widget buildMenu() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Shayari App",
                  style: TextStyle(color: Colors.white, fontSize: 35),
                ),
                SizedBox(height: 25.0),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return newshayarii();
                },
              ));
            },
            leading: const Icon(Icons.home, size: 30.0, color: Colors.white),
            title: const Text(
              "Home",
              style: TextStyle(fontSize: 20),
            ),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return favshayri();
                },
              ));
            },
            leading: const Icon(Icons.favorite_outline,
                size: 30.0, color: Colors.white),
            title: const Text(
              "Favourite",
              style: TextStyle(fontSize: 20),
            ),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return RatingDialog(
                    starColor: Colors.lightBlue,
                    title: Text('Rating Dialog In Flutter',
                        style: TextStyle(fontSize: 22)),
                    message: Text(
                        'Rating this app and tell others what you think.',
                        style: TextStyle(fontSize: 22)),
                    image: Image.asset(
                      "image/rr1.png",
                      height: 110,
                    ),
                    starSize: 35,
                    submitButtonText: 'Submit',
                    onCancelled: () => print('cancelled'),
                    onSubmitted: (response) {
                      print('rating: ${response.rating}, '
                          'comment: ${response.comment}');

                      if (response.rating < 3.0) {
                        print('response.rating: ${response.rating}');
                      } else {
                        Container();
                      }
                    },
                  );
                },
              );
            },
            leading:
                const Icon(Icons.star_border, size: 30.0, color: Colors.white),
            title: const Text(
              "Rate App",
              style: TextStyle(fontSize: 20),
            ),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.share, size: 30, color: Colors.white),
            title: const Text(
              "Share App",
              style: TextStyle(fontSize: 20),
            ),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  List Shayricatalog = [
    'लव शायरी ',
    'व्हाट्सप्प शायरी  ',
    'हैप्पी शायरी ',
    'ज़िन्दगी शायरी ',
    'दिवाली शायरी ',
    'दुआ शायरी ',
    'ख्वाब शायरी ',
    'प्यार शायरी ',
    'स्मोकिंग शायरी ',
    'सेक्सी शायरी ',
    'नई ईयर शायरी ',
  ];

  Future<bool> showExitPopup(context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Are You sure Exit This App?"),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print('Yes selected');
                          exit(0);
                        },
                        child: Text("Yes"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red.shade800),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        print('Yes selected');

                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'No',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
