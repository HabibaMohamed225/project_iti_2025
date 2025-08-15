part of 'admin_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object?> get props => [];
}

class LoadProductsEvent extends ProductEvent {}

class CancelUploadEvent extends ProductEvent {}

class AddProductEvent extends ProductEvent {
  final Product product;
  const AddProductEvent(this.product);
  @override
  List<Object?> get props => [product];
}

class UpdateProductEvent extends ProductEvent {
  final Product product;
  const UpdateProductEvent(this.product);
  @override
  List<Object?> get props => [product];
}

class DeleteProductEvent extends ProductEvent {
  final String productId;
  const DeleteProductEvent(this.productId);
  @override
  List<Object?> get props => [productId];
}

class ProductsLoadedInternally extends ProductEvent {
  final List<Product> products;
  const ProductsLoadedInternally(this.products);
  @override
  List<Object?> get props => [products];
}

class UploadImageEvent extends ProductEvent {
  final XFile pickedFile;
  const UploadImageEvent(this.pickedFile);
  @override
  List<Object?> get props => [pickedFile];
}
