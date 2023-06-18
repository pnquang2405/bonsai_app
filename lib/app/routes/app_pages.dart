import 'package:get/get.dart';
import '../ui/ui.dart';
part './app_routes.dart';

class AppPages {
  AppPages._();
  static final List<GetPage> pages = <GetPage>[
    GetPage(name: Routes.INTRO, page: () => IntroScreen(), binding: IntroBinding()),
    GetPage(name: Routes.SIGN_IN, page: () => LoginScreen(), binding: LoginBinding()),
    GetPage(name: Routes.NAVIGATION, page: () => NavigationScreen(), bindings: [
      NavigationBinding(),
      CommunityBinding(),
      MyCollectionBinding(),
      HomeBinding(),
      SearchBinding(),
      ProfileBinding()
    ]),
    GetPage(
      name: Routes.CREATE_POST,
      page: () => CreatePostScreen(),
      binding: CreatePostBinding(),
    ),
    GetPage(
      name: Routes.POST_DETAIL,
      page: () => PostDetailScreen(),
      binding: PostDetailBinding(),
    ),
    GetPage(
      name: Routes.RECENT_POST,
      page: () => RecentPostScreen(),
      binding: RecentPostBinding(),
    ),
  ];
}
