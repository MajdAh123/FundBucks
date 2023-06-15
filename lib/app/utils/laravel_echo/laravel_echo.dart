import 'package:app/app/utils/endpoints.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:pusher_client/pusher_client.dart';

class LaravelEcho {
  static LaravelEcho? _singleton;
  static late Echo _echo;
  static late PusherClient _pusherClient;

  final String token;

  LaravelEcho._({
    required this.token,
  }) {
    _pusherClient = createPusherClient(token);
    _echo = createLaravelEcho(token);
  }

  factory LaravelEcho.init({required String token}) {
    if ((_singleton == null || token != _singleton?.token)) {
      _singleton = LaravelEcho._(token: token);
    }
    return _singleton!;
  }

  static Echo get instance => _echo;

  static PusherClient get pusherClient => _pusherClient;

  static String get socketId => _echo.socketId() ?? '1111.11111111';
}

class PusherConfig {
  static const isDevelopment = false;
  static const appId = '1556437';
  static const key = '6a0e5762747aecefdb9b';
  static const secret = 'e254ac0bba6489fa771d';
  static const cluster = 'ap2';
  /* 
    static const appId = '1541677';
    static const key = 'fda5f9b84f6bc2483628';
    static const secret = '31448d50b75f39c3fcd8';
    static const cluster = 'us2';
   **/
  static const hostEndPoint =
      isDevelopment ? 'http://192.168.1.108:8000' : 'https://app.fundbucks.com';
  static String hostAuthEndPoint =
      '$hostEndPoint${EndPoints.getBroadcastingAuth()}';
  static const port = 6001;
}

PusherClient createPusherClient(String token) {
  PusherOptions options = PusherOptions(
    wsPort: PusherConfig.port,
    encrypted: true,
    host: PusherConfig.hostEndPoint,
    cluster: PusherConfig.cluster,
    auth: PusherAuth(
      PusherConfig.hostAuthEndPoint,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      },
    ),
  );

  PusherClient pusherClient = PusherClient(
    PusherConfig.key,
    options,
    autoConnect: false,
    enableLogging: true,
  )..onConnectionError((error) {
      print(error);
    });

  return pusherClient;
}

Echo createLaravelEcho(String token) {
  return Echo(
    client: createPusherClient(token),
    broadcaster: EchoBroadcasterType.Pusher,
  );
}
