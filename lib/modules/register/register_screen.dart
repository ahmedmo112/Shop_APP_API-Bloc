import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/register/cubit/cubitRegister.dart';
import 'package:shop_app/modules/register/cubit/statusRegister.dart';
import 'package:shop_app/shared/componants/components.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
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
                          'register'.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'register now to browse our offers',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your name';
                              }
                            },
                            label: 'Name',
                            prefix: Icons.person),
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
                            suffix: ShopRegisterCubit.get(context).suffix,
                            suffixPressed: () {
                              ShopRegisterCubit.get(context)
                                  .changePassworsVisiility();
                            },
                            
                            isPassword:
                                ShopRegisterCubit.get(context).isPassword,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'password is too short';
                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock_outline),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your phone';
                              }
                            },
                            label: 'Phone',
                            prefix: Icons.phone),
                        SizedBox(
                          height: 30.0,
                        ),
                          state is! ShopRegisterLoadingState
                        
                            ? defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text
                                    );
                                  }
                                },
                                text: 'register',
                                isUpperCase: true,
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
