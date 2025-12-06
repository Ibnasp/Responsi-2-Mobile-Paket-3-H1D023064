import 'package:flutter/material.dart';
import 'package:responsi2_mobile_paket3_h1d023064/model/buku.dart';
import 'package:responsi2_mobile_paket3_h1d023064/ui/buku_form.dart';
import 'package:responsi2_mobile_paket3_h1d023064/ui/buku_page.dart';
import 'package:responsi2_mobile_paket3_h1d023064/bloc/buku_bloc.dart';
import 'package:responsi2_mobile_paket3_h1d023064/widget/warning_dialog.dart';

class BukuDetail extends StatefulWidget {
  Buku? buku;
  
  BukuDetail({Key? key, this.buku}) : super(key: key);

  @override
  _BukuDetailState createState() => _BukuDetailState();
}

class _BukuDetailState extends State<BukuDetail> {
  String formatRupiah(int? harga) {
    if (harga == null) return 'Rp 0';
    String formatted = harga.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
    return 'Rp $formatted';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Buku Ibna'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                    const SizedBox(height: 16),

                  _buildInfoRow('Judul', widget.buku!.judul ?? 'Tanpa Judul'),
                  _buildInfoRow('Harga', formatRupiah(widget.buku!.harga)),
                  _buildInfoRow('Stok', '${widget.buku!.jumlah ?? 0} buku'),
                  _buildInfoRow('Volume', 'Volume ${widget.buku!.volume ?? 0}'),
                  _buildInfoRow('Tanggal Masuk', widget.buku!.tanggalMasuk ?? '-'),
                  _buildInfoRow('Penulis', widget.buku!.penulis ?? '-'),
                  _buildInfoRow('Penerbit', widget.buku!.penerbit ?? '-'),

                  const SizedBox(height: 24),

                  _tombolHapusEdit(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.edit),
            label: const Text('EDIT'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BukuForm(buku: widget.buku!),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.delete),
            label: const Text('HAPUS'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () => confirmHapus(),
          ),
        ),
      ],
    );
  }

  void confirmHapus() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Yakin ingin menghapus data buku ini?'),
        actions: [
          TextButton(
            child: const Text('BATAL'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
            ),
            child: const Text('HAPUS'),
            onPressed: () {
              Navigator.pop(context);
              BukuBloc.deleteBuku(id: int.parse(widget.buku!.id!)).then(
                (value) => {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const BukuPage(),
                    ),
                  )
                },
                onError: (error) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => const WarningDialog(
                      description: 'Hapus gagal, silahkan coba lagi',
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}