import 'package:responsi2_mobile_paket3_h1d023064/helpers/user_info.dart';

class LogoutBloc {
  static Future logout() async {
    await UserInfo().logout();
  }
}