import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_freezed/constant/appwrite_constant.dart';
import 'package:riverpod_freezed/core/core.dart';

final storageApiProvider = Provider((ref) {
  return StorageApi(storage: ref.watch(appWriteStorageProvider));
});

class StorageApi {
  final Storage _storage;
  StorageApi({required Storage storage}) : _storage = storage;

  Future<List<String>> uploadImage(List<File> files) async {
    List<String> imagesLinks = [];
    for (final image in files) {
      final uploadedImage = await _storage.createFile(
          bucketId: AppwriteConstant.imagesBucket,
          fileId: ID.unique(),
          file: InputFile.fromPath(path: image.path));
      imagesLinks.add(AppwriteConstant.imageUrl(uploadedImage.$id));
    }
    return imagesLinks;
  }
}
