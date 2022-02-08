import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSliderComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
          margin: const EdgeInsets.only(top: 12),
          height: 210,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(
                height: 190,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Row(
                    children: <Widget>[
                      Container(
                        width: 12,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
