import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:newshayrii/modal.dart';
import 'package:newshayrii/3-thirdpage.dart';
import 'package:url_launcher/url_launcher.dart';

class secpage extends StatefulWidget {
  static List favouriteshayari = []; // Favourite shayari global
  List Shayricatalog;
  int index;

  secpage(this.Shayricatalog, this.index);

  @override
  State<secpage> createState() => _secpageState();
}

class _secpageState extends State<secpage> {
  List shayariiii = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.index == 0) {
      shayariiii = modal.Love;
    } else if (widget.index == 1) {
      shayariiii = modal.Whatsapp;
    } else if (widget.index == 2) {
      shayariiii = modal.Happy;
    } else if (widget.index == 3) {
      shayariiii = modal.Jindagi;
    } else if (widget.index == 4) {
      shayariiii = modal.Diwali;
    } else if (widget.index == 5) {
      shayariiii = modal.Dua;
    } else if (widget.index == 6) {
      shayariiii = modal.Khwab;
    } else if (widget.index == 7) {
      shayariiii = modal.Pyar;
    } else if (widget.index == 8) {
      shayariiii = modal.Smoking;
    } else if (widget.index == 9) {
      shayariiii = modal.Sexy;
    } else if (widget.index == 10) {
      shayariiii = modal.Newyear;
    }
  }

  String currentemoji1 = '😂 🤣 ☺ 😇 🙂 🙃';
  String currentemoji2 = '😀 😃 😄 😁 😆 😅';
  TextEditingController whatsapp = TextEditingController();
  String? whatsappMO;

  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    double statusbar = MediaQuery.of(context).padding.top;
    double appbar = kToolbarHeight;
    double bodyheight = theight - appbar;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.9),
        title: FadeInUp(
            delay: Duration(milliseconds: 500),
            child: Text('${widget.Shayricatalog[widget.index]}')),
      ),
      body: Container(
        height: bodyheight,
        width: twidth,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("image/back.jpg"), fit: BoxFit.fill)),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: shayariiii.length,
          itemBuilder: (context, index) {
            return FadeInUp(
              delay: Duration(milliseconds: 600),
              child: Container(
                margin: EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.22),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return thirdpage(shayariiii, index);
                          },
                        ));
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Text("$currentemoji1",
                                style: TextStyle(fontSize: 23)),
                            Text('${shayariiii[index]}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 23),
                                textAlign: TextAlign.center),
                            Text("$currentemoji2",
                                style: TextStyle(fontSize: 23))
                          ],
                        ),
                      ),
                    ),
                    Divider(
                        color: Colors.black,
                        height: 10,
                        indent: 10,
                        endIndent: 10,
                        thickness: 3),
                    Container(
                      height: 40,
                      color: Colors.white10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FavoriteButton(
                            iconSize: 40,
                            valueChanged: (_isFavorite) {
                              secpage.favouriteshayari
                                  .add("${shayariiii[index]}");
                            },
                          ),
                          SizedBox(width: 10),
                          IconButton(
                            onPressed: () {
                              flutterTts.setLanguage("hi-IN");
                              flutterTts.speak("${shayariiii[index]}");
                            },
                            icon: Icon(Icons.settings_voice_rounded),
                            color: Colors.tealAccent,
                          ),
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: 400,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(15),
                                            child: TextField(
                                              controller: whatsapp,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20))),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                              onChanged: (value) {
                                                whatsappMO = whatsapp.text;
                                              },
                                            ),
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                openwhatssapp(index);
                                              },
                                              child: Text("Share"))
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: Icon(FontAwesomeIcons.whatsapp,
                                  color: Colors.lightGreenAccent,size: 25)),
                          SizedBox(width: 5,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  FlutterTts flutterTts = FlutterTts();

  openwhatssapp(int index) async {
    var whatsapp = "$whatsappMO";
    var whatsappURL_android =
        "https://wa.me/$whatsapp?text=${Uri.parse("${shayariiii[index]}")}";
    if (Platform.isAndroid) {
      if (await canLaunch(whatsappURL_android)) {
      } else {
        await launch(whatsappURL_android);
      }
    }
  }
}
