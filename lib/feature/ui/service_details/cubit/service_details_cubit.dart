import 'package:cure_app/core/errors/failures.dart';
import 'package:cure_app/domain/use_cases/booking_service_use_case.dart';
import 'package:cure_app/feature/ui/service_details/cubit/service_details_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ServiceDetailsCubit extends Cubit<ServiceDetailsStates> {
  ServiceDetailsCubit({required this.bookingServiceUseCase})
    : super(ServiceDetailsInitStates());
  BookingServiceUseCase bookingServiceUseCase;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController clinicalRemarksController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String? selectedDate;
  String? selectedTime;

  void bookService({
    required String serviceId,
    required String serviceName,
    required String servicePrice,
  }) async {
    if (formKey.currentState!.validate()) {
      emit(ServiceDetailsLoadingStates());
      if (selectedDate == null || selectedTime == null) {
        emit(
          ServiceDetailsErrorStates(
            failure: Failures(errorMessage: 'Please Select Date And Time'),
          ),
        );
      } else {
        var either = await bookingServiceUseCase.invoke(
          serviceId: serviceId,
          serviceName: serviceName,
          clinicalRemarks: clinicalRemarksController.text,
          address: addressController.text,
          date: selectedDate!,
          time: selectedTime!,
          servicePrice: servicePrice,
        );
        either.fold(
          (failure) => emit(ServiceDetailsErrorStates(failure: failure)),
          (response) => emit(
            ServiceDetailsSuccessStates(bookingServiceResponseEntity: response),
          ),
        );
      }
    }
  }
}
