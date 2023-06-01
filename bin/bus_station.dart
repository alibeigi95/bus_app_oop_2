import 'dart:io';
import 'bus.dart';
import 'travel.dart';
import 'vip_bus.dart';
import 'normal_bus.dart';
import 'seat.dart';

class BusStation {
  final List<Bus>? buses;
  final List<Travel>? travel;

  BusStation({required this.buses, required this.travel});

  void addTravel(){
    travel!.add(_createTravel());
  }

  Travel _createTravel() {
    String? travelDetails = _getTravelDetails();
    double price = _getPrice();
    _showBus();
    int busNumber = _getBusNumber();
    busNumber -=1;
    if (buses![busNumber].seatCount == 25) {
      List<Seat> seats = _numberOfSeatList(25);
      Bus bus = buses![busNumber];
      price = price *1.4;
      Travel travel = Travel(
          travelDetails: travelDetails, seats: seats, bus: bus, price: price.toInt());
      return travel;
    } else {
      List<Seat> seats = _numberOfSeatList(44);
      Bus bus = buses![busNumber];
      Travel travel = Travel(
          travelDetails: travelDetails, seats: seats, bus: bus, price: price.toInt());
      return travel;
    }
  }

  List<Seat> _numberOfSeatList(int seatsNumber) {
    final List<Seat> busSeats = [];
    for (int i = 0; i < seatsNumber; i++) {
      int seatNumber = i + 1;
      Seat seat = Seat(number: seatNumber, ticket: null);
      busSeats.add(seat);
    }
    return busSeats;
  }

  int _getBusNumber() {
    int? getBusNumber;
    while (true) {
      print('Please enter your bus number');
      getBusNumber = int.tryParse(stdin.readLineSync() ?? ' ');
      if (getBusNumber != null) {
        break;
      } else {
        print('enter the number valid number');
      }
    }
    return getBusNumber;
  }

  void _showBus() {
    for (int i = 0; i < buses!.length; i++) {
      int number = i;
      String busName = buses![i].name;
      print({'$number' '$busName'});
    }
  }

  String _getTravelDetails() {
    while (true) {
      String? travelDetails;
      print('enter your travel details ');
      travelDetails = stdin.readLineSync();
      if (travelDetails != null) {
        return travelDetails;
      } else {
        print('enter the valid bus name');
      }
    }
  }

  double _getPrice() {
    double? getPrice;
    while (true) {
      print('Please enter your bus price');
      getPrice = double.tryParse(stdin.readLineSync() ?? ' ');
      if (getPrice != null) {
        break;
      } else {
        print('enter the valid price');
      }
    }
    return getPrice;
  }

  void addBuses() {
    buses?.add(_createBus());
  }

  Bus _createBus() {
    String? busName;
    int busType;
    busName = _getBusName();
    busType = _getNumberForBusType();
    switch (busType) {
      case 1:
        VipBus createVipBus = VipBus(name: busName);
        return createVipBus;
      case 2:
        NormalBus createNormalBus = NormalBus(name: busName);
        return createNormalBus;
      default:
        NormalBus createNormalBus = NormalBus(name: busName);
        return createNormalBus;
    }
  }

  String _getBusName() {
    while (true) {
      String? busName;
      print('enter your bus name:');
      busName = stdin.readLineSync();
      if (busName != null) {
        if (_validateBusName(name: busName)) {
          return busName;
        } else {
          print('your name is exist');
        }
      } else {
        print('enter the valid bus name');
      }
    }
  }

  bool _validateBusName({required String name}) {
    bool isValid = true;
    if (buses != null) {
      for (int i = 0; i < buses!.length; i++) {
        if (buses![i].name == name) {
          return isValid == false;
        }
      }
    } else {
      isValid == true;
    }
    return isValid;
  }

  int _getNumberForBusType() {
    int? numberForBusType;
    while (true) {
      print('Please enter your bus type 1:vip   2:normal');
      numberForBusType = int.tryParse(stdin.readLineSync() ?? ' ');
      if (numberForBusType != null &&
          numberForBusType > 0 &&
          numberForBusType < 3) {
        break;
      } else {
        print('enter the number between 1 or 2');
      }
    }
    return numberForBusType;
  }
}
