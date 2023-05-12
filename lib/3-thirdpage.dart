import 'package:animate_do/animate_do.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:newshayrii/4-editpage.dart';
import 'package:share_plus/share_plus.dart';

class thirdpage extends StatefulWidget {
  List shayarii;
  int index;

  thirdpage(this.shayarii, this.index);

  @override
  State<thirdpage> createState() => _thirdpageState();
}

class _thirdpageState extends State<thirdpage> {
  PageController PC = PageController();

  @override
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
            delay: Duration(milliseconds: 300),
            child: Text('View Shayari')),
      ),
      body: Container(
          height: bodyheight,
          width: twidth,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("image/back.jpg"),fit: BoxFit.fill)
          ),
          child: Column(
            children: [
              SizedBox(height: bodyheight * 0.13,),
              Padding(
                padding: const EdgeInsets.only(left: 17,right: 17),
                child: Container(
                  height: bodyheight * 0.55,
                    width: twidth,
                    child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.white,
                              width: 3,
                              style: BorderStyle.solid),
                        ),
                        child: PageView.builder(
                          physics: BouncingScrollPhysics(),
                          onPageChanged: (value) {
                            setState(() {
                              widget.index = value;
                            });
                          },
                          controller: PC,
                          itemCount: widget.shayarii.length,
                          itemBuilder: (context, index) {
                            return Center(
                              child: Text("${widget.shayarii[widget.index]}",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center),
                            );
                          },)
                    ),
                ),
              ),
              Expanded(child: Container()),
              Container(
                height: bodyheight * 0.082,
                width: twidth,
                color: Colors.white.withOpacity(0.3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          FlutterClipboard.copy(
                                  '${widget.shayarii[widget.index]}')
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.black38,
                              content: const Text('Copied',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.tealAccent),
                                  textAlign: TextAlign.center),
                              duration: const Duration(seconds: 2),
                            ));
                          });
                        },
                        icon: Icon(Icons.content_copy)
                        , iconSize: bodyheight * 0.038,
                      color: Colors.white.withOpacity(0.8)
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (0 < widget.index) {
                              widget.index--;
                              PC.jumpToPage(widget.index);
                            }
                          });
                        },
                        icon: Icon(Icons.arrow_back_ios_new),
                        iconSize: bodyheight * 0.038,
                        color: Colors.white.withOpacity(0.8)
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return editpage(widget.shayarii[widget.index]);
                            },
                          ));
                        },
                        icon: Icon(Icons.edit_off),
                        iconSize: bodyheight * 0.038,
                        color: Colors.white.withOpacity(0.8)
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (widget.index < widget.shayarii.length - 1) {
                              widget.index++;
                              PC.jumpToPage(widget.index);
                            }
                          });
                        },
                        icon: Icon(Icons.arrow_forward_ios),
                        iconSize: bodyheight * 0.038,
                        color: Colors.white.withOpacity(0.8)
                    ),
                    IconButton(
                        onPressed: () {
                          Share.share('${widget.shayarii[widget.index]}');
                        },
                        icon: Icon(Icons.share),
                        iconSize: bodyheight * 0.038,
                        color: Colors.white.withOpacity(0.8)
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
