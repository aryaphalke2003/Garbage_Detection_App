import 'package:flutter/material.dart';

class BannerViewer extends StatelessWidget {
  final String heading;
  final String icon1;
  final String icon2;
  final String icon3;

  const BannerViewer(
      {required this.heading,
      required this.icon1,
      required this.icon2,
      required this.icon3,
      super.key});

  @override
  Widget build(BuildContext context) {
    double widthO = MediaQuery.of(context).size.width;

    return Container(
      width: widthO,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: widthO * 0.895,
                height: 30,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.lightGreenAccent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Text(heading,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600)),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(10))),
                  height: 100,
                  width: widthO * 0.29,
                  child:
                      Image(width: 70, height: 70, image: AssetImage(icon1))),
              Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  height: 100,
                  width: widthO * 0.29,
                  child:
                      Image(width: 70, height: 70, image: AssetImage(icon2))),
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(10))),
                  height: 100,
                  width: widthO * 0.29,
                  child:
                      Image(width: 70, height: 70, image: AssetImage(icon3))),
            ],
          ),
        ],
      ),
    );
  }
}
