import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pido/src/utils/app_shared.dart';
import 'package:pido/src/views/components/image_placeholder_component.dart';
import 'package:pido/src/views/screens/image_view_screen.dart';

class ImageSliderComponent extends StatefulWidget {

  final List<String?>items;
  const ImageSliderComponent({Key? key,required this.items}) : super(key: key);

  @override
  _ImageSliderComponentState createState() => _ImageSliderComponentState();
}

class _ImageSliderComponentState extends State<ImageSliderComponent> {
  @override
  int _current = 0;

  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).
        push(MaterialPageRoute(builder: (context)=>
            ImagePreviewScreen(
              imgs: widget.items.map((e) => e!).toList(),
            )));
      },
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            items: widget.items.map((i) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    // margin:
                    //     EdgeInsets.symmetric(horizontal: 5.0),
                    height: double.infinity,
                    decoration: BoxDecoration(),
                    child:CachedNetworkImage(
                      imageUrl:i??'',
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>ImagePlaceholderComponent(),
                    )),
              );

            }).toList(),
          ),
          Positioned(
              bottom: AppShared.screenUtil.setHeight(10),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.items.asMap().entries.map((entry) {
                      return GestureDetector(
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == entry.key
                                  ? Theme.of(context).primaryColor
                                  : Colors.white),
                        ),
                      );
                    }).toList(),
                  ))),
        ],
      ),
    );
  }
}
