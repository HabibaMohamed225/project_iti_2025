import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuInitial()) {
    on<FetchMenuEvent>(_onFetchMenu);
  }

  Future<void> _onFetchMenu(
      FetchMenuEvent event, Emitter<MenuState> emit) async {
    emit(MenuLoading());

    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('products').get();

      if (snapshot.docs.isEmpty) {
        emit(MenuLoaded(const []));
        return;
      }

      final menuItems = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          'name': data['name'] ?? '',
          'description': data['description'] ?? '',
          'imageUrl': data['imageUrl'] ?? '',
          'price': data['price'] ?? 0,
        };
      }).toList();

      emit(MenuLoaded(menuItems));
    } catch (e) {
      emit(MenuError('Failed to fetch menu: $e'));
    }
  }
}
