import 'dart:io';

import 'package:flutter/material.dart';
import 'package:happyo/common/logger.dart';
import 'package:image_picker/image_picker.dart';

Future<Image?> pickImage() async {
  logger.debug('pick image for mobile');
  final ImagePicker picker = ImagePicker();
  logger.debug('create ImagePicker instance');
  final image = await picker.pickImage(source: ImageSource.gallery);
  if (image == null) return null;
  return Image.file(File(image.path));
}
