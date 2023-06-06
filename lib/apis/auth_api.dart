import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_freezed/core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authApiProvider = Provider(
  (ref) {
    final account = ref.watch(appWriteAccountProvider);
    return AuthApi(account: account);
  },
);

//first step
abstract class IAuthAPI {
  FutureEither<Model> signup({
    required String email,
    required String password,
  });
  FutureEither<Session> login({
    required String email,
    required String password,
  });
  Future<User?> currentUser();
}

class AuthApi implements IAuthAPI {
  final Account _account;

  AuthApi({required Account account}) : _account = account;
  @override
  Future<User?> currentUser() async {
    try {
      return await _account.get();
    } on AppwriteException catch (_) {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  FutureEither<User> signup(
      {required String email, required String password}) async {
    try {
      final account = await _account.create(
          userId: ID.unique(), email: email, password: password);

      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? "some error", stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }

  @override
  FutureEither<Session> login(
      {required String email, required String password}) async {
    try {
      final session =
          await _account.createEmailSession(email: email, password: password);

      return right(session);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? "some error", stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }
}
