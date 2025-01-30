import 'package:event_planning/firebase_utils.dart';
import 'package:event_planning/providers/user%20provider.dart';
import 'package:event_planning/ui/auth/register/register%20screen.dart';
import 'package:event_planning/ui/home%20screen/home%20screen.dart';
import 'package:event_planning/utils/app%20colors.dart';
import 'package:event_planning/utils/app%20styles.dart';
import 'package:event_planning/utils/assets%20manager.dart';
import 'package:event_planning/widget/custom%20elevated%20button.dart';
import 'package:event_planning/widget/custom%20text%20field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../utils/alert dialog.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.04),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  AssetsManager.logo,
                  height: height * 0.25,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextField(
                    keyboard: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter email';
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if (!emailValid) {
                        return 'please enter a valid email';
                      }
                      return null;
                    },
                    prefixIcon: Image.asset(AssetsManager.emailIcon),
                    hintText: AppLocalizations.of(context)!.email),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextField(
                    keyboard: TextInputType.number,
                    controller: passwordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter your password';
                      }
                      if (text.length < 6) {
                        return 'password should be at least 6 chars';
                      }
                      return null;
                    },
                    obscureText: true,
                    suffixIcon: Image.asset(AssetsManager.showIcon),
                    prefixIcon: Image.asset(AssetsManager.passIcon),
                    hintText: AppLocalizations.of(context)!.password),
                SizedBox(
                  height: height * 0.02,
                ),
                TextButton(
                    onPressed: () {},
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        AppLocalizations.of(context)!.forget_password,
                        style: AppStyles.bold16Primary.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryLight),
                      ),
                    )),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomElevatedButton(
                    onButtonClicked: login,
                    text: AppLocalizations.of(context)!.login),
                SizedBox(
                  height: height * 0.02,
                ),
                Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(children: [
                      TextSpan(
                          text: AppLocalizations.of(context)!.dont_have_acc,
                          style: AppStyles.medium16Black),
                      TextSpan(
                          text: AppLocalizations.of(context)!.create_account,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context)
                                  .pushNamed(RegisterScreen.routeName);
                            },
                          style: AppStyles.bold16Primary.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryLight))
                    ])),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.primaryLight,
                        thickness: 2,
                        endIndent: 20,
                        indent: 20,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.or,
                      style: AppStyles.medium16Primary,
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.primaryLight,
                        thickness: 2,
                        endIndent: 20,
                        indent: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomElevatedButton(
                    onButtonClicked: () {
                      //login with google
                    },
                    textStyle: AppStyles.medium20Primary,
                    backgroundColor: AppColors.whiteColor,
                    icon: Image.asset(AssetsManager.googleIcon),
                    text: AppLocalizations.of(context)!.login_with_google),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

    if (formKey.currentState?.validate() == true) {
      //login
      DialogUtils.showLoading(context: context, message: 'loading');
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        var user = await FirebaseUtils.readUserFromFireStore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);

        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
            context: context,
            message: 'login successfully',
            title: 'success',
            posActionName: 'ok',
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        } else if (e.code == 'invalid-credential') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              message: 'Wrong password or Wrong email',
              title: 'error',
              posActionName: 'ok');
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
            context: context,
            message: e.toString(),
            title: 'error',
            posActionName: 'ok');
        print(e.toString());
      }
    }
  }
}
