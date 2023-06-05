import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_freezed/features/auth/view/Register_Page.dart';
import 'package:riverpod_freezed/theme/pallete.dart';
import 'package:riverpod_freezed/common/common.dart';
import 'package:riverpod_freezed/constant/constant.dart';
import '../controller/auth_controller.dart';
import '../widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final appBar = UIconstant.appbar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    ref.read(authControllerProvider.notifier).login(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appBar,
      body: isLoading
          ? const Loader()
          : Center(
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthField(
                      controller: emailController,
                      hintText: 'Email',
                    ),
                    sizeBox24,
                    AuthField(
                      controller: passwordController,
                      isPassworfield: true,
                      hintText: 'Password',
                    ),
                    sizeBox24,
                    Align(
                      alignment: Alignment.centerRight,
                      child: Roundsmallbutton(
                          buttonText: 'Done',
                          ontap: () {
                            login();
                            FocusScope.of(context).unfocus();
                          }),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    RichText(
                        text: TextSpan(
                            style: GoogleFonts.inter(fontSize: 16),
                            text: "Dont't have any account",
                            children: [
                          const WidgetSpan(
                              alignment: PlaceholderAlignment.baseline,
                              baseline: TextBaseline.alphabetic,
                              child: SizedBox(width: 10)),
                          TextSpan(
                              text: 'Sign up',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(context, RegisterPage.route());
                                },
                              style:
                                  GoogleFonts.inter(color: Pallete.blueColor)),
                        ]))
                  ],
                ),
              )),
            ),
    );
  }
}

const sizeBox24 = SizedBox(
  height: 24,
);
