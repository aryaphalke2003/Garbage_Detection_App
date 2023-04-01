import 'package:ecotags/const/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Picture {
  final String image;
  final String name;
  Picture(this.image, this.name);
}

class PictureGallery extends StatefulWidget {
  final List<Picture> pictures;
  const PictureGallery({super.key, required this.pictures});

  @override
  State<PictureGallery> createState() => _PictureGalleryState();
}

class _PictureGalleryState extends State<PictureGallery> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        padding: const EdgeInsets.only(top: 3),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          crossAxisCount: 3,
        ),
        itemCount: widget.pictures.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: appColor, width: 3),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.pictures[index].image),
              ),
            ),
          );
        },
      ),
    );
  }
}
