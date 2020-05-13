import 'dart:typed_data';

abstract class FavIconService{
  Future<Uint8List> getFavIcon(String website);
}