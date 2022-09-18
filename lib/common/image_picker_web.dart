import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker_web/image_picker_web.dart';

Future<File?> pickImage() async {
  final Uint8List? uint8list = await ImagePickerWeb.getImageAsBytes();
  if (uint8list == null) return null;
  return File.fromRawPath(uint8list);
}
