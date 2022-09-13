import 'dart:io';
import 'package:happyo/common/logger.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  logger.debug('pick image for mobile');
  final ImagePicker picker = ImagePicker();
  logger.debug('create ImagePicker instance');
  final image = await picker.pickImage(source: ImageSource.gallery);
  if (image == null) return null;
  return File(image.path);
}
