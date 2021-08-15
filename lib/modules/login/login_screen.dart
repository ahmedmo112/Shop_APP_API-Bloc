import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/shopCubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubitLogin.dart';
import 'package:shop_app/modules/login/cubit/statusLogin.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/componants/components.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel!.status!) {
              print(state.loginModel!.message);
              print(state.loginModel!.data!.token);
              // showToast( text: state.loginModel!.message, state: ToastStates.SUCCESS);

              CacheHelper.saveData(
                      key: 'token', value: state.loginModel!.data!.token)
                  .then((value) {
                token = state.loginModel!.data!.token;
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              print(state.loginModel!.message);

              showToast(
                  text: state.loginModel!.message!, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black),
                          ),
                          Text(
                            'login now to browse our offers',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your email';
                                }
                              },
                              label: 'Email Address',
                              prefix: Icons.email_outlined),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              suffix: ShopLoginCubit.get(context).suffix,
                              suffixPressed: () {
                                ShopLoginCubit.get(context)
                                    .changePassworsVisiility();
                              },
                              onSubmit: (value) {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              isPassword:
                                  ShopLoginCubit.get(context).isPassword,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'password is too short';
                                }
                              },
                              label: 'Password',
                              prefix: Icons.lock_outline),
                          SizedBox(
                            height: 30.0,
                          ),
                          state is! ShopLoginLoadingState
                              ? defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                   //   ShopCubit.get(context).getFavorites();
                                //  ShopCubit.get(context).getUserData();
                                    }
                                  },
                                  text: 'Login',
                                  isUpperCase: true,
                                )
                              : Center(
                                  child: CircularProgressIndicator(),
                                ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('don\'t have an account?'),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                  
                                },
                                child: Text('register'.toUpperCase()),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
