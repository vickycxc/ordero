import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderFormat {
  const OrderFormat({
    required this.id,
    required this.namaBarang,
    required this.barangId,
    required this.kuantitas,
    required this.pembeli,
    required this.ongkir,
    required this.harga,
    required this.total,
    required this.dateCreated,
    required this.orderStatus,
    this.dateFinished,
  });

  final String id;
  final String namaBarang;
  final String barangId;
  final int kuantitas;
  final Pembeli pembeli;
  final int ongkir;
  final int harga;
  final int total;
  final Timestamp dateCreated;
  final String orderStatus;
  final String? dateFinished;

  factory OrderFormat.fromMap(Map<String, dynamic> s, String id) {
    return OrderFormat(
        id: id,
        barangId: s['barang_id'],
        namaBarang: s['nama_barang'],
        kuantitas: s['kuantitas'],
        pembeli: Pembeli.fromMap(s['pembeli']),
        ongkir: s['ongkir'],
        harga: s['harga'],
        total: s['total'],
        dateCreated: s['date_created'],
        orderStatus: s['order_status'],
        dateFinished: s['date_finished']
    );
  }
}

class Pembeli {
  const Pembeli({
    required this.nama,
    required this.kontak,
    required this.alamat,
    required this.koordinat,
    required this.jarak,
    required this.polyline,
    required this.bounds,
  });

  final String nama;
  final String kontak; //Kontak itu bisa no wa, ig, id line, dll
  final String alamat;
  final GeoPoint koordinat;
  final double jarak;
  final String polyline;
  final LatLngBounds bounds;

  factory Pembeli.fromMap(Map<String, dynamic> p) {
    GeoPoint ne = p['bounds']['northeast'];
    GeoPoint sw = p['bounds']['southwest'];
    return Pembeli(
      nama: p['nama'],
      alamat: p['alamat'],
      jarak: p['jarak'],
      kontak: p['kontak'],
      koordinat: p['koordinat'],
      polyline: p['polylines'],
      bounds: LatLngBounds(northeast: LatLng(ne.latitude, ne.longitude), southwest: LatLng(sw.latitude, sw.longitude) )
    );
  }
}

class ItemBarang {
  const ItemBarang({
    required this.nama,
    required this.jumlah,
    required this.varian,
    required this.hargaSatuan,
    required this.totalHarga
  });

  final String nama;
  final int jumlah;
  final String? varian;
  final int hargaSatuan;
  final int totalHarga;
}

class Keuangan {
  // Map<String, int> pendapatanPerBulan;
  // Map<String, int> penjualanPerBulan;
  int totalPendapatan;
  int totalPenjualan;

  Keuangan({required this.totalPenjualan, required this.totalPendapatan});

  factory Keuangan.fromMap(Map<String, dynamic> k) {
    return Keuangan(
        totalPendapatan: k['total_pendapatan'],
        totalPenjualan: k['total_pembelian']
    );
  }
}

class KeuanganPerBulan {
  final int pendapatanPerBulan;
  final int penjualanPerBulan;

  const KeuanganPerBulan({
    required this.pendapatanPerBulan,
    required this.penjualanPerBulan
  });
}