import 'package:flutter/material.dart';
import 'package:foodart/backend/controllers/auth_controller.dart';
import 'package:foodart/backend/controllers/cart_controller.dart';
import 'package:foodart/backend/controllers/user_controller.dart';
import 'package:foodart/reusable_widgets/account_detail_row_widget.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/custom_loading_screen.dart';
import 'package:foodart/utilities/route_helper.dart';
import 'package:get/get.dart';
import '../utilities/colors.dart';
import '../utilities/dimensions.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isUserLoggedIn = Get.find<AuthController>().isuserLoggedIn();
    if (_isUserLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return GetBuilder<UserController>(
      builder: ((userController) {
        return _isUserLoggedIn
            ? (!userController.isLoading
                ? const CustomLoadingScreen()
                : Scaffold(
                    body: Column(
                      children: [
                        Container(
                          height: Dimensions.height150,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft:
                                    Radius.circular(Dimensions.radius40),
                                bottomRight:
                                    Radius.circular(Dimensions.radius40)),
                            color: AppColors.mainColor,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: Dimensions.height15),
                            width: double.maxFinite,
                            child: Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: Dimensions.radius80,
                                          backgroundImage: const AssetImage(
                                              "assets/images/sai.png"),
                                        ),
                                        SizedBox(
                                          height: Dimensions.height15,
                                        ),
                                        AccountDetailRowWidget(
                                            icon: Icons.person,
                                            fieldText:
                                                userController.userModel.name,
                                            containerbackgroundColor:
                                                AppColors.mainColor),
                                        SizedBox(
                                          height: Dimensions.height15,
                                        ),
                                        AccountDetailRowWidget(
                                            icon: Icons.call,
                                            fieldText:
                                                userController.userModel.phone,
                                            containerbackgroundColor:
                                                AppColors.mainColor),
                                        SizedBox(
                                          height: Dimensions.height15,
                                        ),
                                        AccountDetailRowWidget(
                                            icon: Icons.email,
                                            fieldText:
                                                userController.userModel.email,
                                            containerbackgroundColor:
                                                AppColors.mainColor),
                                        SizedBox(
                                          height: Dimensions.height15,
                                        ),
                                        const AccountDetailRowWidget(
                                            icon: Icons.location_city,
                                            fieldText: "Tirupati",
                                            containerbackgroundColor:
                                                AppColors.mainColor),
                                        SizedBox(
                                          height: Dimensions.height15,
                                        ),
                                        const AccountDetailRowWidget(
                                            icon: Icons.message,
                                            fieldText: "messages",
                                            containerbackgroundColor:
                                                AppColors.mainColor),
                                        GestureDetector(
                                          onTap: () {
                                            if (Get.find<AuthController>()
                                                .isuserLoggedIn()) {
                                              Get.find<AuthController>()
                                                  .clearAllUserDataWhileLoggingOut();
                                              Get.find<CartController>()
                                                  .clearAllUserCartDataWhileLoggingOut();
                                              Get.toNamed(
                                                  RouteHelper.getSignInScreen());
                                            }
                                          },
                                          child: const AccountDetailRowWidget(
                                              icon: Icons.logout,
                                              fieldText: "Logout",
                                              containerbackgroundColor:
                                                  AppColors.mainColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            : Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width -
                            Dimensions.width50,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/signintocontinue.png"),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getSignInScreen());
                        },
                        child: Container(
                          height: Dimensions.height75,
                          width: Dimensions.width180,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: AppColors.mainColor),
                          child: const Center(
                            child: BigText(
                              text: "Sign In",
                              textColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
