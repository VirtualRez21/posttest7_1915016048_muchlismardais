// ignore_for_file: file_names, prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, avoid_unnecessary_containers, override_on_non_overriding_member, annotate_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posttest7_1915016048_muchlismardais/controller.dart';
import 'package:posttest7_1915016048_muchlismardais/main.dart';
import 'package:posttest7_1915016048_muchlismardais/updateFirebase.dart';

class ViewFirebase extends StatelessWidget {
  ViewFirebase({super.key});

  final GetxTeksController inputController = Get.put(GetxTeksController());
  final SimpanId idBuku = Get.put(SimpanId());
  final BahasaSelection inputRadio = Get.put(BahasaSelection());

  @override
  Widget judulKolomTabel(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
    );
  }

  Widget isiKolomTabel(String isi) {
    return Text(
      isi,
      textAlign: TextAlign.center,
    );
  }

  Widget iconAction(IconData ikon, Color warna) {
    return Icon(
      ikon,
      color: warna,
    );
  }

  Widget tombolIcon(String notif, IconData ikon, bool a) {
    return ElevatedButton(
      style: TextButton.styleFrom(
        backgroundColor: Color(0xff2e9db4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      onPressed: () {
        Get.snackbar(
          "Notifikasi",
          "Fitur belum tersedia",
          icon: Icon(Icons.checklist, color: Colors.blue),
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      child: Icon(
        ikon,
        color: Colors.white,
        size: 12,
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Buku Firebase", style: TextStyle(fontSize: 16.0)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Colors.orangeAccent, Colors.blue]),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          MyApp().gambarHeader(),
          MyApp().teksHeader("Data Buku Firebase"),
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("dataBuku").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, i) {
                      QueryDocumentSnapshot<Object?>? hasilData =
                          snapshot.data?.docs[i];
                      return Column(
                        children: [
                          Table(
                            border: TableBorder.lerp(
                              TableBorder(
                                top: BorderSide(width: 3, color: Colors.black),
                              ),
                              TableBorder(
                                bottom:
                                    BorderSide(width: 3, color: Colors.green),
                              ),
                              0.5,
                            ),
                            children: [
                              TableRow(children: [
                                judulKolomTabel("Nama"),
                                judulKolomTabel("Penulis"),
                                judulKolomTabel("Penerbit"),
                                judulKolomTabel("Desk"),
                                judulKolomTabel("ISBN"),
                                judulKolomTabel("Harga"),
                                judulKolomTabel("Jmlh. Hal"),
                                judulKolomTabel("Bhsa"),
                                judulKolomTabel("Edit"),
                                judulKolomTabel("Hapus"),
                              ]),
                              TableRow(children: [
                                isiKolomTabel(hasilData!['nama']),
                                isiKolomTabel(hasilData['penulis']),
                                isiKolomTabel(hasilData['penerbit']),
                                isiKolomTabel(hasilData['deskripsi']),
                                isiKolomTabel(hasilData['isbn']),
                                isiKolomTabel(hasilData['harga']),
                                isiKolomTabel(hasilData['halaman']),
                                isiKolomTabel(hasilData['bahasa']),
                                ElevatedButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Color(0xff2e9db4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.to(
                                      UpdateFirebase(),
                                    );
                                    idBuku.idBukuCtrl.text = hasilData.id;
                                    inputController.namaBukuCtrl.text =
                                        hasilData['nama'];
                                    inputController.penulisBukuCtrl.text =
                                        hasilData['penulis'];
                                    inputController.penerbitBukuCtrl.text =
                                        hasilData['penerbit'];
                                    inputController.deskripsiBukuCtrl.text =
                                        hasilData['deskripsi'];
                                    inputController.isbnBukuCtrl.text =
                                        hasilData['isbn'];
                                    inputController.hargaBukuCtrl.text =
                                        hasilData['harga'];
                                    inputController.jumlahHalamanBukuCtrl.text =
                                        hasilData['halaman'];
                                    inputRadio.ubahBahasa(hasilData['bahasa']);
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                                ElevatedButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Color(0xff2e9db4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("dataBuku")
                                        .doc(hasilData.id)
                                        .delete();
                                    Get.snackbar(
                                      "Notifikasi",
                                      "Data Berhasil Dihapus",
                                      icon: Icon(Icons.checklist,
                                          color: Colors.blue),
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ])
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 0, 255, 149),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
