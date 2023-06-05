

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_freezed/common/common.dart';

import '../../../theme/pallete.dart';

class CreateTweetPage extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const CreateTweetPage());
  const CreateTweetPage({super.key});

  @override
  ConsumerState<CreateTweetPage> createState() => _CreateTweetPageState();
}

class _CreateTweetPageState extends ConsumerState<CreateTweetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close, size: 30),
        ),
        actions: [
          Roundsmallbutton(
            ontap: () {},
            buttonText: 'Tweet',
            backgroundColor: Pallete.blueColor,
            fontColor: Pallete.whiteColor,
          ),
        ],
      ),
    );
  }
}
