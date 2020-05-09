import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Carusel extends StatelessWidget {
  static List<String> titles = [
    "Secure",
    "Confortable",
    "! FREE !",
    "Try it now",
  ];
  static List<String> subtitles = [
    "\"I have never felt more secure. This app changed my life!\"",
    "\"It has never been easier\"",
    "It doesn't cost you a dime. There's no catch!",
    "All you have to do is SIGN UP. It only takes a few seconds!",
  ];
  List<Widget> poze = [
    createIcon("poza11.png", 0),
    createIcon("confortable.png", 1),
    createIcon("free.png", 2),
    createIcon("open-door.png", 3),
//    Image.asset("poza1.jpg"),
//    Image.asset("poza2.jpg"),
//    Image.asset("poza3.jpg"),
//    Image.asset("poza4.jpg"),
//    Image.asset("poza5.jpg"),
//    Image.asset("poza6.jpg"),
//    Image.asset("poza7.jpg"),
//    Image.asset("poza8.jpg"),
//    Image.asset("poza9.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        child: anotherCarusel(context),
      ),
    );
  }

  static Widget createIcon(String pic, int index) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
              height: 300,
              child: Image.asset(
                pic,
                fit: BoxFit.fitHeight,
              )),
          createTitle(index),
          createSubtitle(index),
        ],
      ),
    );
  }

  //Creates the title.
  static Widget createTitle(int index) {
    return Container(
      padding: EdgeInsets.only(top: 70.0),
      child: Text(
        titles[index],
        style: TextStyle(
          fontSize: 40.0,
          color: Colors.white,
          letterSpacing: 4.0,
        ),
      ),
    );
  }

  //Creates the subtitle.
  static Widget createSubtitle(int index) {
    return Container(
      padding: EdgeInsets.only(
        top: 30.0,
      ),
      child: Text(
        subtitles[index],
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          letterSpacing: 2.0,
        ),
      ),
    );
  }

  Widget anotherCarusel(BuildContext context) {
    return CarouselSlider(
        items: poze,
        options: CarouselOptions(
          //height: 400,
          aspectRatio: 16 / 9,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 6),
          autoPlayAnimationDuration: Duration(milliseconds: 2000),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ));
  }

  //This function is not used at the moment at all.
  Widget getCarusel() {
    return Carousel(
      animationCurve: Curves.easeIn,
      showIndicator: false,
      borderRadius: false,
      moveIndicatorFromBottom: 180.0,
      noRadiusForIndicator: true,
      overlayShadow: true,
      overlayShadowColors: Colors.blue,
      overlayShadowSize: 0.7,
      animationDuration: Duration(seconds: 3),
      autoplayDuration: Duration(seconds: 10),
      boxFit: BoxFit.cover,
      images: [
        AssetImage("poza1.jpg"),
        AssetImage("poza2.jpg"),
        AssetImage("poza3.jpg"),
        AssetImage("poza4.jpg"),
        AssetImage("poza5.jpg"),
        AssetImage("poza6.jpg"),
        AssetImage("poza7.jpg"),
        AssetImage("poza8.jpg"),
      ],
    );
  }
}
