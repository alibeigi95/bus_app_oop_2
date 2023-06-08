import 'dart:io';
import 'bus.dart';
import 'buy_ticket.dart';
import 'reserve_ticket.dart';
import 'ticket.dart';
import 'travel.dart';
import 'vip_bus.dart';
import 'normal_bus.dart';
import 'seat.dart';

class BusStation {
  final List<Bus>? buses;
  final List<Travel>? travel;

  BusStation({required this.buses, required this.travel});

  void getReports() {
    _showTravel();
    int getTravelNumber = _getTravelNumber();
    getTravelNumber = getTravelNumber - 1;
    if (travel![getTravelNumber].bus.seatCount == 25) {
      int reserveCount =
          _getTravelReserveReport(getTravelNumber: getTravelNumber);
      int buyCount = _getTravelBuyReport(getTravelNumber: getTravelNumber);
      int price = travel![getTravelNumber].price;
      double reservePrice = price * 0.3;
      reservePrice = reservePrice * reserveCount;
      int buyPrice = price * buyCount;
      int totalIncome = buyPrice + reservePrice.toInt();
      print('total-income:$totalIncome');
    } else {
      int reserveCount =
          _getTravelReserveReport(getTravelNumber: getTravelNumber);
      int buyCount = _getTravelBuyReport(getTravelNumber: getTravelNumber);
      int price = travel![getTravelNumber].price;
      double reservePrice = price * 0.3;
      reservePrice = reservePrice * reserveCount;
      int buyPrice = price * buyCount;
      int totalIncome = buyPrice + reservePrice.toInt();
      print('total-income:$totalIncome');
    }
  }

  int _getTravelReserveReport({required int getTravelNumber}) {
    int countInCome = 0;
    if (travel != null) {
      for (int i = 0; i < travel![getTravelNumber].seats.length; i++) {
        if (travel![getTravelNumber].seats[i].number == 'R') {
          countInCome += 1;
        }
      }
    }
    return countInCome;
  }

  int _getTravelBuyReport({required int getTravelNumber}) {
    int countInCome = 0;
    if (travel != null) {
      for (int i = 0; i < travel![getTravelNumber].seats.length; i++) {
        if (travel![getTravelNumber].seats[i].number == 'B') {
          countInCome += 1;
        }
      }
    }
    return countInCome;
  }

  void cancelTicket() {
    _showTravel();
    int getTravelNumber = _getTravelNumber();
    getTravelNumber = getTravelNumber - 1;
    List<Seat> busSeats = travel![getTravelNumber].seats;
    if (travel![getTravelNumber].bus.seatCount == 25) {
      _showVipBusSeats(travelNumber: getTravelNumber);
      int seatCancel = _getSeatNumberForCancelVip();
      int seatCancelNumber = seatCancel;
      seatCancel = seatCancel - 1;
      Seat seat = busSeats[seatCancel].copyWith(number: '$seatCancelNumber');
      seat.ticket = null;
      busSeats[seatCancel] = seat;
    } else {
      _showNormalBusSeats(travelNumber: getTravelNumber);
      int seatCancel = _getSeatNumberForCancelNormal();
      int seatCancelNumber = seatCancel;
      seatCancel = seatCancel - 1;
      Seat seat = busSeats[seatCancel].copyWith(number: '$seatCancelNumber');
      seat.ticket = null;
      busSeats[seatCancel] = seat;
    }
  }

  bool _validateCancelBus({required int cancelSeat}) {
    bool isValid = true;
    if (travel != null) {
      for (int i = 0; i < travel!.length; i++) {
        if (travel![i].seats[cancelSeat].number == 'B' ||
            travel![i].seats[cancelSeat].number == 'R') {
          return isValid == false;
        }
      }
    } else {
      isValid == true;
    }
    return isValid;
  }

  int _getSeatNumberForCancelVip() {
    int? getSeatNumberForCancelVip;
    while (true) {
      print('Please enter your seat number:');
      getSeatNumberForCancelVip = int.tryParse(stdin.readLineSync() ?? ' ');
      if (getSeatNumberForCancelVip != null &&
          getSeatNumberForCancelVip > 0 &&
          getSeatNumberForCancelVip < 26) {
        if (_validateCancelBus(cancelSeat: getSeatNumberForCancelVip - 1)) {
          print('your seat number is not bought or reserved');
        } else {
          print('your seat number is canceled');
          return getSeatNumberForCancelVip;
        }
        break;
      } else {
        print('enter the number valid number');
      }
    }
    return getSeatNumberForCancelVip;
  }

