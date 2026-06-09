import 'package:bloc/bloc.dart';
import 'package:cure_app/domain/use_cases/get_bookings_use_case.dart';
import 'package:cure_app/feature/ui/home/tabs/bookings_tab/cubit/booking_tab_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class BookingsTabCubit extends Cubit<BookingsTabStates>{
  BookingsTabCubit({required this.getBookingsUseCase}) : super(BookingTabInitState());
  GetBookingsUseCase getBookingsUseCase;

  void getBookings() async{
    emit(BookingsTabLoadingState());
    var either = await getBookingsUseCase.invoke();
    either.fold(
          (failure) => emit(BookingsTabErrorState(failure: failure)),
          (response) => emit(BookingsTabSuccessState(bookings: response)),
    );
  }
}