import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;
import 'package:image_picker/image_picker.dart';

@immutable
class ImagePickerHelper {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<File?> pickImageFromGallery() async {
    log('pick');
    final res =
        await _imagePicker.pickImage(source: ImageSource.gallery).toFile();

    if (res == null) {
      log('null');
    } else {
      log(res.path);
    }
    return res;
  }

  static Future<File?> pickVideoFromGallery() =>
      _imagePicker.pickVideo(source: ImageSource.gallery).toFile();
}

extension ToFile on Future<XFile?> {
  Future<File?> toFile() => then((xFile) => xFile?.path)
      .then((filePath) => filePath != null ? File(filePath) : null);
}
