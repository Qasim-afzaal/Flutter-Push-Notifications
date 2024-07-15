import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

class DashBoardImageCarousel extends StatefulWidget
    with WatchItStatefulWidgetMixin {
  final List<String> images; // Add a parameter for the list of images

  DashBoardImageCarousel({
    required this.images,
    Key? key,
  }) : super(key: key);

  @override
  _DashBoardImageCarouselState createState() => _DashBoardImageCarouselState();
}

class _DashBoardImageCarouselState extends State<DashBoardImageCarousel> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            height: 90,
            aspectRatio: 16 / 9,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            autoPlay: false,
            autoPlayInterval: const Duration(seconds: 3),
            onPageChanged: onPageChanged,
            enableInfiniteScroll: false,
          ),
          items: widget.images.map((item) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Opacity(
                  opacity: currentIndex == 0 ? 0.9 : 0.9,
                  child: Image.network(item, fit: BoxFit.cover, errorBuilder:
                      (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                    // You can customize the error placeholder or return a default image here
                    return const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 10,
                    );
                  }),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        Positioned(
          bottom: 15,
          left: 0,
          right: 0,
          child: _buildPageIndicator(widget.images.length),
        ),
      ],
    );
  }

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget _buildPageIndicator(int itemCount) {
    final ThemeData theme = Theme.of(context);

    return widget.images.length == 1
        ? SizedBox()
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              itemCount,
              (index) => Container(
                width: 5.0,
                height: 5.0,
                margin: const EdgeInsets.symmetric(horizontal: 1.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentIndex == index
                      ? theme.colorScheme.surface
                      : Colors.grey,
                ),
              ),
            ),
          );
  }
}
