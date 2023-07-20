import 'package:flutter/material.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';


class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {

  @override
  Widget build(BuildContext context) {
    final url ='https://loremflickr.com/100/100/music?lock=1';
    return Scaffold(
        backgroundColor: Colors.black,
        body:  CarouselSlider(
          slideTransform: CubeTransform(),
          slideIndicator: CircularSlideIndicator(
            padding: EdgeInsets.only(bottom: 50),
            currentIndicatorColor: Colors.white,
          ),
          unlimitedMode: true,
          children: [
            Container(
              color: Colors.cyan,
              child:Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height:50),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width:20),
                        Container(
                          alignment: AlignmentDirectional.center,
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.4),
                            border: Border.all(
                              color: Colors.white,
                              width: 0.5,
                            ),
                          ),
                          child: FastCachedImage(
                            url: url,
                            height: 30,
                            width: 30,
                          ),
                          /*
                          child: Image.network(
                            url1,
                            height: 30,
                            width: 30,
                          ),
                          */
                        ),
                        SizedBox(width: 30),
                        Container(
                          alignment: AlignmentDirectional.center,
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.4),
                            border: Border.all(
                              color: Colors.white,
                              width: 0.5,
                            ),
                          ),
                        ),
                        SizedBox(height:50),
                      ],),
                    SizedBox(height:50),
                  ]),
            ),
            Container(
              width: 40,
              height: 40,
              child: Image.network(
                url,
              ),
            ),
          ],
        ),
    );
  }

}
