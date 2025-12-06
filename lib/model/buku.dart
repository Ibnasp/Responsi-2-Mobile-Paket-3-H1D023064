class Buku {
  String? id;
  String? judul;
  int? harga;
  int? jumlah;
  String? tanggalMasuk;
  int? volume;
  String? penulis;
  String? penerbit;

  Buku({this.id, this.judul, this.harga, this.jumlah, this.tanggalMasuk, this.volume, this.penulis, this.penerbit});

  factory Buku.fromJson(Map<String, dynamic> json) {
    return Buku(
      id: json['id'].toString(),
      judul: json['judul'],
      harga: _parseInt(json['harga']),
      jumlah: _parseInt(json['jumlah']),
      tanggalMasuk: json['tanggal_masuk'],
      volume: _parseInt(json['volume']),
      penulis: json['penulis'],
      penerbit: json['penerbit'],
    );
  }
  
  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'harga': harga,
      'jumlah': jumlah,
      'tanggal_masuk': tanggalMasuk,
      'volume': volume,
      'penulis': penulis,
      'penerbit': penerbit,
    };
  }
}