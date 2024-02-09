import 'package:flutter/material.dart';
import 'package:weather_project_mvvm/core/view_models/sign_in_view_model.dart';
import 'package:weather_project_mvvm/ui/route_navigation.dart';
import 'package:weather_project_mvvm/ui/views/base_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<SignInViewModel>(
      onModelReady: (model) async {
        model.setSavedPassword();
      },
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: Form(
              key: model.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      obscureText: model.isMobileNumberVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: model.changeIsMobileNumberVisible,
                          icon: Icon(model.isMobileNumberVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        label: const Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Text(
                              'Mobile Number',
                              // "Name",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        // labelText: 'Name',
                        alignLabelWithHint: true,
                        hintText: 'Please Enter Your Mobile Number',

                        hintStyle: const TextStyle(color: Colors.grey),
                        // prefixIcon: const Icon(Icons.search),
                        prefixIconColor: Colors.blueAccent,
                        filled: true,
                        fillColor: Colors.white10,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 4.5,
                            style: BorderStyle.solid,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.indigoAccent,
                            width: 2.0,
                            style: BorderStyle.solid,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      controller: model.mobileNumberController,
                      validator: (value) => model.mobilenumberValidator(value!),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      obscureText: model.isPasswordVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: model.changeIsPasswordVisible,
                          icon: Icon(model.isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        label: const Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Text(
                              'Password',
                              // "Name",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        // labelText: 'Name',
                        alignLabelWithHint: true,
                        hintText: 'Please Enter Password',

                        hintStyle: const TextStyle(color: Colors.grey),
                        // prefixIcon: const Icon(Icons.search),
                        prefixIconColor: Colors.blueAccent,
                        filled: true,
                        fillColor: Colors.white10,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 4.5,
                            style: BorderStyle.solid,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 4.5,
                            style: BorderStyle.solid,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.indigoAccent,
                            width: 2.0,
                            style: BorderStyle.solid,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      controller: model.passwordController,
                      validator: (value) => model.passwordValidator(value!),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: model.isCheck,
                        onChanged: (value) {
                          model.isCheckToogle();
                        },
                      ),
                      const Text('Remember my credentials'),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        // model.signIn();

                        if (model.formKey.currentState!.validate()) {
                          bool statusCode = await model.signIn();
                          if (statusCode == true) {
                            if (context.mounted) {
                              Navigator.pushNamed(
                                  context, RouteNavigation.petApi);
                            } else {
                              print(
                                  'Sign-in failed with status code: $statusCode');
                            }
                          }
                        }
                      },
                      child: const Text("Log in"))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
