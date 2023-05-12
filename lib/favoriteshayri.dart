import 'package:newshayrii/2-secpage.dart';
import 'package:flutter/material.dart';

class favshayri extends StatefulWidget {
  const favshayri({Key? key}) : super(key: key);

  @override
  State<favshayri> createState() => _favshayriState();
}

class _favshayriState extends State<favshayri> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0.8),
          title: Text("Favourite Shayari")),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("image/back.jpg"), fit: BoxFit.fill)),
        child: (secpage.favouriteshayari.length != 0)
            ? ListView.builder(
                itemCount: secpage.favouriteshayari.length,
                itemBuilder: (context, index) {
                  return Card(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 15),
                      color: Colors.white.withOpacity(0.3),
                      child: ListTile(
                        title: Text(
                          "${secpage.favouriteshayari[index]}",
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              secpage.favouriteshayari
                                  .remove(secpage.favouriteshayari[index]);
                            });
                          },
                          icon: Icon(Icons.delete),
                          color: Colors.white.withOpacity(0.8),
                          iconSize: 30,
                        ),
                      ),
                    );
                },
              )
            : Center(
                child: Text(
                "NO ANY SHAYARI",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
      ),
    );
  }
}
