import 'package:chat_app_example/constants/constants.dart';
import 'package:chat_app_example/constants/helper_constants.dart';
import 'package:chat_app_example/controllers/controllers.dart';
import 'package:chat_app_example/controllers/text_field_controller.dart';
import 'package:chat_app_example/services/database/database.dart';
import 'package:chat_app_example/views/views.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_example/global_widgets/global_widgets.dart';
import 'package:get/get.dart';
import '../sign_in_view/sign_in_widgets/sign_in_widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:chat_app_example/services/Authentication/auth.dart';

class SignInView extends StatelessWidget {
  final DatabaseMethods databaseMethods = DatabaseMethods();
  final formKey = GlobalKey<FormState>();
  final obxController = Get.put(IsLoadingController());
  final AuthenticationMethods authMethods = AuthenticationMethods();
  final TextFieldControllers _ControllerInstance = TextFieldControllers();

  signUserIn(BuildContext context) async {
    // function to sign up > placed to sign up button
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      obxController.changeIsLoading();
      final QuerySnapshot snapshotData = await databaseMethods.getUserByEmail(
          _ControllerInstance
              .emailTextFieldController.text); //Getting user info
      await authMethods
          .signInWithEmailAndPasswor(
              _ControllerInstance.emailTextFieldController.text,
              _ControllerInstance.passwordTextFieldController.text)
          .then((value) {
        if (value != null) {
          HelperFunctions.saveUserEmailSharedPreferences(
              _ControllerInstance.emailTextFieldController.text); //Caching

          HelperFunctions.saveUserPasswordSharedPreferences(
              _ControllerInstance.passwordTextFieldController.text); //Caching

          HelperFunctions.saveUserLoggedInSharedPreferences(true); //Caching
          Get.off(() => RoomPage());
        } // if login values are not wrong
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            Constants.loginErrorSnackBar,
          ); //Login error snackbar
          _ControllerInstance.emailTextFieldController.clear();
          _ControllerInstance.passwordTextFieldController.clear();
        } // if login values are  wrong
      });
      obxController.changeIsLoading();
    } else {
      print("Its not validated");
    }
  }

  SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff1F1F1F),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 11.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.h,
                ), //Top space
                AppLogo(
                  22.h,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 12.h,
                ),
                _BuildTextFields(
                    formKey: formKey, ControllerInstance: _ControllerInstance),
                SizedBox(
                  height: 0.5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    _BuildForgotYourPasswordButton(),
                  ],
                ),
                SizedBox(
                  height: 6.h,
                ),
                Obx(
                  () => obxController.isLoading
                      ? LinearProgressIndicator(
                          color: Colors.white,
                          backgroundColor: Colors.grey[700],
                        )
                      : _buildLoginButtons(context),
                ),
              ],
            ),
          ),
        ));
  }

  Row _buildLoginButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            CustomTextButton(
              "Login",
              () {
                FocusScope.of(context).unfocus();
                signUserIn(context);
              },
              Colors.black87,
              13.sp,
              Colors.white,
              Colors.purple,
              Colors.cyan,
              55.w,
              false,
              logoPath: "assets/images/googleicon.png",
            ),
            const SizedPlaceHolder(
                height: 7, width: 50, color: Colors.transparent),
            CustomTextButton(
              "Login with Google",
              () => "null",
              Colors.black87,
              13.sp,
              Colors.white,
              Colors.white70,
              Colors.white,
              55.w,
              true,
              logoPath: "assets/images/googleicon.png",
            ),
            SizedPlaceHolder(
                height: 3.h, width: 100, color: Colors.transparent),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                _BuildRegisterButton(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _BuildTextFields extends StatelessWidget {
  const _BuildTextFields({
    Key? key,
    required this.formKey,
    required TextFieldControllers ControllerInstance,
  })  : _ControllerInstance = ControllerInstance,
        super(key: key);

  final GlobalKey<FormState> formKey;
  final TextFieldControllers _ControllerInstance;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
              width: 80.w,
              height: 4.h,
              child: CustomTextFieldEmail(
                  hintText: "E-mail",
                  fontSize: 12.sp,
                  obscure: false,
                  controller: _ControllerInstance.emailTextFieldController)),
          SizedBox(
            height: 4.h,
          ),
          Container(
            width: 80.w,
            height: 4.h,
            child: CustomTextFieldPassword(
                hintText: "Password",
                fontSize: 12.sp,
                obscure: true,
                controller: _ControllerInstance.passwordTextFieldController),
          ),
        ],
      ),
    );
  }
}

class _BuildForgotYourPasswordButton extends StatelessWidget {
  const _BuildForgotYourPasswordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: null,
      child: Text(
        "Forgot your password?",
        style: TextStyle(
          fontSize: 11.sp,
          color: Colors.white,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

class _BuildRegisterButton extends StatelessWidget {
  const _BuildRegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Get.to(SignUpPage()),
      child: Text(
        "Dont have account ?  Dont worry, click here!",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11.sp,
          color: Colors.white,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
