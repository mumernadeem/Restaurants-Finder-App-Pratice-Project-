import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:restaurants_finder_app/apputils.dart';
import 'package:restaurants_finder_app/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CatalogueScreen extends StatefulWidget {
  const CatalogueScreen({Key? key}) : super(key: key);

  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  var images = [
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
  ];
  var text1 = [
    'Let\'s Get Started',
    'Let\'s Get Started',
    'Let\'s Get Started',
  ];
  var text2 = [
    'Join Us Now And Enjoy Free Services',
    'Join Us Now And Enjoy Free Services',
    'Join Us Now And Enjoy Free Services',
  ];
  var text3 = [
    'Instantly',
    'Instantly',
    'Instantly',
  ];
  int activeIndex = 0;
  var utils = AppUtils();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.15,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.46,
                    width: constraints.maxWidth,
                    child: Column(
                      children: [
                        CarouselSlider.builder(
                          itemCount: images.length,
                          options: CarouselOptions(
                              height: constraints.maxHeight * 0.4,
                              viewportFraction: 0.9,
                              aspectRatio: 2.0,
                              enableInfiniteScroll: false,
                              onPageChanged: (index, reason) =>
                                  setState(() => activeIndex = index)),
                          itemBuilder: (context, itemIndex, realIndex) {
                            final image = images[itemIndex];
                            final t1 = text1[itemIndex];
                            final t2 = text2[itemIndex];
                            final t3 = text3[itemIndex];
                            return buildImages(
                                constraints.maxWidth,
                                constraints.maxHeight,
                                image,
                                itemIndex,
                                t1,
                                t2,
                                t3);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AnimatedSmoothIndicator(
                          activeIndex: activeIndex,
                          count: images.length,
                          effect: const ExpandingDotsEffect(
                            dotWidth: 6,
                            dotColor: Colors.grey,
                            activeDotColor: Colors.orangeAccent,
                            dotHeight: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  utils.button(
                    text: 'Let\'s Get Started',
                    width: constraints.maxWidth * 0.75,
                    buttonColor: Colors.orangeAccent,
                    textColor: Colors.white,
                    height: 55.0,
                    borderRadius: BorderRadius.circular(30.0),
                    onTap: () {
                      Navigator.pushNamed(context, homeScreen);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildImages(
    double width,
    double height,
    String images,
    int index,
    String t1,
    String t2,
    String t3,
  ) =>
      Column(
        children: [
          Image.asset(
            images,
            width: width * 0.8,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            t1,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            t2,
            style: utils.mediumTitleStyle(),
          ),
          Text(
            t3,
            style: utils.mediumTitleStyle(),
          ),
        ],
      );
}
