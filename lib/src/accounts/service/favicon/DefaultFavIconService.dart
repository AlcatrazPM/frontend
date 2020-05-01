import 'package:alkatrazpm/src/accounts/service/favicon/FavIconService.dart';
import 'package:dio/dio.dart';

class DefaultFavIconService implements FavIconService {
  Dio _dio;

  DefaultFavIconService() {
    _dio = Dio(BaseOptions(baseUrl: "http://favicongrabber.com/api/grab/"));
  }

  @override
  Future<String> getFavIconUrl(String website) async {
    try {
      var res = await _dio.get(website);
      String url;
      List<dynamic> icons = res.data["icons"];
      for (Map<String, dynamic> icon in icons) {
        if ((icon["src"] as String).contains(".png") ||
            (icon["src"] as String).contains(".jpg")) {
          url = icon["src"];
          break;
        }
      }
      return Future.value(url);
    } catch (e) {
      return Future.error("oops");
    }
  }
}
