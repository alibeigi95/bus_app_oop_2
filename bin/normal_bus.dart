import 'bus.dart';

class NormalBus extends Bus {
  const NormalBus({required String name})
      : super(name: name, priceFactor: 1, seatCount: 44);
}
