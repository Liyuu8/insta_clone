import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

class CirclePhoto extends StatelessWidget {
  final String photoUrl;
  final double radius;
  final bool isImageFromFile;
  CirclePhoto({
    @required this.photoUrl,
    this.radius,
    @required this.isImageFromFile,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: isImageFromFile
          ? FileImage(File(photoUrl))
          : AdvancedNetworkImage(
              photoUrl,
              useDiskCache: true,
              fallbackAssetImage: 'assets/images/no_image.png',
            ),
    );
  }
}