  int _getSeatNumberForCancelNormal() {
    int? getSeatNumberForCancelNormal;
    while (true) {
      print('Please enter your seat number:');
      getSeatNumberForCancelNormal = int.tryParse(stdin.readLineSync() ?? ' ');
      if (getSeatNumberForCancelNormal != null &&
          getSeatNumberForCancelNormal > 0 &&
          getSeatNumberForCancelNormal < 45) {
        if (_validateCancelBus(cancelSeat: getSeatNumberForCancelNormal - 1)) {
          print('your seat number is not bought or reserved');
        } else {
          print('your seat number is canceled');
          return getSeatNumberForCancelNormal;
        }
        break;
      } else {
        print('enter the number valid number');
      }
    }
    return getSeatNumberForCancelNormal;
  }

  void previewBus() {
    _showTravel();
    int getTravelNumber = _getTravelNumber();
    getTravelNumber = getTravelNumber - 1;
    if (travel![getTravelNumber].bus.seatCount == 25) {
      _showVipBusSeats(travelNumber: getTravelNumber);
    } else {
      _showNormalBusSeats(travelNumber: getTravelNumber);
    }
  }

  void buyTicket() {
    _showTravel();
    int getTravelNumber = _getTravelNumber();
    getTravelNumber = getTravelNumber - 1;
    List<Seat> busSeats = travel![getTravelNumber].seats;
    if (travel![getTravelNumber].bus.seatCount == 25) {
      _showVipBusSeats(travelNumber: getTravelNumber);
      int seatBuy = _getSeatNumberForBuyVip();
      seatBuy = seatBuy - 1;
      Seat seat = busSeats[seatBuy].copyWith(number: 'B');
      Ticket ticket = BuyTicket();
      seat.ticket = ticket;
      busSeats[seatBuy] = seat;
    } else {
      _showNormalBusSeats(travelNumber: getTravelNumber);
      int seatBuy = _getSeatNumberForBuyNormal();
      seatBuy = seatBuy - 1;
      Seat seat = busSeats[seatBuy].copyWith(number: 'B');
      Ticket ticket = BuyTicket();
      seat.ticket = ticket;
      busSeats[seatBuy] = seat;
    }
  }

  bool _validateBuyBus({required int seatBuy}) {
    bool isValid = true;
    if (travel != null) {
      for (int i = 0; i < travel!.length; i++) {
        if (travel![i].seats[seatBuy].number == 'B') {
          return isValid == false;
        }
      }
    } else {
      isValid == true;
    }
    return isValid;
  }

  int _getSeatNumberForBuyVip() {
    int? getSeatNumberForBuyVip;
    while (true) {
      print('Please enter your seat number:');
      getSeatNumberForBuyVip = int.tryParse(stdin.readLineSync() ?? ' ');
      if (getSeatNumberForBuyVip != null &&
          getSeatNumberForBuyVip > 0 &&
          getSeatNumberForBuyVip < 26) {
        if (_validateBuyBus(seatBuy: getSeatNumberForBuyVip - 1)) {
          return getSeatNumberForBuyVip;
        } else {
          print('your seat number is bought');
        }
        break;
      } else {
        print('enter the number valid number');
      }
    }
    return getSeatNumberForBuyVip;
  }

  int _getSeatNumberForBuyNormal() {
    int? getSeatNumberForBuyNormal;
    while (true) {
      print('Please enter your seat number:');
      getSeatNumberForBuyNormal = int.tryParse(stdin.readLineSync() ?? ' ');
      if (getSeatNumberForBuyNormal != null &&
          getSeatNumberForBuyNormal > 0 &&
          getSeatNumberForBuyNormal < 45) {
        if (_validateBuyBus(seatBuy: getSeatNumberForBuyNormal - 1)) {
          return getSeatNumberForBuyNormal;
        } else {
          print('your seat number is bought');
        }
        break;
      } else {
        print('enter the number valid number');
      }
    }
    return getSeatNumberForBuyNormal;
  }

