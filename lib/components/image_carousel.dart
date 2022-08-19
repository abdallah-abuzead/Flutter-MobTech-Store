import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'images/image_1.png',
  'images/image_2.png',
  'images/image_3.jpg',
  'images/image_4.jpg',
  'images/image_5.jpg',
];

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({Key? key}) : super(key: key);

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  // Image.network(item, fit: BoxFit.cover, width: 1000.0),
                  Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: const [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      // child: Text(
                      //   'No. ${imgList.indexOf(item)} image',
                      //   style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              height: 250,
              viewportFraction: 1,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
