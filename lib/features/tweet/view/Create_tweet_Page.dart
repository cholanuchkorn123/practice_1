import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riverpod_freezed/common/common.dart';
import 'package:riverpod_freezed/core/core.dart';

import 'package:riverpod_freezed/features/auth/controller/auth_controller.dart';
import 'package:riverpod_freezed/features/tweet/controller/tweet_controller.dart';

import '../../../constant/assets_constant.dart';
import '../../../theme/pallete.dart';

class CreateTweetPage extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const CreateTweetPage());
  const CreateTweetPage({super.key});

  @override
  ConsumerState<CreateTweetPage> createState() => _CreateTweetPageState();
}

class _CreateTweetPageState extends ConsumerState<CreateTweetPage> {
  final tweetTextController = TextEditingController();
  List<File> image = [];
  @override
  void dispose() {
    tweetTextController.dispose();
    super.dispose();
  }

  void onImage() async {
    image = await pickImages();
    setState(() {});
  }

  void shareTweet() {
    ref.read(tweetControllerProvider.notifier).shareTweet(
          images: image,
          text: tweetTextController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetialsProvider).value;
    final isLoading = ref.watch(tweetControllerProvider);
    return isLoading || currentUser == null
        ? const Loader()
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(currentUser.profilePic),
                            radius: 30,
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: TextField(
                              controller: tweetTextController,
                              style: const TextStyle(
                                fontSize: 22,
                              ),
                              decoration: const InputDecoration(
                                hintText: "What's happening?",
                                hintStyle: TextStyle(
                                  color: Pallete.greyColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                                border: InputBorder.none,
                              ),
                              maxLines: null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (image.isNotEmpty)
                      CarouselSlider(
                        items: image.map(
                          (file) {
                            return Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: Image.file(file),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          height: 300,
                          enableInfiniteScroll: false,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(top: 12, left: 12),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close, size: 30),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, right: 12),
                  child: Roundsmallbutton(
                    ontap: shareTweet,
                    buttonText: 'Tweet',
                    backgroundColor: Pallete.blueColor,
                    fontColor: Pallete.whiteColor,
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Pallete.greyColor,
                    width: 0.3,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(
                      left: 15,
                      right: 15,
                    ),
                    child: GestureDetector(
                      onTap: onImage,
                      child: SvgPicture.asset(AssetsConstants.galleryIcon),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(
                      left: 15,
                      right: 15,
                    ),
                    child: SvgPicture.asset(AssetsConstants.gifIcon),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(
                      left: 15,
                      right: 15,
                    ),
                    child: SvgPicture.asset(AssetsConstants.emojiIcon),
                  ),
                ],
              ),
            ),
          );
  }
}
