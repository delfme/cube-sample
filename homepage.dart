import 'package:flutter/material.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'cube_page_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final url ='https://loremflickr.com/100/100/music?lock=1';
    return Scaffold(
      backgroundColor: Colors.black,
      body: Material(
        type: MaterialType.transparency,
        color: Colors.cyan,
        child: CubePageView.builder(
          itemCount: 4,
          itemBuilder: (context, index, notifier) {
            return CubeWidget(
              index: index,
              pageNotifier: notifier,
              transformStyle: CubeTransformStyle.outside,
              child: Column(
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

                      /*
                      // 1. Using CachedNetworkImage
                      child: CachedNetworkImage(
                        imageUrl: url1,
                        height: 30,
                        width: 30,
                      ),
                       */

                      // 2. Using FastCachedImage
                      child: FastCachedImage(
                        url: url,
                        height: 30,
                        width: 30,
                      ),

                      /*
                      // 3. Using Image.network
                      child:Image.network(
                        url1,
                        height: 30,
                        width: 30,
                      ),
                      */

                    ),
                    SizedBox(width: 50),
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
                      child: SizedBox()
                    ),
              ],),]),
            );
          },
        ),
      ),
    );
  }

}
