import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_freezed/common/common.dart';
import 'package:riverpod_freezed/features/tweet/controller/tweet_controller.dart';
import 'package:riverpod_freezed/model/tweet_model.dart';

class TweetList extends ConsumerWidget {
  const TweetList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getTweetsProvider).when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) {
            Tweet item = data[index];
            return Text(item.text);
          });
        },
        error: (e, st) {
          return ErrorPage(errorText: e.toString());
        },
        loading: () => const Loader());
  }
}
