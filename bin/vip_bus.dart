import 'bus.dart';


class VipBus extends Bus {
  const VipBus({required String name})
      : super(name: name, priceFactor: 1.4, seatCount: 25);
}
