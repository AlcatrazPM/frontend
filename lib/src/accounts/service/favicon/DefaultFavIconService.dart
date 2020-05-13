import 'dart:convert';
import 'dart:typed_data';

import 'package:alkatrazpm/src/accounts/service/favicon/FavIconService.dart';
import 'package:dio/dio.dart';

class DefaultFavIconService implements FavIconService {

  static const String _iconPlaceHolder = "iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAQA"
      "AAD9CzEMAAACsElEQVR4Ae3W30tTYRjA8a9zO0sHoU0PirZ/QBIhNP07CsSLAnFodCsuLYQu+t2NqWlR3SpaCUkE/QtBYmYX5Y9qVlBq01k5d7NuHh4ObefHNgoEP+/d+zzv8+6873k448C+UEobF5nhLZukSbPJIk/o5wQ+ihbhFl/J2Iw1rlFHwUwekCbjMvYYJ0wBzpAg43Fs0E5eAjy0FiDJBFGaCWNgUEUzUSZJWnMYx49HIV5YFr6jkzJyKaeLJUvmM81zFLCU/00vfpfsPnYtW/hxpYfDexrwopFly0G5OK2pc1Tjlcm8rmt3Tkzor68mH6Y+xTpHsHVfkn7RQL4a9S7uYCOibdVLIWKyOmXX3Tf1xfQDAIcYI8k2owRRtrGAHtNVcvDxRcKdIMb06kZQDrGozMQpIUubBLcpQ1h6dQvlEAuxI3MtZLkgoQlQ21okgXKMTclcP1lmJBQFNapFhlCOsR6Ze0SWRQk1gwoywhYJhjBQjrFWqbJAlk0JhSmGqe2mhPaAQTGC+hn67xvoEVX9qyPSS6YYesnOr2mBnF/TAQlNgjiszeQ8fhACMS1z5+0fLkk5iEFPG8RAhPhpf9A+PkuwC4TBnGv5lwRAdMvcJ0rI4YaElyxLIsQdy3+gDoTBisxeIaej2gt9oCLM25Z/RX2OW0xRi427+nflGKggl/RsdZBkEANUEymJDGOrStttGROrSs4xS5w0aeLMcpYKrGpYlZXfqcRBh/7CeUy8quG1rjuFi3uaukwjXjSxav18uvHzXNN3iRHAicEAKc2fpRQPypEt5DmihMglRDcrlsynlOGRXw5KBjtM0UMrJkGCmLTSw/Rfb9YwpeSlgw0yHsc3TlKAMOPsuRZPcZsKClbPddZsi3/kMrUUzUcLAzzmDRvskWKdBaaJcZwSDuwDfwCocWGlJHBmcAAAAABJRU5ErkJggg==";

  Dio _dio;

  DefaultFavIconService() {
    _dio = Dio();
  }

  @override
  Future<Uint8List> getFavIcon(String website) async {
    try {
      Response<List<int>> res = await _dio.get<List<int>>("http://www.google"
          ".com",
        options: Options(responseType: ResponseType.bytes),);

      if(res != null){
        return Future.value(res.data as Uint8List);
      }
      return Future.value(Base64Codec().decode(_iconPlaceHolder));
    } catch (e) {
      print(e);
      return Future.value(Base64Codec().decode(_iconPlaceHolder));
    }
  }
}
