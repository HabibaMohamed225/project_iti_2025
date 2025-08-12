part of 'admin_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<Product> products;

  const ProductLoadedState(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductErrorState extends ProductState {
  final String message;

  const ProductErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductSuccessState extends ProductState {
  final String message;

  const ProductSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductUploadingImageState extends ProductState {}

class ProductImageUploadedState extends ProductState {
  final String imageUrl;
  const ProductImageUploadedState(this.imageUrl);

  @override
  List<Object?> get props => [imageUrl];
}

class ProductImageUploadErrorState extends ProductState {
  final String error;
  const ProductImageUploadErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
