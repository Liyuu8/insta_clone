import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';

class ImageFromUrl extends StatelessWidget {
  final String imageUrl;
  ImageFromUrl({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return imageUrl == null
        ? const Icon(Icons.broken_image)
        : TransitionToImage(
            image: AdvancedNetworkImage(imageUrl, useDiskCache: true),
            placeholder: const Icon(Icons.broken_image),
            fit: BoxFit.cover,
          );
  }
}
