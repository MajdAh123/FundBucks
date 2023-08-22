class EndPoints {
  static bool isDevelopment = false;
  static String url = 'https://app.fundbucks.com';
  static String devUrl = 'http://192.168.1.108:8000';
  static String api = '/api';
  static String apiVersion = '/v1';

  static String getBaseUrl() => isDevelopment ? devUrl : url;
  static String getEndApiPoint() => getBaseUrl() + api + apiVersion;

  static String login = '/login';
  static String createAccountPortfolio = '/portfolio';
  static String create = '/create';
  static String verify = '/verify';
  static String sendVerify = '/verify/send';
  static String getUser = '/user';
  static String stocks = '/stocks';
  static String homePageData = '/account-data';
  static String broadcastAuth = '/broadcasting/auth';
  static String userAvatar = '/admin/images/user/profile/';
  static String allNotifications = '/notifications';
  static String readAllNotifications = '/notifications/read/all';
  static String readNotification = '/notifications/read/';
  static String deleteNotification = '/notifications/delete';
  static String isThereNotification = '/notifications/new-notification';
  static String report = '/report';
  static String pdf = '/pdf';
  static String gatewayDetails = '/gateway-details';
  static String sendDeposit = '/send/deposit';
  static String sendWithdraw = '/send/withdraw';
  static String deposits = '/deposits';
  static String withdraws = '/withdraws';
  static String updateUser = '/user/update';
  static String webviewUrl = '/webview/url/';
  static String supportCards = '/support-cards';
  static String findAccount = '/find-account';
  static String resetPassword = '/reset-password';
  static String createTicket = '/ticket/create';
  static String ticketList = '/tickets';
  static String ticketDetail = '/ticket';
  static String resetAvatar = '/user/reset-avatar';
  static String createMessage = '/support-message/create';
  static String closeTicket = '/ticket/close';
  static String checkUsername = '/check/username';
  static String reports = '/reports';
  static String updateNotifications = '/notifications/update';
  static String gateways = '/gateways';
  static String checkUpdate = '/check-update';
  static String alerts = '/alerts';
  static String readAlert = '/alert/read';
  static String deleteAccount = '/user/delete-account';
  static String changeAccountMode = '/user/change-mode';
  static String currencies = '/currencies';
  

  static String userAvatarUrl() => getBaseUrl() + userAvatar;

  static String getBroadcastingAuth() => api + broadcastAuth;

  static String getUrl(String path) => getEndApiPoint() + path;
}
