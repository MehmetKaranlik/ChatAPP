import 'package:chat_app_example/constants/constants.dart';
import 'package:chat_app_example/controllers/controllers.dart';
import 'package:chat_app_example/models/user_model.dart';
import 'package:chat_app_example/services/database/database.dart';
import 'package:chat_app_example/views/views.dart';
import 'package:chat_app_example/global_widgets/global_widgets.dart';
import 'package:chat_app_example/services/Authentication/auth.dart';
import 'package:chat_app_example/global_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  final AuthenticationMethods authMethods = AuthenticationMethods();
  final DatabaseMethods databaseMethod = DatabaseMethods();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final obxController = Get.put(IsLoadingController());
  final TextFieldControllers _ControllerInstance = TextFieldControllers();

  signUserUp(BuildContext context) async {
    // function to sign up > placed to sign up button
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      obxController.changeIsLoading();

      final UserID result = await authMethods.signUpWithEmailAndPassword(
          _ControllerInstance.emailTextFieldController.text,
          _ControllerInstance.passwordTextFieldController.text);

      if (result == null) {
        obxController.changeIsLoading();
        _ControllerInstance.usernameTextFieldController.clear();
        _ControllerInstance.emailTextFieldController.clear();
        _ControllerInstance.passwordTextFieldController.clear();
        _ControllerInstance.confirmPasswordTextFieldController.clear();
        ScaffoldMessenger.of(context)
            .showSnackBar(Constants.RegisterErrorSnackBar);
      } else {
        HelperFunctions.saveUserEmailSharedPreferences(
            _ControllerInstance.emailTextFieldController.text);

        HelperFunctions.saveUserPasswordSharedPreferences(
            _ControllerInstance.passwordTextFieldController.text);
        HelperFunctions.saveUserNameSharedPreferences(
            _ControllerInstance.usernameTextFieldController.text);
        Map<String, dynamic> userInfo = {
          "name": _ControllerInstance.usernameTextFieldController.text,
          "email": _ControllerInstance.emailTextFieldController.text,
        };
        await databaseMethod.upLoadUserInfo(userInfo);
        obxController.changeIsLoading();
        Get.off(() => RoomPage());
      }

      //
    } else {
      print("Its not validated");
    }
  }

  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1F1F1F),
      body: Obx(
        () => obxController.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedPlaceHolder(
                        height: 8.h,
                        width: 100,
                        color: Colors.transparent), // tepe boşlık
                    BackIconButton(
                      onPressed: () => Get.off(
                        SignInView(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedPlaceHolder(
                              height: 15.h,
                              width: 100.w,
                              color: Colors.transparent),
                          Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: _formKey,
                            child: Column(
                              children: [
                                CustomTextFieldUsername(
                                  controller: _ControllerInstance
                                      .usernameTextFieldController,
                                  fontSize: 13.sp,
                                  hintText: "Username",
                                  obscure: false,
                                ),
                                CustomTextFieldEmail(
                                  controller: _ControllerInstance
                                      .emailTextFieldController,
                                  fontSize: 13.sp,
                                  hintText: "E-mail",
                                  obscure: false,
                                ),
                                CustomTextFieldPassword(
                                  controller: _ControllerInstance
                                      .passwordTextFieldController,
                                  fontSize: 13.sp,
                                  hintText: "Password",
                                  obscure: true,
                                ),
                                CustomTextFieldPasswordConfirm(
                                  controller: _ControllerInstance
                                      .confirmPasswordTextFieldController,
                                  fontSize: 13.sp,
                                  hintText: "Type your password again",
                                  obscure: true,
                                ),
                              ],
                            ),
                          ),
                          SizedPlaceHolder(
                              height: 8.h,
                              width: 300,
                              color: Colors.transparent),
                          Column(
                            children: [
                              CustomTextButton(
                                  "Create an account",
                                  () => signUserUp(context),
                                  Colors.black87,
                                  13.sp,
                                  Colors.white,
                                  Colors.purple,
                                  Colors.cyan,
                                  55.w,
                                  false,
                                  logoPath: "assets/images/googleicon.png"),
                              SizedPlaceHolder(
                                  height: 1.h,
                                  width: 50,
                                  color: Colors.transparent),
                              CustomTextButton(
                                  "Sign-up with Google",
                                  () => "null",
                                  Colors.black87,
                                  13.sp,
                                  Colors.white,
                                  Colors.white70,
                                  Colors.white,
                                  55.w,
                                  true,
                                  logoPath: "assets/images/googleicon.png"),
                              SizedPlaceHolder(
                                  height: 3.h,
                                  width: 50,
                                  color: Colors.transparent),
                              Container(
                                height: 5.h,
                                width: 100.w,
                                child: _buildAlreadyHaveAnAccountButton(),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _buildAlreadyHaveAnAccountButton extends StatelessWidget {
  const _buildAlreadyHaveAnAccountButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Get.to(SignInView()),
      child: Text(
        "Already have an account?",
        style: TextStyle(
          fontSize: 11.sp,
          color: Colors.white,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
