import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:photo_view/photo_view.dart';

typedef PageChanged = void Function(int index);

class PhotoPreview extends StatefulWidget {
  final List galleryItems; //图片列表
  final int defaultImage; //默认第几张
  final PageChanged? pageChanged; //切换图片回调
  final Axis direction; //图片查看方向
  final Decoration? decoration;//背景设计

  PhotoPreview(
      { required this.galleryItems,
        this.defaultImage = 0,
        this.pageChanged,
        this.direction = Axis.horizontal,
        this.decoration
      });

  @override
  _PhotoPreviewState createState() => _PhotoPreviewState();
}

class _PhotoPreviewState extends State<PhotoPreview> {

  // late int tempSelect;
  // @override
  // void initState() {
  //   super.initState();
  //   tempSelect = widget.defaultImage+1;
  // }

  late int currentIndex = widget.defaultImage;

  void onPageChanged(int index) {

    setState(() {
      currentIndex = index;
    });
    if(widget.pageChanged != null){
      widget.pageChanged!(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          GestureDetector(
            onTap: ()=> Navigator.of(context).pop(),
            child: Container(
                child: PhotoViewGallery.builder(
                    scrollPhysics: const BouncingScrollPhysics(),
                    builder: (BuildContext context, int index) {

                      return PhotoViewGalleryPageOptions(
                        initialScale: PhotoViewComputedScale.contained * 1.0,
                        imageProvider: NetworkImage(widget.galleryItems[index]),
                        minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
                        maxScale: PhotoViewComputedScale.covered * 4.1,
                        heroAttributes: PhotoViewHeroAttributes(tag: widget.galleryItems[index]),

                      );
                      },
                    loadingBuilder:(context,event){
                      return Center(
                        child: Container(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(
                            value: event == null
                                ? 0
                                : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                          ),
                        ),
                      );
                    },
                    scrollDirection: widget.direction,
                    itemCount: widget.galleryItems.length,
                    backgroundDecoration:  BoxDecoration(color: Colors.black),
                    pageController: PageController(initialPage: widget.defaultImage),
                    onPageChanged: onPageChanged,
                )
            ),
          ),
          Positioned(///布局自己换
            right: 20,
            top: 20,
            child: Text('${currentIndex + 1}/${widget.galleryItems.length}',style: TextStyle(color:Colors.white),),
          ),

          Container(
            padding: EdgeInsets.all(20.0),
            child: Text("Image ${currentIndex + 1}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17.0,
                decoration: null,
              )),
          )
        ],
      ),
    );
  }
}