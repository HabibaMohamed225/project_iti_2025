import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_iti_2025/data/models/product_model.dart';

class ProductRepo {
  final CollectionReference _products = FirebaseFirestore.instance.collection(
    'products',
  );

  Future<void> addProduct(Product product) async {
    final docRef = await _products.add(product.toFirestore());
    await _products.doc(docRef.id).update({'id': docRef.id});
  }

  Future<void> updateProduct(Product product) async {
    await _products.doc(product.id).update(product.toFirestore());
  }

  Future<void> deleteProduct(String id) async {
    await _products.doc(id).delete();
  }

  Stream<List<Product>> getProducts() {
    return _products.snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Product.fromFirestore(
                  doc.id,
                  doc.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }
}
