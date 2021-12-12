import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq/layout/home_layout/home_layout.dart';
import 'package:souq/modules/register/cubit/shopregister_cubit.dart';
import 'package:souq/shared/components/components.dart';
import 'package:souq/shared/constants/constants.dart';
import 'package:souq/shared/network/local/cache_helper.dart';
import 'package:souq/shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
          listener: (context, state) {
        if (state is ShopRegisterSuccessState) {
          if (state.RegisterModel.status!) {
            // print(state.loginModel.message);
            print(state.RegisterModel.data!.token);
            CacheHelper.saveData(
                    key: 'token', value: state.RegisterModel.data!.token)
                .then((value) {
              token = state.RegisterModel.data!.token;
              navigateAndFinish(context, HomeLayout());
            });
          } else {
            // print(state.RegisterModel.message);
            showToast(
              text: '${state.RegisterModel.message}',
              state: ToastStates.WARNING,
            );
          }
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image(
                      //     image: AssetImage('assets/images/shoplogin.png')),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Text(
                        'Register'.toUpperCase(),
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Register Now To Browse Our Offers',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your Name';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'User Name',
                          // focusColor: Colors.black,
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your Email';
                          }
                        },
                        // obscureText: ShopRegisterCubit.get(context).isPassword,
                        // onFieldSubmitted: (value) {
                        //   if (formKey.currentState!.validate()) {
                        //     ShopRegisterCubit.get(context).userLogin(
                        //         email: emailController.text,
                        //         password: passwordController.text);
                        //   }
                        // },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          // suffixIcon: IconButton(
                          //   icon: Icon(ShopRegisterCubit.get(context).suffix),
                          //   onPressed: () {
                          //     ShopRegisterCubit.get(context)
                          //         .passwordVisibilityIcon();
                          //   },
                          // ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your Password';
                          }
                        },
                        obscureText: ShopRegisterCubit.get(context).isPassword,
                        onFieldSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            ShopRegisterCubit.get(context).userRegister(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock_outline,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(ShopRegisterCubit.get(context).suffix),
                            onPressed: () {
                              ShopRegisterCubit.get(context)
                                  .passwordVisibilityIcon();
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your Phone Number';
                          }
                        },
                        // obscureText: ShopRegisterCubit.get(context).isPassword,
                        // onFieldSubmitted: (value) {
                        //   if (formKey.currentState!.validate()) {
                        //     ShopRegisterCubit.get(context).userLogin(
                        //         email: emailController.text,
                        //         password: passwordController.text);
                        //   }
                        // },
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          prefixIcon: Icon(
                            Icons.phone,
                          ),
                          // suffixIcon: IconButton(
                          //   icon: Icon(ShopRegisterCubit.get(context).suffix),
                          //   onPressed: () {
                          //     ShopRegisterCubit.get(context)
                          //         .passwordVisibilityIcon();
                          //   },
                          // ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        // ////////**************************************************** */
                        condition: state is! ShopRegisterLoadingState,
                        builder: (context) => Container(
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            child: Text(
                              'Register'.toUpperCase(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: defaultColor,
                          ),
                        ),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       'Don\'t Have An Account',
                      //       style: TextStyle(fontSize: 16),
                      //     ),
                      //     TextButton(
                      //       onPressed: () {
                      //         navigateTo(context, RegisterScreen());
                      //       },
                      //       child: Text(
                      //         'Register Now',
                      //         style: TextStyle(fontSize: 18),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
