Nama: Ibna Oktavia Saputri<br>
NIM: H1D023064<br>
shift baru: C <br>
shift asal: F<br>

Video demo aplikasi:
https://github.com/user-attachments/assets/da616271-1543-45ac-8931-57c1271d5f08

### API Spesification & Penjelasan Kode

1. Spesifikasi API
   <br>API ini digunakan untuk mengelola data buku dalam aplikasi Inventaris Buku. API ini menyediakan beberapa endpoint untuk melakukan operasi CRUD (Create, Read, Update, Delete) pada data buku. API dikembangkan menggunakan CodeIgniter dengan Base URL: http://192.168.100.83:8080/buku-api/public <br>

   1.1. Register
   - URL: /registrasi
   - Method: POST
   - Description: Mendaftarkan pengguna baru.
   - Request Body:
     ```
      {
        "email": "user@example.com",
        "password": "password123",
        "name": "Administrator"
      }
      ```
   - Response:
     ```
     {
        "code": 200,
        "status": true,
        "message": "User successfully registered"
      }

     ```

   1.2. Login
   - URL: /login
   - Method: POST
   - Description: Melakukan login untuk mendapatkan JWT Token.
   - Request Body:
     ```
      {
        "email": "user@example.com",
        "password": "password123"
      }

      ```
   - Response:
     ```
     {
        "code": 200,
        "status": true,
        "data": {
          "token": "your_jwt_token_here"
        }
      }
     ```

   1.3. List Buku
   - URL: /buku
   - Method: GET
   - Description: Mengambil daftar semua buku.
   - Response:
     ```
     {
        "code": 200,
        "status": true,
        "data": [
        {
            "id": 1,
            "judul": "Belajar Flutter",
            "harga": 200000,
            "jumlah": 50,
            "tanggal_masuk": "2025-12-01",
            "volume": 1,
            "penulis": "John Doe",
            "penerbit": "FlutterPress"
          },
          {
            "id": 2,
            "judul": "Belajar Dart",
            "harga": 150000,
            "jumlah": 30,
            "tanggal_masuk": "2025-11-01",
            "volume": 1,
            "penulis": "Jane Doe",
            "penerbit": "DartPress"
          }
        ]
      }
     ```

   1.4. Create Buku
   - URL: /buku
   - Method: POST
   - Description: Menambahkan buku baru ke dalam inventaris.
   - Request Body:
     ```
     {
        "judul": "Belajar Flutter",
        "harga": 200000,
        "jumlah": 50,
        "tanggal_masuk": "2025-12-01",
        "volume": 1,
        "penulis": "John Doe",
        "penerbit": "FlutterPress"
      }
     ```
   - Response:
     ```
     {
        "code": 200,
        "status": true,
        "message": "Book added successfully"
      }

     ```

   1.5. Update Buku
   - URL: /buku/{id}
   - Method: PUT
   - Description: Memperbarui informasi buku berdasarkan ID.
   - Request Body:
     ```
     {
        "judul": "Belajar Flutter - Update",
        "harga": 250000,
        "jumlah": 60,
        "tanggal_masuk": "2025-12-02",
        "volume": 2,
        "penulis": "John Doe",
        "penerbit": "FlutterPress"
      }
      ```
   - Response:
      ```
      {
        "code": 200,
        "status": true,
        "message": "Book updated successfully"
      }
      ```

   1.6. Delete Book
   - URL: /buku/{id}
   - Method: DELETE
   - Description: Menghapus buku berdasarkan ID.
   - Response:
     ```
     {
        "code": 200,
        "status": true,
        "message": "Book deleted successfully"
      }
     ```


2. Penjelasan Kode untuk tiap Fungsi Aplikasi
   <br>2.1. BukuBloc
   <br>BukuBloc berfungsi untuk mengelola interaksi dengan API untuk operasi CRUD pada buku. Berikut adalah penjelasan fungsi utama dalam BukuBloc.

   <br>a. Fungsi getBooks():
   <br>Mendapatkan daftar buku dari API.
   ```
   static Future<List<Buku>> getBooks() async {
      String apiUrl = ApiUrl.listBuku;  // URL untuk mengambil data buku
      var response = await Api().get(apiUrl);  // Mengirim request GET
      var jsonObj = json.decode(response.body);  // Decode JSON
      List<dynamic> listBuku = (jsonObj as Map<String, dynamic>)['data'];  // Ambil data buku
      List<Buku> books = [];
      for (int i = 0; i < listBuku.length; i++) {
        books.add(Buku.fromJson(listBuku[i]));  // Convert JSON ke objek Buku
      }
      return books;  // Kembalikan list buku
    }
   ```

   b. Fungsi addBuku():
   <br>Menambahkan buku baru ke API.
   ```
   static Future addBuku({Buku? buku}) async {
      String apiUrl = ApiUrl.createBuku;  // URL untuk menambah buku
      var body = {
        'judul': buku!.judul,
        'harga': buku.harga.toString(),
        'jumlah': buku.jumlah,
        'tanggal_masuk': buku.tanggalMasuk,
        'volume': buku.volume,
        'penulis': buku.penulis,
        'penerbit': buku.penerbit,
      };
      var response = await Api().post(apiUrl, body);  // Mengirim request POST
      var jsonObj = json.decode(response.body);  // Decode response
      return jsonObj['status'];  // Mengembalikan status response
    }
   ```

   c. Fungsi updateBuku():
   <br>Memperbarui data buku berdasarkan ID.
   ```
   static Future updateBuku({required Buku buku}) async {
      String apiUrl = ApiUrl.updateBuku(int.parse(buku.id!));  // URL untuk update buku
      var body = {
        'judul': buku.judul,
        'harga': buku.harga.toString(),
        'jumlah': buku.jumlah,
        'tanggal_masuk': buku.tanggalMasuk,
        'volume': buku.volume,
        'penulis': buku.penulis,
        'penerbit': buku.penerbit,
      };
      var response = await Api().put(apiUrl, jsonEncode(body));  // Mengirim request PUT
      var jsonObj = json.decode(response.body);  // Decode response
      return jsonObj['status'];  // Mengembalikan status response
    }
   ```

   d. Fungsi deleteBuku():
   <br>Menghapus buku berdasarkan ID.
   ```
   static Future<bool> deleteBuku({int? id}) async {
      String apiUrl = ApiUrl.deleteBuku(id!);  // URL untuk delete buku
      var response = await Api().delete(apiUrl);  // Mengirim request DELETE
      var jsonObj = json.decode(response.body);  // Decode response
      return (jsonObj as Map<String, dynamic>)['data'];  // Mengembalikan status penghapusan
    }
   ```
