import 'package:flutter/material.dart';
import 'package:responsi2_mobile_paket3_h1d023064/bloc/buku_bloc.dart';
import 'package:responsi2_mobile_paket3_h1d023064/model/buku.dart';
import 'package:responsi2_mobile_paket3_h1d023064/ui/buku_page.dart';
import 'package:responsi2_mobile_paket3_h1d023064/widget/warning_dialog.dart';

class BukuForm extends StatefulWidget {
  Buku? buku;
  BukuForm({Key? key, this.buku}) : super(key: key);

  @override
  _BukuFormState createState() => _BukuFormState();
}

class _BukuFormState extends State<BukuForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = 'Tambah Buku Ibna';
  String tombolSubmit = 'SIMPAN';
  final _judulTextboxController = TextEditingController();
  final _hargaTextboxController = TextEditingController();
  final _jumlahTextboxController = TextEditingController();
  final _tanggalMasukTextboxController = TextEditingController();
  final _volumeTextboxController = TextEditingController();
  final _penulisTextboxController = TextEditingController();
  final _penerbitTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.buku != null) {
      setState(() {
        judul = 'Ubah Buku Ibna';
        tombolSubmit = 'UBAH';
        _judulTextboxController.text = widget.buku!.judul!;
        _hargaTextboxController.text = widget.buku!.harga.toString();
        _jumlahTextboxController.text = widget.buku!.jumlah.toString();
        _tanggalMasukTextboxController.text = widget.buku!.tanggalMasuk!;
        _volumeTextboxController.text = widget.buku!.volume.toString();
        _penulisTextboxController.text = widget.buku!.penulis!;
        _penerbitTextboxController.text = widget.buku!.penerbit!;
      });
    } else {
      judul = 'Tambah Buku Ibna';
      tombolSubmit = 'SIMPAN';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Form
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _judulTextField(),
                        const SizedBox(height: 16),
                        _hargaTextField(),
                        const SizedBox(height: 16),
                        _jumlahTextField(),
                        const SizedBox(height: 16),
                        _volumeTextField(),
                        const SizedBox(height: 16),
                        _tanggalMasukTextField(),
                        const SizedBox(height: 24),
                         _penulisTextField(),
                        const SizedBox(height: 16),
                        _penerbitTextField(),
                        const SizedBox(height: 16),
                        _buttonSubmit(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _judulTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Judul Buku',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.book),
      ),
      controller: _judulTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Judul harus diisi';
        }
        return null;
      },
    );
  }

  Widget _hargaTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Harga',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.payments),
        prefixText: 'Rp ',
      ),
      keyboardType: TextInputType.number,
      controller: _hargaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Harga harus diisi';
        }
        return null;
      },
    );
  }

  Widget _jumlahTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Jumlah Stok',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.inventory_2),
        suffixText: 'buku',
      ),
      keyboardType: TextInputType.number,
      controller: _jumlahTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Jumlah harus diisi';
        }
        return null;
      },
    );
  }

  Widget _tanggalMasukTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Tanggal Masuk',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.calendar_today),
      ),
      controller: _tanggalMasukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Tanggal masuk harus diisi';
        }
        return null;
      },
    );
  }

  Widget _volumeTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Volume',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.library_books),
      ),
      keyboardType: TextInputType.number,
      controller: _volumeTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Volume harus diisi';
        }
        return null;
      },
    );
  }

  Widget _penulisTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Penulis',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.person),
      ),
      controller: _penulisTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Penulis harus diisi';
        }
        return null;
      },
    );
  }

  Widget _penerbitTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Penerbit',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.business),
      ),
      controller: _penerbitTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Penerbit harus diisi';
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.brown,
          foregroundColor: Colors.white,
        ),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.buku != null) {
                ubah();
              } else {
                simpan();
              }
            }
          }
        },
        child: Text(
          tombolSubmit,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Buku createBuku = Buku(id: null);
    createBuku.judul = _judulTextboxController.text;
    createBuku.harga = int.parse(_hargaTextboxController.text);
    createBuku.jumlah = int.parse(_jumlahTextboxController.text);
    createBuku.tanggalMasuk = _tanggalMasukTextboxController.text;
    createBuku.volume = int.parse(_volumeTextboxController.text);
    createBuku.penulis = _penulisTextboxController.text;
    createBuku.penerbit = _penerbitTextboxController.text;
    BukuBloc.addBuku(buku: createBuku).then((value) {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const BukuPage(),
        ),
      );
    }, onError: (error) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: 'Simpan gagal, silahkan coba lagi',
        ),
      );
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Buku updateBuku = Buku(id: widget.buku!.id!);
    updateBuku.judul = _judulTextboxController.text;
    updateBuku.harga = int.parse(_hargaTextboxController.text);
    updateBuku.jumlah = int.parse(_jumlahTextboxController.text);
    updateBuku.tanggalMasuk = _tanggalMasukTextboxController.text;
    updateBuku.volume = int.parse(_volumeTextboxController.text);
    updateBuku.penulis = _penulisTextboxController.text;
    updateBuku.penerbit = _penerbitTextboxController.text;
    BukuBloc.updateBuku(buku: updateBuku).then((value) {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const BukuPage(),
        ),
      );
    }, onError: (error) {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: 'Permintaan ubah data gagal, silahkan coba lagi',
        ),
      );
    });
  }
}