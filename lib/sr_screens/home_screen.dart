import 'package:ato/components/widgets.dart';
import 'package:ato/components/styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String title = "Home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> images = [
    "assets/images/home_bg.jpg",
    "assets/images/home_bg.jpg",
    "assets/images/home_bg.jpg",
    "assets/images/home_bg.jpg",
  ];
  List<String> texts = [
    "Donate today to our winter campaigns to help people in need of shelter and support during the cold winter. Contribute warmth and safety to those facing difficulties during this difficult period.",
    "Help people in need of shelter and support during the cold winter. Contribute warmth and safety to those facing difficulties during this difficult period.",
    "Support during the cold winter. Contribute warmth and safety to those facing difficulties during this difficult period.",
    "Donate to help people in need of shelter and support during the cold winter. Contribute warmth and safety to those facing difficulties during this difficult period.",
  ];
  List<IconData> icons = [
    Icons.person_outline_rounded,
    Icons.person_outline_rounded,
    Icons.person_outline_rounded,
    Icons.person_outline_rounded,
  ];
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    setAsFullScreen(isFullScreen: false);
    return atoScaffold(
      context: context,
      showBackButton: false,
      showAppBarBackground: false,
      showBottomBar: true,
      title: HomeScreen.title,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            shrinkWrap: false,
            scrollDirection: Axis.vertical,
            children: [
              Center(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: false,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                  items: images.map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(
                                20.0), // Adjust the radius as needed
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20.0),
              _buildPagination(images.length),
              const SizedBox(height: 20.0),
              Center(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  width: 400,
                  height: 160,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      color: Colors.grey.shade300,
                      padding: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                              alignment: AlignmentDirectional.topCenter,
                              margin: const EdgeInsetsDirectional.only(top: 8),
                              child: Icon(
                                icons[_currentPage],
                                color: Colors.black87,
                                size: 48,
                              )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 128,
                            child: Text(
                              texts[_currentPage],
                              style: const TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPagination(int itemCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return Container(
          width: 10.0,
          height: 10.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? Colors.blue : Colors.grey,
          ),
        );
      }),
    );
  }
}
