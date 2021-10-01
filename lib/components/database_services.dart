// import 'dart:html';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class DatabaseServices {
//   static final CollectionReference productCollection =
//       FirebaseFirestore.instance.collection('products');
//
//   static Future<void> createOrderProduct(String id,
//       {required String name, required int price}) async {
//     await productCollection.doc(id).set({
//       'nama': name,
//       'harga': price,
//     });
//   }
//
//   static Future<DocumentSnapshot> getProduct(String id) async {
//     return await productCollection.doc(id).get();
//   }
//
//   static Future<void> deleteProduct(String id) async {
//     await productCollection.doc(id).delete();
//   }
//
//   static Future<String> uploadImage(File imageFile) async {
//     String fileName = imageFile.relativePath!;
// StorageReference ref = FirebaseStorage!
//   }
// }
