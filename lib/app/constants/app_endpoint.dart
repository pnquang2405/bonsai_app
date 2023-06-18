class AppEndpoint {
  AppEndpoint._();

  static const String BASE_URL_DEV = 'http://ctmtstudio.com/file/apibonsai';
  //static const String BASE_URL_DEV = 'http://192.168.1.142:8080/api';
  static const String BASE_URL_PROD = 'http://relax365.net';

  static const String TEST_API = 'https://jsonplaceholder.typicode.com/posts';

  static const int connectionTimeout = 1500;
  static const int receiveTimeout = 1500;
  static const String keyAuthorization = 'Authorization';

  static const int SUCCESS = 200;
  static const int ERROR_TOKEN = 401;
  static const int ERROR_VALIDATE = 422;
  static const int ERROR_SERVER = 500;
  static const int ERROR_DISCONNECT = -1;

  static const String login = '/login.json';
  //static const String login = '/auth/login';
  static const String register = '/register.json';
  static const String logout = '/logout.json';
  static const String scanBonsai = '/scanBonsai.json';
  static const String viewInfoBonsai = '/viewinfobonsai.json';
  static const String likePost = '/likePost.json';

  static const String getCommunity = '/getCommunity.json';
  static const String createPost = '/createPost.json';
  static const String getMyCollection = '/getMyCollection.json';
  static const String searchBonsai = '/searchBonsai.json';
  static const String sendCommentToPost = '/sendCommentToPost.json';
  static const String viewDetailPost = '/viewDetailPost.json';
  static const String getRecentPost = '/getRecentPost.json';
  static const String likeCollection = '/likeCollection.json';
  static const String getMyInfomation = '/getMyInfomation.json';
  static const String forgotPassword = '/forgotPassword.json';
  static const String editProfile = '/editProfile.json';
  static const String changePassword = '/changePassword.json';

// static const String MORE_APPS = '/hsmoreapp';
}
