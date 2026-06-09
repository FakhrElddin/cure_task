import 'package:cure_app/domain/entities/booking_service_response_entity.dart';

class BookingServiceResponseDM extends BookingServiceResponseEntity {
  BookingServiceResponseDM({
    super.createdAt,
    super.serviceId,
    super.clinicalRemarks,
    super.date,
    super.status,
    super.time,
    super.serviceName,
    super.address,
    super.id,
  });

  BookingServiceResponseDM.fromJson(dynamic json) {
    createdAt = json['createdAt'];
    serviceId = json['serviceId'];
    clinicalRemarks = json['clinicalRemarks'];
    date = json['date'];
    status = json['status'];
    time = json['time'];
    serviceName = json['serviceName'];
    address = json['address'];
    id = json['id'];
  }
}
