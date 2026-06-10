import 'package:cure_app/domain/use_cases/get_services_use_case.dart';
import 'package:cure_app/feature/ui/home/tabs/home_tab/cubit/home_tab_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeTabCubit extends Cubit<HomeTabStates> {
  HomeTabCubit({required this.getServicesUseCase}) : super(HomeTabInitState());
  GetServicesUseCase getServicesUseCase;

  void getServices() async {
    var either = await getServicesUseCase.invoke();
    either.fold(
      (failure) => emit(HomeTabErrorState(failure: failure)),
      (response) => emit(HomeTabSuccessState(servicesResponseEntity: response)),
    );
  }
}
