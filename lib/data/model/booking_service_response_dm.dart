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
    super.servicePrice,
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
    servicePrice = json['servicePrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = super.createdAt;
    data['serviceId'] = super.serviceId;
    data['serviceName'] = super.serviceName;
    data['servicePrice'] = super.servicePrice;
    data['clinicalRemarks'] = super.clinicalRemarks;
    data['address'] = super.address;
    data['date'] = super.date;
    data['time'] = super.time;
    data['status'] = super.status;
    data['id'] = super.id;
    return data;
  }
}