  void reserveTicket() {
    _showTravel();
    int getTravelNumber = _getTravelNumber();
    getTravelNumber = getTravelNumber - 1;
    List<Seat> busSeats = travel![getTravelNumber].seats;
    if (travel![getTravelNumber].bus.seatCount == 25) {
      _showVipBusSeats(travelNumber: getTravelNumber);
      int seatReserve = _getSeatNumberForReserveVip();
      seatReserve = seatReserve - 1;
      Seat seat = busSeats[seatReserve].copyWith(number: 'R');
      Ticket ticket = ReserveTicket();
      seat.ticket = ticket;
      busSeats[seatReserve] = seat;
    } else {
      _showNormalBusSeats(travelNumber: getTravelNumber);
      int seatReserve = _getSeatNumberForReserveNormal();
      seatReserve = seatReserve - 1;
      Seat seat = busSeats[seatReserve].copyWith(number: 'R');
      Ticket ticket = ReserveTicket();
      seat.ticket = ticket;
      busSeats[seatReserve] = seat;
    }
  }

  bool _validateReserveBus({required int seatReserve}) {
    bool isValid = true;
    if (travel != null) {
      for (int i = 0; i < travel!.length; i++) {
        if (travel![i].seats[seatReserve].number == 'R') {
          return isValid == false;
        }
      }
    } else {
      isValid == true;
    }
    return isValid;
  }

  int _getSeatNumberForReserveVip() {
    int? getSeatNumberForReserveVip;
    while (true) {
      print('Please enter your seat number:');
      getSeatNumberForReserveVip = int.tryParse(stdin.readLineSync() ?? ' ');
      if (getSeatNumberForReserveVip != null &&
          getSeatNumberForReserveVip > 0 &&
          getSeatNumberForReserveVip < 26) {
        if (_validateReserveBus(seatReserve: getSeatNumberForReserveVip - 1)) {
          return getSeatNumberForReserveVip;
        } else {
          print('your seat number is reserved');
        }
        break;
      } else {
        print('enter the number valid number');
      }
    }
    return getSeatNumberForReserveVip;
  }

  int _getSeatNumberForReserveNormal() {
    int? getSeatNumberForReserveNormal;
    while (true) {
      print('Please enter your seat number:');
      getSeatNumberForReserveNormal = int.tryParse(stdin.readLineSync() ?? ' ');
      if (getSeatNumberForReserveNormal != null &&
          getSeatNumberForReserveNormal > 0 &&
          getSeatNumberForReserveNormal < 45) {
        if (_validateReserveBus(
            seatReserve: getSeatNumberForReserveNormal - 1)) {
          return getSeatNumberForReserveNormal;
        } else {
          print('your seat number is reserved');
        }
        break;
      } else {
        print('enter the number valid number');
      }
    }
    return getSeatNumberForReserveNormal;
  }

  void _showNormalBusSeats({required int travelNumber}) {
    final List<Seat> busSeats = travel![travelNumber].seats;
    int count = -1;
    String busSeat;
    for (int i = 1; i <= 7; i++) {
      for (int j = 1; j <= 5; j++) {
        if (j == 3) {
          stdout.write('  ');
        } else {
          count += 1;
          busSeat = busSeats[count].number;
          stdout.write('[$busSeat]');
        }
      }
      stdout.write('\n');
    }
    for (int i = 1; i <= 5; i++) {
      for (int j = 1; j <= 5; j++) {
        if (i == 1 && j == 3) {
          stdout.write('  ');
        } else if (i == 1 && j == 4) {
          stdout.write('  ');
        } else if (i == 1 && j == 5) {
          stdout.write('  ');
        } else if (i == 2 && j == 4) {
          stdout.write('  ');
        } else if (i == 2 && j == 5) {
          stdout.write('  ');
        } else if (i == 2 && j == 3) {
          stdout.write('  ');
        } else if (i == 3 && j == 3) {
          stdout.write('  ');
        } else if (i == 4 && j == 3) {
          stdout.write('  ');
        } else if (i == 5 && j == 3) {
          stdout.write('  ');
        } else {
          count += 1;
          busSeat = busSeats[count].number;
          stdout.write('[$busSeat]');
        }
      }
      stdout.write('\n');
    }
  }

