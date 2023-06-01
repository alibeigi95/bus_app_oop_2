import 'bus.dart';
import 'seat.dart';

class Travel{
  final String travelDetails;
  final List<Seat> seats;
  final int price;
  final Bus bus;


  const Travel({required this.travelDetails,required this.seats,required this.bus,required this.price});

}