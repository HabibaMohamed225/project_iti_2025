import 'dart:async';
import 'dart:convert';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_iti_2025/core/constants/app_strings.dart';
import 'package:project_iti_2025/data/models/product_model.dart';
import 'package:project_iti_2025/data/repositories/product_repo.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo productRepo;
  StreamSubscription? _productsSubscription;
  final String apiKey = "17b300bdc6d26490ff86c5fe46f68964";
  bool _isUploadCancelled = false;

  ProductBloc(this.productRepo) : super(ProductInitialState()) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<ProductsLoadedInternally>(_onProductsLoadedInternally);
    on<AddProductEvent>(_onAddProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
    on<UploadImageEvent>(_onUploadImage);
    on<CancelUploadEvent>(_onCancelUpload);
  }

  Future<void> _onLoadProducts(
    LoadProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    await _productsSubscription?.cancel();
    _productsSubscription = productRepo.getProducts().listen((products) {
      add(ProductsLoadedInternally(products));
    });
  }

  void _onProductsLoadedInternally(
    ProductsLoadedInternally event,
    Emitter<ProductState> emit,
  ) {
    emit(ProductLoadedState(event.products));
  }

  Future<void> _onAddProduct(
    AddProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      await productRepo.addProduct(event.product);
      emit(const ProductSuccessState(AppStrings.productAdded));
    } catch (e) {
      emit(const ProductErrorState(AppStrings.productAdditionFailed));
    }
  }

  Future<void> _onUpdateProduct(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      await productRepo.updateProduct(event.product);
      emit(const ProductSuccessState(AppStrings.productUpdated));
    } catch (e) {
      emit(const ProductErrorState(AppStrings.productUpdateFailed));
    }
  }

  Future<void> _onDeleteProduct(
    DeleteProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      await productRepo.deleteProduct(event.productId);
      emit(const ProductSuccessState(AppStrings.productRemoved));
    } catch (e) {
      emit(const ProductErrorState(AppStrings.productDeletionFailed));
    }
  }

  Future<void> _onUploadImage(
    UploadImageEvent event,
    Emitter<ProductState> emit,
  ) async {
    _isUploadCancelled = false;
    emit(ProductUploadingImageState());
    try {
      Uint8List imageBytes;
      if (kIsWeb) {
        imageBytes = await event.pickedFile.readAsBytes();
      } else {
        imageBytes = File(event.pickedFile.path).readAsBytesSync();
      }

      String base64Image = base64Encode(imageBytes);
      var url = Uri.parse("https://api.imgbb.com/1/upload?key=$apiKey");
      var response = await http.post(url, body: {"image": base64Image});

      if (_isUploadCancelled) return;

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        String imageUrl = jsonResponse['data']['url'];
        emit(ProductImageUploadedState(imageUrl));
      } else {
        emit(ProductImageUploadErrorState(
            "${AppStrings.imageUploadFailed}${response.body}"));
      }
    } catch (e) {
      if (!_isUploadCancelled) {
        emit(ProductImageUploadErrorState(e.toString()));
      }
    }
  }

  void _onCancelUpload(
    CancelUploadEvent event,
    Emitter<ProductState> emit,
  ) {
    _isUploadCancelled = true;
    add(LoadProductsEvent());
    emit(ProductInitialState());
  }

  @override
  Future<void> close() {
    _productsSubscription?.cancel();
    return super.close();
  }

  // @override
  // Future<void> close() {
  //   _productsSubscription?.cancel();
  //   return super.close();
  // }
}
