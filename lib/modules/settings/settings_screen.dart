import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/ShopStates.dart';
import 'package:shop_app/layout/cubit/shopCubit.dart';
import 'package:shop_app/shared/componants/components.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        //!  منلعبش علي الاستيت
        // if (state is ShopSuccessProfileDataState) {
        //   nameController.text = state.shopLoginModel.data!.name!;
        //   emailController.text = state.shopLoginModel.data!.email!;
        //   phoneController.text = state.shopLoginModel.data!.phone!;
        // }
      },
      builder: (context, state) {
        var model = ShopCubit.get(context).shopLoginModel!;
        nameController.text = model.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ShopCubit.get(context).shopLoginModel != null
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      if (state is ShopUpadteUserLoadingState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Name must not be empty';
                            }
                          },
                          label: 'Name',
                          prefix: Icons.person),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Email must not be empty';
                            }
                          },
                          label: 'Email',
                          prefix: Icons.mail),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Phone must not be empty';
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text,
                            );
                          }
                        },
                        text: 'Update',
                        isUpperCase: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                        function: () {
                          signOut(context);
                        },
                        text: 'Sign out',
                        isUpperCase: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                        function: () {
                          CacheHelper.removeData(key: 'onBoarding')
                              .then((value) {
                            showToast(
                                text: 'ACTIVATED', state: ToastStates.SUCCESS);
                          });
                        },
                        text: 'Activate OnBoarding',
                        isUpperCase: false,
                      ),
                    ]),
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}
