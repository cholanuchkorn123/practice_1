import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_freezed/apis/storage_api.dart';
import 'package:riverpod_freezed/apis/tweet_api.dart';
import 'package:riverpod_freezed/core/enums/tweet_type_enum.dart';
import 'package:riverpod_freezed/features/auth/controller/auth_controller.dart';
import 'package:riverpod_freezed/model/tweet_model.dart';

import '../../../core/utils.dart';

final tweetControllerProvider =
    StateNotifierProvider<TweetController, bool>((ref) {
  return TweetController(
      ref: ref,
      tweetApi: ref.watch(tweetApiProvider),
      storageApi: ref.watch(storageApiProvider));
});
final getTweetsProvider = FutureProvider((ref) {
  final tweetController = ref.watch(tweetControllerProvider.notifier);
  return tweetController.getTweets();
});

class TweetController extends StateNotifier<bool> {
  final TweetApi _tweetApi;
  final StorageApi _storageApi;
  final Ref _ref;
  TweetController(
      {required Ref ref,
      required TweetApi tweetApi,
      required StorageApi storageApi})
      : _ref = ref,
        _tweetApi = tweetApi,
        _storageApi = storageApi,
        super(false);

  Future<List<Tweet>> getTweets() async {
    final tweetList = await _tweetApi.getTweets();
    return tweetList.map((e) => Tweet.fromMap(e.data)).toList();
  }

  void shareTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) {
    if (text.isEmpty) {
      showSnackbar(context, 'Please enter text');
      return;
    }

    if (images.isNotEmpty) {
      _shareImageTweet(images: images, text: text, context: context);
    } else {
      _shareTextTweet(text: text, context: context);
    }
  }

  void _shareImageTweet(
      {required List<File> images,
      required String text,
      required BuildContext context}) async {
    state = true;
    String link = _getLinkFromText(text);
    final hashtags = _getHashtagsFromText(text);
    final user = _ref.read(currentUserDetialsProvider).value!;
    final imagesUpload = await _storageApi.uploadImage(images);
    Tweet tweet = Tweet(
      text: text,
      hashtags: hashtags,
      link: link,
      imageLinks: imagesUpload,
      uid: user.uid,
      tweetType: TweetType.text,
      tweetedAt: DateTime.now(),
      likes: [],
      commentIds: [],
      id: '',
      reshareCount: 0,
    );
    final res = await _tweetApi.shareTweet(tweet);
    state = false;
    res.fold((l) => showSnackbar(context, l.message), (r) => null);
  }

  void _shareTextTweet(
      {required String text, required BuildContext context}) async {
    state = true;
    String link = _getLinkFromText(text);
    final hashtags = _getHashtagsFromText(text);
    final user = _ref.read(currentUserDetialsProvider).value!;
    Tweet tweet = Tweet(
      text: text,
      hashtags: hashtags,
      link: link,
      imageLinks: [],
      uid: user.uid,
      tweetType: TweetType.text,
      tweetedAt: DateTime.now(),
      likes: [],
      commentIds: [],
      id: '',
      reshareCount: 0,
    );
    final res = await _tweetApi.shareTweet(tweet);
    state = false;
    res.fold((l) => showSnackbar(context, l.message), (r) => null);
  }

  String _getLinkFromText(String text) {
    String link = '';
    List<String> wordsInSentence = text.split(' ');
    for (String word in wordsInSentence) {
      if (word.startsWith('https://') || word.startsWith('www.')) {
        link = word;
      }
    }
    return link;
  }

  List<String> _getHashtagsFromText(String text) {
    List<String> hashtags = [];
    List<String> wordsInSentence = text.split(' ');
    for (String word in wordsInSentence) {
      if (word.startsWith('#')) {
        hashtags.add(word);
      }
    }
    return hashtags;
  }
}
