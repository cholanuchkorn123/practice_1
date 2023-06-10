import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_freezed/core/core.dart';
import 'package:riverpod_freezed/model/tweet_model.dart';

import '../constant/appwrite_constant.dart';

final tweetApiProvider = Provider((ref) {
  return TweetApi(db: ref.watch(appWriteDatabaseProvider));
});

abstract class ITweetApi {
  FutureEither<Document> shareTweet(Tweet tweet);
  Future<List<Document>> getTweets();
}

class TweetApi implements ITweetApi {
  final Databases _db;
  TweetApi({required Databases db}) : _db = db;

  @override
  FutureEither<Document> shareTweet(Tweet tweet) async {
    try {
      final doucument = await _db.createDocument(
          databaseId: AppwriteConstant.dataBaseId,
          collectionId: AppwriteConstant.tweetCollection,
          documentId: ID.unique(),
          data: tweet.toMap());
      return right(doucument);
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
  Future<List<Document>> getTweets() async {
    final doc = await _db.listDocuments(
        databaseId: AppwriteConstant.dataBaseId,
        collectionId: AppwriteConstant.tweetCollection);
    return doc.documents;
  }
}
