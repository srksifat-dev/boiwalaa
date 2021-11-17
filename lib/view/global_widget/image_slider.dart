import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'assets/images/carousel-1-png.png',
  'assets/images/carousel-1.jpg',
  'assets/images/carousel-2.jpg',
  'assets/images/carousel-3.jpg',
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
//                        padding: EdgeInsets.symmetric(
//                            vertical: 10.0, horizontal: 20.0),
//                        child: Text(
//                          'No. ${imgList.indexOf(item)} image',
//                          style: TextStyle(
//                            color: Colors.blue,
//                            fontSize: 20.0,
//                            fontWeight: FontWeight.bold,
//                          ),
//                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

Widget imgSlider() {
  return CarouselSlider(
    options: CarouselOptions(
      aspectRatio: 3.5,
      autoPlay: true,
      enlargeCenterPage: true,
    ),
    items: imgList
        .map((item) => Center(
                child: Image.asset(
              item,
              fit: BoxFit.cover,
            )))
        .toList(),
  );
}

class CustomImageSlider extends StatelessWidget with PreferredSizeWidget {
  const CustomImageSlider({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imgSlider();
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(150);
}
