import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../constants/constants.dart';
import '../ui.dart';

class NavigationScreen extends BaseScreen<NavigationController> {
  NavigationScreen({super.key});

  static const double HEIGHT_BOTTOM_BAR = 72;

  @override
  Widget phone() {
    return _buildScreen();
  }

  @override
  Widget? builder() {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: super.builder(),
      ),
    );
  }

  Widget _buildScreen() {
    return GetX<NavigationController>(
      builder: (_) => Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _.currentPage.value,
              children: [
                CommunityScreen(),
                MyCollectionScreen(),
                HomeScreen(),
                SearchScreen(),
                ProfileScreen(),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, -1),
                  blurRadius: 25,
                  spreadRadius: 0.5,
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            height: HEIGHT_BOTTOM_BAR,
            child: Row(
              children: [
                _buildTab(0, 'Home', AppImages.iconCMM, _.currentPage.value),
                _buildTab(1, 'Contact', AppImages.iconHeart, _.currentPage.value),
                _buildTab(2, 'Chat', AppImages.iconHome, _.currentPage.value),
                _buildTab(3, 'Project', AppImages.iconSearch, _.currentPage.value),
                _buildTab(4, 'Project', AppImages.iconUser, _.currentPage.value),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTab(int index, String title, String icon, int selected) {
    final bool selected0 = index == selected;
    final double topOffset = index == 2 ? -30 : -5;
    return Expanded(
      child: InkWell(
        onTap: () {
          controller.changePage(index);
        },
        child: Container(
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                top: topOffset,
                left: -60 / 2,
                right: -60 / 2,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: selected0 ? 2 : 0),
                    Image.asset(
                      icon,
                      width: index == 2 ? 100 : 30,
                      height: index == 2 ? 100 : 30,
                      color: selected0
                          ? index == 2
                              ? null
                              : AppColors.primary
                          : null,
                    ),
                    // iconAreaWidget,
                    // labelWidget,
                    // SizedBox(height: shadowTopSpacer),
                    // shadowWidget,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // return Expanded(
    //   child: InkWell(
    //     onTap: () {
    //       controller.changePage(index);
    //     },
    //     child: Container(
    //       constraints: const BoxConstraints.expand(),
    //       child: Center(
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             SvgPicture.asset(
    //               icon,
    //               width: 42,
    //               height: 42,
    //               color: selected0 ? AppColors.primary : null,
    //             ),
    //             // Text(
    //             //   title,
    //             //   style: AppTextStyles.smallBold.copyWith(
    //             //     color: selected0 ? AppColors.primary : null,
    //             //   ),
    //             // )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
