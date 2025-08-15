import 'package:bloc/bloc.dart';
import 'delivery_event.dart';
import 'delivery_state.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  DeliveryBloc() : super(DeliveryInitial()) {
    on<SubmitDeliveryEvent>(_onSubmit);
  }

  Future<void> _onSubmit(
    SubmitDeliveryEvent event,
    Emitter<DeliveryState> emit,
  ) async {
    emit(DeliverySubmitting());
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(const DeliverySuccess('Delivery address saved successfully'));
    } catch (e) {
      emit(DeliveryFailure(e.toString()));
    }
  }
}
