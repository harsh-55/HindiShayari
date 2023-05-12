import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'dart:ui' as ui;

class editpage extends StatefulWidget {
  var shayarii;

  editpage(this.shayarii);

  @override
  State<editpage> createState() => _editpageState();
}

class _editpageState extends State<editpage> {
  Color backgroundcolor = Colors.white.withOpacity(0.4);//BackGroundColor Variable
  Color textcolor = Colors.white;
  String currentemoji1 = '😂 🤣 ☺ 😇 🙂 🙃';
  String currentemoji2 = '😀 😃 😄 😁 😆 😅';
  double currentfontsize = 22;
  Color bordercolor = Colors.white;
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  var currentfontweight = FontWeight.w500;

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  GlobalKey SShare = GlobalKey();

  Future<Uint8List> _capturePng() async {
    try {
      print('inside');
      RenderRepaintBoundary? boundary =
      SShare.currentContext!.findRenderObject() as RenderRepaintBoundary?;
      ui.Image image = await boundary!.toImage(pixelRatio: 3.0);
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData!.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      print(pngBytes);
      print(bs64);
      setState(() {});
      return pngBytes;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  String folderpath =  "";

  _createFolder()async{
    final folderName="some_name";
    final path= Directory("storage/emulated/0/Download/$folderName");
    if ((await path.exists())){
      // TODO:
      print("exist");
    }else{
      // TODO:
      print("not exist");
      path.create();
    }
    folderpath = path.path;
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createFolder();
  }

  @override
  Widget build(BuildContext context) {

    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    double statusbar = MediaQuery.of(context).padding.top;
    double appbar = kToolbarHeight;
    double bodyheight = theight - appbar;

    return Scaffold(
        appBar: AppBar(
          title: Text("EDIT"),
          backgroundColor: Colors.black.withOpacity(0.9),
        ),
        body: Container(
          height: bodyheight,
          width: twidth,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("image/back.jpg"),fit: BoxFit.fill)
          ),
          child: Column(
            children: [
              SizedBox(height: bodyheight * 0.08),
              RepaintBoundary(
                key: SShare,
                child: Padding(
                  padding: const EdgeInsets.only(left: 17,right: 17),
                  child: Container(
                    height: bodyheight * 0.53,
                    width: twidth,
                    decoration: BoxDecoration(
                      color: backgroundcolor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: bordercolor,
                              width: 3,
                              style: BorderStyle.solid),
                        ),
                        child: Center(
                    child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Text('$currentemoji1',
                            style: TextStyle(fontSize: 25)),
                        Text("${widget.shayarii}",
                            style: TextStyle(
                                color: textcolor,
                                fontSize: currentfontsize,
                                fontWeight: currentfontweight,),
                            textAlign: TextAlign.center),
                        Text('$currentemoji2',
                            style: TextStyle(fontSize: 25)),
                      ],
                    ),
                  ),
                ),
                    ),
                  ),
                ),
              ),
              Expanded(child: Container()),
              Container(
                height: bodyheight * 0.21,
                width: double.infinity,
                color: Colors.white.withOpacity(0.35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: bodyheight * 0.058,
                          width: twidth * 0.3,
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Pick a color!'),
                                    content: SingleChildScrollView(
                                      child: ColorPicker(
                                        pickerColor: pickerColor,
                                        onColorChanged: changeColor,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: const Text('Got it'),
                                        onPressed: () {
                                          setState(
                                                  () => backgroundcolor = pickerColor);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.color_lens_outlined),
                          color: Colors.cyanAccent,
                            iconSize: bodyheight * 0.045,
                          ),
                        ),
                        SizedBox(
                          height: bodyheight * 0.058,
                          width: twidth * 0.3,
                          child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: bodyheight * 0.21,
                                      color: Colors.black.withOpacity(0.6),
                                      child: GridView.builder(
                                          physics: BouncingScrollPhysics(),
                                          itemCount: bordercolorlist.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                setState(() {
                                                  bordercolor =
                                                  bordercolorlist[index];
                                                });
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(bodyheight * 0.01),
                                                decoration: BoxDecoration(
                                                    color: bordercolorlist[index],
                                                    border: Border.all(
                                                        width: 2,
                                                        color: Colors.black)),
                                              ),
                                            );
                                          },
                                          gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 6)),
                                    );
                                  },
                                );
                              },
                            icon: Icon(Icons.border_color_outlined),
                            color: Colors.cyanAccent,
                            iconSize: bodyheight * 0.038,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: bodyheight * 0.058,
                          width: twidth * 0.3,
                          child:
                          ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: bodyheight * 0.21,
                                      color: Colors.black.withOpacity(0.6),
                                      child: GridView.builder(
                                          physics: BouncingScrollPhysics(),
                                          itemCount: backgroundlist.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    backgroundcolor =
                                                        backgroundlist[index];
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(bodyheight * 0.01),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          backgroundlist[index],
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Colors.black)),
                                                ));
                                          },
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 6)),
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF373573)),
                              child: Text(
                                "Background",
                                style: TextStyle(color: Color(0xFFBCEDCB),
                                fontSize: bodyheight * 0.02,
                                ),
                              )),
                        ),
                        SizedBox(
                          height: bodyheight * 0.058,
                          width: twidth * 0.3,
                          child: ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: bodyheight * 0.21,
                                      color: Colors.black.withOpacity(0.6),
                                      child: GridView.builder(
                                          physics: BouncingScrollPhysics(),
                                          itemCount: textcolorlist.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                setState(() {
                                                  textcolor =
                                                      textcolorlist[index];
                                                });
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(7),
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: textcolorlist[index],
                                                    border: Border.all(
                                                        width: 2,
                                                        color: Colors.black)),
                                              ),
                                            );
                                          },
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 6)),
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF373573)),
                              child: Text("Text Color",
                                  style: TextStyle(color: Color(0xFFBCEDCB),
                                    fontSize: bodyheight * 0.02,
                                  ))),
                        ),
                        SizedBox(
                          height: bodyheight * 0.058,
                          width: twidth * 0.3,
                          child: ElevatedButton(
                              onPressed: () {
                                _capturePng().then((value) async {
                                  String imagename = "image${Random().nextInt(1000)}.jpg";
                                  String imagepath = "$folderpath/$imagename";
                                  File file =File(imagepath);
                                  file.writeAsBytes(value);
                                   await file.create();
                                  Share.shareFiles(['${file.path}']);
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF373573)),
                              child: Text("Share",
                                  style: TextStyle(color: Color(0xFFBCEDCB),
                                    fontSize: bodyheight * 0.02,
                                  ))),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: bodyheight * 0.058,
                          width: twidth * 0.3,
                          child: ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: bodyheight * 0.21,
                                      color: Colors.black.withOpacity(0.6),
                                      child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: fontweightlist.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                              setState(() {
                                                currentfontweight =
                                                fonttlist[index];
                                              });
                                            },
                                            child: SizedBox(
                                              height: 60,
                                              width: twidth * 0.02,
                                              child: Card(
                                                margin: EdgeInsets.all(8),
                                                color: Colors.white.withOpacity(0.5),
                                                elevation: 5,
                                                child: Center(
                                                    child: Text(
                                                      fontweightlist[index],
                                                      style:
                                                      TextStyle(fontSize: 27),
                                                    )),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF373573)),
                              child: Text("Font Weight",
                                  style: TextStyle(color: Color(0xFFBCEDCB),
                                    fontSize: bodyheight * 0.02,
                                  ))),
                        ),
                        SizedBox(
                          height: bodyheight * 0.058,
                          width: twidth * 0.3,
                          child: ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: bodyheight * 0.21,
                                      color: Colors.black.withOpacity(0.6),
                                      child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: emojilist.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                              setState(() {
                                                currentemoji1 =
                                                    emojilist[index];
                                                currentemoji2 =
                                                    emojilist[index];
                                              });
                                            },
                                            child: SizedBox(
                                              height: 70,
                                              child: Card(
                                                margin: EdgeInsets.all(8),
                                                color: Colors.white.withOpacity(0.5),
                                                elevation: 5,
                                                child: Center(
                                                    child: Text(
                                                  emojilist[index],
                                                  style:
                                                      TextStyle(fontSize: 27),
                                                )),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF373573)),
                              child: Text("Emoji",
                                  style: TextStyle(color: Color(0xFFBCEDCB),
                                    fontSize: bodyheight * 0.02,
                                  ))),
                        ),
                        SizedBox(
                          height: bodyheight * 0.058,
                          width: twidth * 0.3,
                          child: ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                        height: 110,
                                        color: Colors.black.withOpacity(0.6),
                                        child: StatefulBuilder(
                                          builder: (context, setState1) {
                                            return SfSlider(
                                              min: 10,
                                              max: 50,
                                              interval: 10,
                                              showTicks: true,
                                              showLabels: true,
                                              enableTooltip: true,
                                              minorTicksPerInterval: 1,
                                              value: currentfontsize,
                                              onChanged: (value) {
                                                setState1(() {
                                                  setState(() {
                                                    currentfontsize = value;
                                                  });
                                                });
                                              },
                                            );
                                          },
                                        ));
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF373573)),
                              child: Text("Text Size",
                                  style: TextStyle(color: Color(0xFFBCEDCB),
                                    fontSize: bodyheight * 0.02,
                                  ))),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  List backgroundlist = [
    Colors.white,
    Colors.indigo,
    Colors.blue,
    Colors.red,
    Colors.amber,
    Colors.blueAccent,
    Colors.blueGrey,
    Colors.cyanAccent,
    Colors.brown,
    Colors.yellowAccent,
    Colors.tealAccent,
    Colors.purpleAccent,
    Colors.orange,
    Colors.redAccent,
    Colors.indigoAccent,
    Color(0xFF85354F),
    Color(0xFFA2024A),
    Color(0xFF522964),
    Color(0xFFA1CFDC),
    Color(0xFFDC0860),
    Color(0xFF016C9F),
    Color(0xFF714C0C),
    Color(0xFF25AE0B),
    Color(0xFF782D23),
    Color(0xFF324655),
    Color(0xFF5F7896),
    Color(0xFFC86469),
    Color(0xFF64505A),
    Color(0xFF00324B),
    Color(0xFF82CDD7),
    Color(0xFFF57DDC),
    Color(0xFFA08C78),
    Color(0xFFEBDCC3),
    Color(0xFF28373C),
    Color(0xFFFFB946)
  ];
  List textcolorlist = [
    Colors.white,
    Colors.indigo,
    Colors.blue,
    Colors.red,
    Colors.amber,
    Colors.blueAccent,
    Colors.blueGrey,
    Colors.cyanAccent,
    Colors.yellowAccent,
    Colors.tealAccent,
    Colors.brown,
    Colors.purpleAccent,
    Colors.redAccent,
    Colors.indigoAccent,
    Colors.orange,
    Color(0xFF85354F),
    Color(0xFFA2024A),
    Color(0xFF522964),
    Color(0xFFA1CFDC),
    Color(0xFFDC0860),
    Color(0xFF016C9F),
    Color(0xFF714C0C),
    Color(0xFF25AE0B),
    Color(0xFF782D23),
    Color(0xFF324655),
    Color(0xFF5F7896),
    Color(0xFFC86469),
    Color(0xFF64505A),
    Color(0xFF00324B),
    Color(0xFF82CDD7),
    Color(0xFFF57DDC),
    Color(0xFFA08C78),
    Color(0xFFEBDCC3),
    Color(0xFF28373C),
    Color(0xFFFFB946),
  ];
  List emojilist = [
    '😀 😃 😄 😁 😆 😅',
    '😂 🤣 ☺ 😇 🙂 🙃',
    '😉 😌 😍 🥰 😘',
    '😗 😙 😚 😋 😛 😝',
    '😜 🤪 🤨 😋 😛 😝',
    '🤩 🥳 😏 😒 😞 😔',
    '😟 😕 🙁 ☹',
    '😣 😖 😫 😩 🥺',
    '😢 😭 😤 😠 😡',
    '🤬 🤯 😳 🥵',
    '🥶 😱 😨 😰 😥',
    '😓 🤗 🤔 🤭 🤫',
    '🤥 😶 😐 😑',
    '😬 🙄 😯 😦 😧',
    '😮 😲 🥱 😴',
    '🤤 😪 😵 🤐 🥴',
    '🤢 🤮 🤧 😷 🤒',
    '🤕 🤑 🤠 😈 👿',
    '👻 💀 ☠️ 👽 👾 🤖',
    '🎃 😺 😸 😹 😻',
    '💁‍♀️ 💁 💁‍♂️ 🙅‍♀️ 🙅',
    '🙅‍♂️ 🙆‍♀️ 🙆 🙆‍♂️ 🙋‍♀️',
    '🧣 🧤 🧥 🧦 👗',
    '🧑🏻 👨🏻 👩🏻‍🦱 🧑🏻‍🦱 ',
    '👱🏻‍♀️ 👱🏻 👱🏻‍♂️ 👩🏻‍🦳',
    '🧑🏻‍🎤 👨🏻‍🎤 👩🏻‍🏫 ',
    '🐶 🐱 🐭 🐹 🐰',
    '🦊 🐻 🐼 🐻‍❄️',
    '🐨 🐯 🦁 🐮',
    '🦆 🦅 🦉 🦇',
    '🦈 🐊 🐅 🐆',
    '🦁 🦁 🦁 🦁 🦁',
    '🌏 🌏 🌏 🌏 🌏',
    '🥇 🥇 🥇 🥇 🥇 ',
    '🥈 🥈 🥈 🥈 🥈 ',
    '🥉 🥉 🥉 🥉 🥉 ',
    ' 🏅  🏅  🏅  🏅  🏅 ',
    '🏛 ⛪️ 🕌 🕍 🛕',
    '❤ 🧡 💛 💚',
    '💔 ❣️ 💕 💞',
    '👰🏾‍♂️ 👰🏿‍♂️',
    '✪ ✪ ✪ ✪ ✪',
    '🎦 🎦 🎦 🎦 🎦'
  ];
  List bordercolorlist = [
    Colors.white,
    Colors.indigo,
    Colors.blue,
    Colors.red,
    Colors.amber,
    Colors.blueAccent,
    Colors.blueGrey,
    Colors.cyanAccent,
    Colors.yellowAccent,
    Colors.tealAccent,
    Colors.brown,
    Colors.purpleAccent,
    Colors.redAccent,
    Colors.indigoAccent,
    Colors.orange,
    Color(0xFF85354F),
    Color(0xFFA2024A),
    Color(0xFF522964),
    Color(0xFFA1CFDC),
    Color(0xFFDC0860),
    Color(0xFF016C9F),
    Color(0xFF714C0C),
    Color(0xFF25AE0B),
    Color(0xFF782D23),
    Color(0xFF324655),
    Color(0xFF5F7896),
    Color(0xFFC86469),
    Color(0xFF64505A),
    Color(0xFF00324B),
    Color(0xFF82CDD7),
    Color(0xFFF57DDC),
    Color(0xFFA08C78),
    Color(0xFFEBDCC3),
    Color(0xFF28373C),
    Color(0xFFFFB946),
  ];
  List fonttlist = [
    FontWeight.normal,
    FontWeight.bold,
    FontWeight.w100,
    FontWeight.w200,
    FontWeight.w300,
    FontWeight.w400,
    FontWeight.w500,
    FontWeight.w600,
    FontWeight.w700,
    FontWeight.w800,
    FontWeight.w900,
  ];
  List fontweightlist = [
    "Normal",
    "Bold",
    "w100",
    "w200",
    "w300",
    "w400",
    "w500",
    "w600",
    "w700",
    "w800",
    "w900",
  ];
  
}