  void _showVipBusSeats({required int travelNumber}) {
    final List<Seat> busSeats = travel![travelNumber].seats;
    int count = -1;
    String busSeat;
    for (int i = 1; i <= 5; i++) {
      for (int j = 1; j <= 4; j++) {
        if (j == 2) {
          stdout.write('   ');
        } else {
          count += 1;
          busSeat = busSeats[count].number;
          stdout.write('[$busSeat]');
        }
      }
      stdout.write('\n');
    }
    for (int i = 1; i <= 4; i++) {
      for (int j = 1; j <= 4; j++) {
        if (i == 1 && j == 2) {
          stdout.write('   ');
        } else if (i == 1 && j == 3) {
          stdout.write('   ');
        } else if (i == 1 && j == 4) {
          stdout.write('   ');
        } else if (i == 2 && j == 2) {
          stdout.write('   ');
        } else if (i == 3 && j == 2) {
          stdout.write('   ');
        } else if (i == 4 && j == 2) {
          stdout.write('   ');
        } else {
          count += 1;
          busSeat = busSeats[count].number;
          stdout.write('[$busSeat]');
        }
      }
      stdout.write('\n');
    }
  }

  int _getTravelNumber() {
    int? getTravelNumber;
    while (true) {
      print('Please enter your travel number');
      getTravelNumber = int.tryParse(stdin.readLineSync() ?? ' ');
      if (getTravelNumber != null && getTravelNumber > 0) {
        break;
      } else {
        print('enter the number valid number');
      }
    }
    return getTravelNumber;
  }

  void _showTravel() {
    if (travel != null) {
      for (int i = 0; i < travel!.length; i++) {
        int number = i;
        number += 1;
        String travelDetails = travel![i].travelDetails;
        String busName = buses![i].name;
        int price = travel![i].price;
        print({
          '$number:'
              'travel-detail:$travelDetails'
              ' '
              'bus-name:$busName'
              ' '
              'bus-price:$price'
        });
      }
    } else {
      print('there is no travel is added');
    }
  }

  void addTravel() {
    travel!.add(_createTravel());
  }

  Travel _createTravel() {
    String? travelDetails = _getTravelDetails();
    double price = _getPrice();
    _showBus();
    int busNumber = _getBusNumber();
    busNumber -= 1;
    if (buses![busNumber].seatCount == 25) {
      List<Seat> seats = _numberOfSeatList(25);
      Bus bus = buses![busNumber];
      price = price * 1.4;
      Travel travel = Travel(
          travelDetails: travelDetails,
          seats: seats,
          bus: bus,
          price: price.toInt());
      return travel;
    } else {
      List<Seat> seats = _numberOfSeatList(44);
      Bus bus = buses![busNumber];
      Travel travel = Travel(
          travelDetails: travelDetails,
          seats: seats,
          bus: bus,
          price: price.toInt());
      return travel;
    }
  }

  List<Seat> _numberOfSeatList(int seatsNumber) {
    final List<Seat> busSeats = [];
    for (int i = 0; i < seatsNumber; i++) {
      int seatsNumber = i + 1;
      String seatNumber = '$seatsNumber';
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
      if (getBusNumber != null && getBusNumber > 0) {
        break;
      } else {
        print('enter the number valid number');
      }
    }
    return getBusNumber;
  }

  void _showBus() {
    if (buses!.isEmpty) {
      for (int i = 0; i < buses!.length; i++) {
        int number = i;
        number += 1;
        String busName = buses![i].name;
        print({'$number:' 'bus-name:' '$busName'});
      }
    } else {
      print('no buses is added');
    }
  }

  String _getTravelDetails() {
    while (true) {
      String? travelDetails;
      print('enter your travel details ');
      travelDetails = stdin.readLineSync();
      if (travelDetails != null &&
          travelDetails != '' &&
          travelDetails != ' ') {
        return travelDetails;
      } else {
        print('enter the valid travel details');
      }
    }
  }

  double _getPrice() {
    double? getPrice;
    while (true) {
      print('Please enter your bus price:');
      getPrice = double.tryParse(stdin.readLineSync() ?? ' ');
      if (getPrice != null && getPrice > 0) {
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
        print('your vip bus is added');
        return createVipBus;
      case 2:
        NormalBus createNormalBus = NormalBus(name: busName);
        print('your normal bus is added');
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
      if (busName != null && busName != '' && busName != ' ') {
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
