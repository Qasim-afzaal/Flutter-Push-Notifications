import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDashBoardWidget extends StatelessWidget {
  const ShimmerDashBoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            3,
            (index) => SizedBox(
              width: 250,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 16.0,
                          height: 16.0,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            border: Border.all(
                              color: theme.colorScheme.inverseSurface,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipOval(
                            child: Container(
                              width: 15,
                              height: 16,
                              color: Colors.grey[200],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Container(
                          width: 80,
                          height: 16,
                          color: Colors.grey[200],
                        ),
                      ],
                    ),
                    const SizedBox(height: 9),
                    Container(
                      width: double.infinity,
                      height: 140,
                      color: Colors.grey[200],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 16,
                      color: Colors.grey[200],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          width: 16,
                          height: 16,
                          color: Colors.grey[200],
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 3),
                          width: 30,
                          height: 16,
                          color: Colors.grey[200],
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 3),
                          width: 16,
                          height: 16,
                          color: Colors.grey[200],
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 3),
                          width: 30,
                          height: 16,
                          color: Colors.grey[200],
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 3),
                          width: 16,
                          height: 16,
                          color: Colors.grey[200],
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 3),
                          width: 30,
                          height: 16,
                          color: Colors.grey[200],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: double.infinity,
                      height: 16,
                      color: Colors.grey[200],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/listing/thumb_up.png",
                          scale: 2.7,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Visited & Liked",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.inverseSurface,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
