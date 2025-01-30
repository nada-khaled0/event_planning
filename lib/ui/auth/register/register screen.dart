import 'package:event_planning/firebase_utils.dart';
import 'package:event_planning/model/my%20user.dart';
import 'package:event_planning/ui/auth/login/login%20screen.dart';
import 'package:event_planning/ui/home%20screen/home%20screen.dart';
import 'package:event_planning/utils/alert%20dialog.dart';
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

import '../../../providers/user provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.register,
          style: AppStyles.medium16Black,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
        ),
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
                    controller: nameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter your name';
                      }
                      return null;
                    },
                    prefixIcon: Image.asset(AssetsManager.nameIcon),
                    hintText: AppLocalizations.of(context)!.name),
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
                CustomTextField(
                    keyboard: TextInputType.number,
                    controller: rePasswordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter your password';
                      }
                      if (text.length < 6) {
                        return 'password should be at least 6 chars';
                      }
                      if (text != passwordController.text) {
                        return 'wrong password';
                      }
                      return null;
                    },
                    obscureText: true,
                    suffixIcon: Image.asset(AssetsManager.showIcon),
                    prefixIcon: Image.asset(AssetsManager.passIcon),
                    hintText: AppLocalizations.of(context)!.re_password),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomElevatedButton(
                    onButtonClicked: register,
                    text: AppLocalizations.of(context)!.create_account),
                SizedBox(
                  height: height * 0.02,
                ),
                Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(children: [
                      TextSpan(
                          text: AppLocalizations.of(context)!.already_have_acc,
                          style: AppStyles.medium16Black),
                      TextSpan(
                          text: AppLocalizations.of(context)!.login,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context)
                                  .pushReplacementNamed(LoginScreen.routeName);
                            },
                          style: AppStyles.bold16Primary.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryLight))
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() async {
    // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    DialogUtils.showLoading(
      context: context,
      message: 'loading',
    );
    if (formKey.currentState?.validate() == true) {
      //register
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser user = MyUser(
            id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text);
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);

        FirebaseUtils.addUserToFireStore(user);
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
            context: context,
            message: 'register successfully',
            title: 'success',
            posActionName: 'ok',
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              message: 'The password provided is too weak',
              title: 'error',
              posActionName: 'ok');
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              message: 'The account already exists for that email.',
              title: 'error',
              posActionName: 'ok');
          print('The account already exists for that email.');
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
            context: context,
            message: e.toString(),
            title: 'error',
            posActionName: 'ok');
        print(e);
      }
    }
  }
}
