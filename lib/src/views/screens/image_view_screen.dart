
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pido/src/utils/app_shared.dart';
import 'package:pido/src/views/components/custom_back_button.dart';
import 'package:pido/src/views/components/image_placeholder_component.dart';


class ImagePreviewScreen extends StatefulWidget {
  final List<String> imgs;

  const ImagePreviewScreen({Key? key,
  required this.imgs}) : super(key: key);

  @override
  _ImagePreviewScreenState createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  int _current = 0;
  PhotoView getImage(){
    return  PhotoView(
      imageProvider: CachedNetworkImageProvider(widget.imgs[_current],

      ),
      //   minScale: PhotoViewComputedScale.contained * 0.8,
      //   maxScale: PhotoViewComputedScale.covered * 2,
      backgroundDecoration: BoxDecoration(
        color: Colors.transparent,

      ),



    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar:AppBar(
  elevation: 0,
  centerTitle: true,
  title: Text(
    'ImageGallery'.tr(),
    style: TextStyle(
        fontSize: 24.sp,),
  ),
  leadingWidth: 30.w,
  leading: CustomBackButton(),

),

      body:
      Container(
         height:MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          PhotoView(
            key: ValueKey(widget.imgs[_current]),
            imageProvider: CachedNetworkImageProvider(widget.imgs[_current],



            ),
            loadingBuilder: (ctx,_)=>Center(child: Container(
              height: 100,
                child: ImagePlaceholderComponent())),
            //   minScale: PhotoViewComputedScale.contained * 0.8,
            //   maxScale: PhotoViewComputedScale.covered * 2,
            backgroundDecoration: BoxDecoration(
              color: Colors.transparent,

            ),



          ),
//           CarouselSlider(
//
//             options: CarouselOptions(
//            //   scrollPhysics: NeverScrollableScrollPhysics(),
// height: double.infinity,
//                 viewportFraction: 1,
//                 onPageChanged: (index, reason) {
//                   setState(() {
//                     _current = index;
//                   });
//                 }),
//             items:widget.imgs.map((i) {
//               return Stack(
//                 children: [
//                   Builder(
//                     builder: (BuildContext context) {
//                       return Container(
//                           width: MediaQuery.of(context).size.width,
//
//
//                           height:MediaQuery.of(context).size.height,
//
//                           child: PhotoView(
//                              imageProvider: CachedNetworkImageProvider(i,
//
//                              ),
//                      //   minScale: PhotoViewComputedScale.contained * 0.8,
//                      //   maxScale: PhotoViewComputedScale.covered * 2,
//                             backgroundDecoration: BoxDecoration(
//                               color: Colors.transparent,
//
//                             ),
//
//
//
//                           ));
//                     },
//                   ),
//                 ],
//               );
//             }).toList(),
//           ),
          Positioned.fill(
            top: 40,

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Container(
                        child:_current==0?Container(): GestureDetector(
                          onTap: (){
                            _current--;
                            setState(() {

                            });
                           // Navigator.of(context).pop();
                          },
                          child: Container(
                            padding:const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(),
                            // shape: BoxShape.circle
                            ),
                            child:Center(child: Icon(Icons.arrow_back_ios))
                          ),
                        ),
                      ),
                    ],
                  ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: _current==widget.imgs.length-1?
                              Container()
                              :
                          GestureDetector(
                            onTap: (){
                              _current++;
                              setState(() {

                              });
                              // Navigator.of(context).pop();
                            },
                            child: Container(
                              alignment: AlignmentDirectional.centerEnd,
                                padding:const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(),

                                   // shape: BoxShape.circle
                                ),
                                child:Center(child: Icon(Icons.arrow_forward_ios))
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: AppShared.screenUtil.setHeight(10),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.imgs.asMap().entries.map((entry) {
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
          // Positioned.fill(
          //   top: 220,
          //   child:
          // ),
        ]),
      ),
    );
  }
}
