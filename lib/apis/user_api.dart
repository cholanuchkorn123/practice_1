import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_freezed/constant/constant.dart';
import 'package:riverpod_freezed/core/core.dart';
import 'package:riverpod_freezed/model/user_model.dart';

abstract class IUserApi {
  FutureEitherVoid saveUserData(UserModel userModel);
  Future<Document> getUserData(String uid);
}

final userApiProvider = Provider((ref) {
  return UserApi(db: ref.watch(appWriteDatabaseProvider));
});

class UserApi implements IUserApi {
  final Databases _db;

  UserApi({required Databases db}) : _db = db;
  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
          databaseId: AppwriteConstant.dataBaseId,
          collectionId: AppwriteConstant.usersCollection,
          documentId: userModel.uid,
          data: userModel.toMap());
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(e.message ?? "some error", st),
      );
    } catch (e, st) {
      return left(
        Failure(e.toString(), st),
      );
    }
  }

  @override
  Future<Document> getUserData(String uid) {
    print('this is uid $uid');
    return _db.getDocument(
        databaseId: AppwriteConstant.dataBaseId,
        collectionId: AppwriteConstant.usersCollection,
        documentId: uid);
  }
}
