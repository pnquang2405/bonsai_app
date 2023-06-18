class AppImages {
  AppImages._();

  static String png(String name) => 'assets/images/png/$name.png';
  static String jpg(String name) => 'assets/images/jpg/$name.jpg';
  static String svg(String name) => 'assets/images/svg/$name.svg';
  static String lottie(String name) => 'assets/lotties/$name.json';

  static String imgStroke(int index) => svg('img_stroke_$index');
  static String imgTree = png('img_tree');
  static String imgPlanters = png('img_planters');
  static String imgPhotographer = png('img_photographer');
  static String imgLearnBook = png('img_learn_book');
  static String imgFooter = svg('img_footer');

  static String iconMail = svg('icon_mail');
  static String iconLock = svg('icon_lock');
  static String iconEyes = svg('icon_eyes');
  static String iconUnLike = svg('icon_unlike');
  static String iconLike = svg('icon_like');
  //navigation
  static String iconCMM = png('s1');
  static String iconHeart = png('s2');
  static String iconHome = png('icon_home_navi');
  static String iconSearch = png('s4');
  static String iconUser = png('s5');


}
