import 'package:alkatrazpm/src/ui_utils/UIUtils.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Carusel extends StatelessWidget {
  static List<String> titles = [
    "Secure",
    "Comfortable",
    "! FREE !",
    "Try it now",
  ];
  static List<String> subtitles = [
    "\"I have never felt more secure. This app changed my life!\"",
    "\"It has never been easier\"",
    "It doesn't cost you a dime. There's no catch!",
    "All you have to do is SIGN UP. It only takes a few seconds!",
  ];


  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        child: anotherCarusel(context),
      ),
    );
  }

  Widget createIcon(BuildContext context, String pic, int index) {
    return Column(
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height*0.2,
            child: Image.asset(
              pic,
              fit: BoxFit.fitHeight,
            )),
        createTitle(context, index),
        createSubtitle(context, index),
      ],
    );
  }

  //Creates the title.
  Widget createTitle(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.only(top: 70.0),
      child: Text(
        titles[index],
        style: TextStyle(
          fontSize: UiUtils.authTitlefontSize(context)*0.8,
          color: Colors.white,
          letterSpacing: 4.0,
        ),
      ),
    );
  }

  //Creates the subtitle.
  static Widget createSubtitle(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.only(
        top: 30.0,
      ),
      child: Text(
        subtitles[index],
        style: TextStyle(
          color: Colors.white,
          fontSize: UiUtils.authTitlefontSize(context)*0.6,
          letterSpacing: 2.0,
        ),
      ),
    );
  }

  Widget anotherCarusel(BuildContext context) {
    List<Widget> poze = [
      createIcon(context, "poza11.png", 0),
      createIcon(context, "confortable.png", 1),
      createIcon(context, "free.png", 2),
      createIcon(context, "open-door.png", 3),
    ];
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
