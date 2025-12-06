import 'package:flutter/material.dart';
import 'package:responsi2_mobile_paket3_h1d023064/model/buku.dart';
import 'package:responsi2_mobile_paket3_h1d023064/ui/buku_detail.dart';
import 'package:responsi2_mobile_paket3_h1d023064/ui/buku_form.dart';
import 'package:responsi2_mobile_paket3_h1d023064/ui/login_page.dart';
import 'package:responsi2_mobile_paket3_h1d023064/bloc/logout_bloc.dart';
import 'package:responsi2_mobile_paket3_h1d023064/bloc/buku_bloc.dart';

class BukuPage extends StatefulWidget {
  const BukuPage({Key? key}) : super(key: key);

  @override
  _BukuPageState createState() => _BukuPageState();
}

class _BukuPageState extends State<BukuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventaris Buku Ibna'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => BukuForm()));
            },
          ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async{
                await LogoutBloc.logout().then((value) => {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage()),
                    (route) => false)
                });
              },
            )
          ],
        ),
      ),

      body: FutureBuilder<List<Buku>>(
        future: BukuBloc.getBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada buku'));
          } else {
            List<Buku> books = snapshot.data!;
            return ListBuku(list: books);
          }
        },
      ),
    );
  }
}

class ListBuku extends StatelessWidget {
  final List<Buku> list;
  
  const ListBuku({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length, 
      itemBuilder: (context, i) {
        return ItemBuku(
          buku: list[i],
        );
      },
    );
  }
}

class ItemBuku extends StatelessWidget {
  final Buku buku;
  const ItemBuku({Key? key, required this.buku}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BukuDetail(buku: buku),
          ),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(buku.judul!),
          subtitle: Text('Rp. ${buku.harga.toString()}'),
        ),
      ),
    );
  }
}