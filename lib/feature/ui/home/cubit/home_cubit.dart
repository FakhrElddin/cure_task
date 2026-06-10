import 'package:cure_app/feature/ui/home/cubit/home_states.dart';
import 'package:cure_app/feature/ui/home/tabs/bookings_tab/bookings_tab.dart';
import 'package:cure_app/feature/ui/home/tabs/home_tab/home_tab.dart';
import 'package:cure_app/feature/ui/home/tabs/profile_tab/profile_tab.dart';
import 'package:cure_app/feature/ui/home/tabs/chat_tab/chat_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit() : super(HomeInitState());

  List<Widget> tabs = [
    HomeTab(),
    BookingsTab(),
    ChatTab(),
    ProfileTab(),
  ];
  int currentIndex = 0;

  void changeBottomNavBar({required int index}){
    if(currentIndex != index){
      currentIndex = index;
      emit(HomeChangeBottomNavBarState());
    }
  }

}