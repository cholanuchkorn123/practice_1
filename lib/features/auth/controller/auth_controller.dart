
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_freezed/apis/auth_api.dart';
import 'package:riverpod_freezed/apis/user_api.dart';
import 'package:riverpod_freezed/features/auth/view/Login_Page.dart';
import 'package:riverpod_freezed/features/home/view/Home_Page.dart';
import 'package:riverpod_freezed/model/user_model.dart';
import 'dart:core';

import '../../../core/utils.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) {
    return AuthController(
      authApi: ref.watch(authApiProvider),
      userApi: ref.watch(userApiProvider),
    );
  },
);
final currentUserDetialsProvider = FutureProvider((ref) async {
  final currentUserData = ref.watch(currentUserAccProvider).value!.$id;

  final userData = ref.watch(userDetialsProvider(currentUserData));

  return userData.value;
});
final userDetialsProvider = FutureProvider.family((ref, String uid) async {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});
final currentUserAccProvider = FutureProvider((ref) async {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthApi _authApi;
  final UserApi _userApi;
  AuthController({required AuthApi authApi, required UserApi userApi})
      : _authApi = authApi,
        _userApi = userApi,
        super(false);
  Future<User?> currentUser() => _authApi.currentUser();
  void signup(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final res = await _authApi.signup(email: email, password: password);
    state = false;

    res.fold((l) => showSnackbar(context, l.message), (r) async {
      UserModel userModel = UserModel(
          email: email,
          name: getUsername(email),
          followers:const [],
          following:const [],
          profilePic: '',
          bannerPic: '',
          uid:r.$id,
          bio: '',
          isTwitterBlue: false);
      final res2 = await _userApi.saveUserData(userModel);
      res2.fold(
        (l) {
          showSnackbar(context, l.message);
        },
        (r) {
          showSnackbar(context, "Create success,Please Login");
          Navigator.push(context, LoginPage.route());
        },
      );
    });
  }

  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final res = await _authApi.login(email: email, password: password);
    state = false;

    res.fold((l) => showSnackbar(context, l.message), (r) {
      Navigator.push(context, HomePage.route());
    });
  }

  Future<UserModel> getUserData(String uid) async {
    final document = await _userApi.getUserData(uid);
    final updateUser = UserModel.fromMap(document.data);
    return updateUser;
  }
}
//abstract class=>class implement=>provider=>controller=>state loading with bool=>