import 'dart:convert';
import 'package:responsi2_mobile_paket3_h1d023064/helpers/api.dart';
import 'package:responsi2_mobile_paket3_h1d023064/helpers/api_url.dart';
import 'package:responsi2_mobile_paket3_h1d023064/model/buku.dart';

class BukuBloc {
  static Future<List<Buku>> getBooks() async {
  String apiUrl = ApiUrl.listBuku;
  var response = await Api().get(apiUrl);

  if (response.statusCode == 200) {
    var jsonObj = json.decode(response.body);
    List<dynamic> listBuku = (jsonObj as Map<String, dynamic>)['data'];
    List<Buku> books = [];
    for (int i = 0; i < listBuku.length; i++) {
      books.add(Buku.fromJson(listBuku[i]));
    }
    return books;
  } else {
    throw Exception('Failed to load books');
  }
}

  static Future addBuku({Buku? buku}) async {
    String apiUrl = ApiUrl.createBuku;

    var body = {
      'judul': buku!.judul,
      'harga': buku.harga,
      'jumlah': buku.jumlah,
      'tanggal_masuk': buku.tanggalMasuk,
      'volume': buku.volume,
      'penulis': buku.penulis,
      'penerbit': buku.penerbit,
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateBuku({required Buku buku}) async {
    String apiUrl = ApiUrl.updateBuku(int.parse(buku.id!));
    print(apiUrl);

    var body = {
      'judul': buku.judul,
      'harga': buku.harga,
      'jumlah': buku.jumlah,
      'tanggal_masuk': buku.tanggalMasuk,
      'volume': buku.volume,
      'penulis': buku.penulis,
      'penerbit': buku.penerbit,
    };
    print('Body: $body');
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteBuku({int? id}) async {
    String apiUrl = ApiUrl.deleteBuku(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
