import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starwarswiki/app/utils/image_generator.dart';

class CachedImageWidget extends StatelessWidget {
  final int? id;
  final String? type;
  final String? url;

  const CachedImageWidget({Key? key, this.url, this.id, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
        url != null ? url! : ImageGenerator.generateImage(id: id!, type: type!),
        cache: true,
        printError: false, loadStateChanged: (ExtendedImageState state) {
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          return Center(child: CircularProgressIndicator.adaptive());
        case LoadState.completed:
          return ExtendedRawImage(
            image: state.extendedImageInfo?.image,
            fit: BoxFit.cover,
          );
        case LoadState.failed:
          return GestureDetector(
            child: Center(
              child: Opacity(
                opacity: 0.4,
                child: Icon(CupertinoIcons.arrow_clockwise),
              ),
            ),
            onTap: () {
              state.reLoadImage();
            },
          );
      }
    });
  }
}
