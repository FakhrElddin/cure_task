import 'package:cure_app/core/di/di.dart';
import 'package:cure_app/core/utils/app_assets.dart';
import 'package:cure_app/core/utils/app_colors.dart';
import 'package:cure_app/core/utils/app_routes.dart';
import 'package:cure_app/core/utils/app_styles.dart';
import 'package:cure_app/core/utils/app_validators.dart';
import 'package:cure_app/core/utils/dialog_utils.dart';
import 'package:cure_app/domain/entities/services_response_entity.dart';
import 'package:cure_app/feature/ui/service_details/cubit/service_details_cubit.dart';
import 'package:cure_app/feature/ui/service_details/cubit/service_details_states.dart';
import 'package:cure_app/feature/ui/widgets/custom_text_button.dart';
import 'package:cure_app/feature/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ServiceDetailsScreen extends StatefulWidget {
  const ServiceDetailsScreen({super.key});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  ServiceDetailsCubit viewModel = getIt<ServiceDetailsCubit>();

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as ServicesResponseEntity;

    return BlocListener<ServiceDetailsCubit, ServiceDetailsStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is ServiceDetailsErrorStates) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            message: state.failure.errorMessage,
            title: 'ERROR',
            posActionName: 'OK',
          );
        } else if (state is ServiceDetailsSuccessStates) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            barrierDismissible: false,
            message: 'successfully Booking',
            title: 'SUCCESS',
            posActionName: 'OK',
            posAction: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.homeRoute,
                (route) => false,
              );
            },
          );
        } else {
          DialogUtils.showLoading(context: context, message: 'Please Wait');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Service Details', style: AppStyles.bold26Text),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Form(
            key: viewModel.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Image.asset(
                          height: 180.h,
                          width: double.infinity,
                          AppAssets.servicesImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 100.0.w),
                        child: Text(
                          args.name!,
                          style: AppStyles.semiBold20Text.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text('About Service', style: AppStyles.semiBold24Text),
                  SizedBox(height: 12.h),
                  Text(
                    args.description!,
                    style: AppStyles.regular18Text.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Price : ${args.price} EGP',
                    style: AppStyles.semiBold24Text,
                  ),
                  SizedBox(height: 30.h),
                  CustomTextFormField(
                    fieldName: 'Clinical Remarks',
                    hintText:
                        'e.g., Patient has diabetes, high blood pressure, or requires specific care...',
                    maxLines: 5,
                    fillColor: AppColors.greyColor.withValues(alpha: 0.2),
                    validator: AppValidators.validateFullName,
                    controller: viewModel.clinicalRemarksController,
                  ),
                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    fieldName: 'Address',
                    hintText: 'Enter Your Address',
                    fillColor: AppColors.greyColor.withValues(alpha: 0.2),
                    validator: AppValidators.validateFullName,
                    controller: viewModel.addressController,
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () async {
                          DateTime? dateTime = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030),
                          );
                          if (dateTime != null) {
                            viewModel.selectedDate = DateFormat(
                              'yyyy-MM-dd',
                            ).format(dateTime);
                          } else {
                            viewModel.selectedDate = null;
                          }
                        },
                        child: Text(
                          viewModel.selectedDate ?? 'Select Date',
                          style: AppStyles.semiBold20Text.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          TimeOfDay? time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (time != null) {
                            viewModel.selectedTime =
                                "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                          } else {
                            viewModel.selectedTime = null;
                          }
                        },
                        child: Text(
                          viewModel.selectedTime ?? 'Select Time',
                          style: AppStyles.semiBold20Text.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  CustomTextButton(
                    text: 'Confirm Booking',
                    onPressed: () {
                      viewModel.bookService(
                        serviceId: args.id.toString(),
                        serviceName: args.name!,
                      );
                    },
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
