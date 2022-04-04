// import 'package:flutter/material.dart';
//
// class CarouselSliderWithZoomImage extends StatefulWidget {
//   const CarouselSliderWithZoomImage({Key? key}) : super(key: key);
//
//   @override
//   State<CarouselSliderWithZoomImage> createState() => _CarouselSliderWithZoomImageState();
// }
//
// class _CarouselSliderWithZoomImageState extends State<CarouselSliderWithZoomImage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//
//       child: CarouselImageSlider.builder(
//         key: ValueKey(1),
//         itemCount: controller.attachmentList.length,
//         itemBuilder: (BuildContext context, int itemIndex, int _) {
//
//           if(controller.attachmentList[itemIndex] == null){
//             return Container(
//               padding: EdgeInsets.only(left: 24, right: 24),
//               alignment: Alignment.center,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   RotatedBox(quarterTurns: 2,
//                       child: Icon(Icons.downloading, color: Colors.white, size: 46)),
//                   SizedBox(height: 10),
//                   text("Uploading...",
//                       style: TextStyle(fontSize: 14,color: white),align: TextAlign.center),
//                 ],
//               ),
//             );
//           }
//
//           bool isDocument = controller.attachmentList[itemIndex].toString().isDoc ||
//               controller.attachmentList[itemIndex].toString().isExcel ||
//               controller.attachmentList[itemIndex].toString().isPdf ||
//               controller.attachmentList[itemIndex].toString().isPPT ||
//               controller.attachmentList[itemIndex].toString().isTxt ||
//               p.extension(controller.attachmentList[itemIndex].toString()) == '.csv';
//
//           return controller.isLoading ? Center(child: CircularProgressIndicator(color: green)) : Container(
//               child: isDocument ? Container(
//                 padding: EdgeInsets.only(left: 24, right: 24),
//                 alignment: Alignment.center,
//                 child: documentWidget(context,controller.attachmentList[itemIndex].toString()),
//               ) :
//               //HANDLE IMAGE OR VIDEO
//               !isVideo(controller.attachmentList[itemIndex].toString()) ?
//               controller.attachmentList[itemIndex].toString().contains('http') ?
//               InteractiveViewer.builder(
//                 maxScale: 2.5,
//                 minScale: 1.0,
//                 scaleEnabled: true,
//                 panEnabled: true,
//                 builder: (context, viewPort) {
//                   return Listener(
//                     onPointerDown: (PointerDownEvent event) => controller.onScreenPointer++,
//                     onPointerUp: (PointerUpEvent event) => controller.onScreenPointer--,
//                     child: GestureDetector(
//                       onTap: () {
//                         controller.barVisible = !controller.barVisible;
//                         controller.update();
//                       },
//                       onScaleStart: (ScaleStartDetails details) {
//                         controller.imageTapOffset = details.focalPoint;
//                         controller.initialImageScale = controller.imageScale;
//                       },
//                       onScaleUpdate: (ScaleUpdateDetails details) {
//                         //if (controller.imageScale == 1.0) {
//                         if (controller.onScreenPointer > 1) {
//                           if ((details.scale * controller.initialImageScale) >= 2.5) {
//                             controller.imageScale = 2.5;
//                           } else if ((details.scale * controller.initialImageScale) <= 1.0) {
//                             controller.imageScale = 1.0;
//                             controller.offset = Offset.zero;
//                           } else {
//                             controller.imageScale = details.scale * controller.initialImageScale;
//                           }
//                         }
//
//                         controller.update();
//
//                         //ADD CONSTRAINT TO THE HEIGHT AND WIDTH OF THE SCREEN
//                         if (viewPort.point0.x > 0.0 || viewPort.point1.x < Get.width ||
//                             viewPort.point0.y > 0.0 || viewPort.point1.y < controller.scaleImageHeight!) {
//                           controller.imageDelta = details.focalPoint - controller.imageTapOffset;
//                         }
//
//                         if ((viewPort.point0.x > 0.0 || viewPort.point1.x < Get.width) && controller.imageScale != 1.0) {
//                           controller.carouselScrollable.value = false;
//                           controller.update();
//                         } else {
//                           controller.carouselScrollable.value = true;
//                           controller.update();
//                         }
//                       },
//                       onScaleEnd: (ScaleEndDetails details) {
//                         controller.offset += controller.imageDelta;
//                         controller.imageDelta = Offset.zero;
//                         controller.update();
//                       },
//                       child: Transform
//                           .scale(scale: controller.imageScale,child: Image(image: CachedNetworkImageProvider(controller.attachmentList[itemIndex].toString()), fit: BoxFit.cover, width: Get.width).onTap((){
//                         controller.barVisible = !controller.barVisible;
//                         controller.update();
//                       })
//                           .translate(offset: controller.offset + controller.imageDelta),
//                       ),
//                     ),
//                   );
//                 },
//               ) : InteractiveViewer.builder(
//                   minScale: 1.0,
//                   maxScale: 2.5,
//                   scaleEnabled: true,
//                   panEnabled: true,
//                   builder: (context, viewPort) {
//                     //top left - 0, top right - 1, bottom right - 2, bottom left - 3
//
//                     return Listener(
//                       onPointerDown: (PointerDownEvent event) => controller.onScreenPointer++,
//                       onPointerUp: (PointerUpEvent event) => controller.onScreenPointer--,
//                       child: GestureDetector(
//                         onTap: () {
//                           controller.barVisible = !controller.barVisible;
//                           controller.update();
//                         },
//                         onScaleStart: (ScaleStartDetails details) {
//                           controller.imageTapOffset = details.focalPoint;
//                           controller.initialImageScale = controller.imageScale;
//                         },
//                         onScaleUpdate: (ScaleUpdateDetails details) {
//
//                           //if (controller.imageScale == 1.0) {
//                           if (controller.onScreenPointer > 1) {
//                             if ((details.scale * controller.initialImageScale) >= 2.5) {
//                               controller.imageScale = 2.5;
//                             } else if ((details.scale * controller.initialImageScale) <= 1.0) {
//                               controller.imageScale = 1.0;
//                               controller.offset = Offset.zero;
//                               controller.imageDelta = Offset.zero;
//                             } else {
//                               controller.imageScale = details.scale * controller.initialImageScale;
//                             }
//                           }
//
//                           controller.update();
//
//                           //ADD CONSTRAINT TO THE HEIGHT AND WIDTH OF THE SCREEN
//                           if (viewPort.point0.x > 0.0 || viewPort.point1.x < Get.width ||
//                               viewPort.point0.y > 0.0 || viewPort.point1.y < controller.scaleImageHeight!) {
//                             controller.imageDelta = details.focalPoint - controller.imageTapOffset;
//                           }
//
//                           if ((viewPort.point0.x > 0.0 || viewPort.point1.x < Get.width) && controller.imageScale != 1.0) {
//                             controller.carouselScrollable.value = false;
//                             controller.update();
//                           } else {
//                             controller.carouselScrollable.value = true;
//                             controller.update();
//                           }
//                         },
//                         onScaleEnd: (ScaleEndDetails details) {
//                           controller.offset += controller.imageDelta;
//                           controller.imageDelta = Offset.zero;
//                           controller.update();
//                         },
//                         child: Transform
//                             .scale(scale: controller.imageScale, child: Image.file(File(controller.attachmentList[itemIndex]), fit: BoxFit.cover, width: Get.width))
//                             .translate(offset: controller.offset + controller.imageDelta,
//                         ),
//                       ),
//                     );
//                   }
//               ) : videoPlayer(context, itemIndex)
//           );
//         },
//         options: CarouselOptions(
//           viewportFraction: 1,
//           autoPlay: false,
//           enableInfiniteScroll: false,
//           enlargeCenterPage: false,
//           initialPage: controller.currentIndex,
//           onPageChanged: (index, _) {
//             controller.onChangedPage(index);
//             controller.initialImageScale = 1.0;
//             controller.imageScale = 1.0;
//             controller.imageDelta = Offset.zero;
//             controller.offset = Offset.zero;
//             controller.update();
//           },
//           height: controller.scaleImageHeight! * controller.imageScale,
//           scrollPhysics: controller.carouselScrollable.value ? null : const NeverScrollableScrollPhysics(),
//         ),
//       ),
//     ),;
//   }
// }
