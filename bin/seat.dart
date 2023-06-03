import 'ticket.dart';

class Seat {
  final String number;
  Ticket? ticket;

  Seat({required this.number, this.ticket});

  Seat copyWith({required String number}) {
    String numbers = number;
    return Seat(number: numbers);
  }
}
