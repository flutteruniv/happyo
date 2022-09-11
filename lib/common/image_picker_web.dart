import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

Future<Image?> pickImage() async {
  return await ImagePickerWeb.getImageAsWidget();
}
