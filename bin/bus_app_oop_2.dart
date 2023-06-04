import 'enum_bus_menu.dart';
import 'bus_station.dart';
import 'dart:io';

BusStation busStation = BusStation(buses: [], travel: []);

void main(List<String> arguments) {
  while (true) {
    MenuOperations busMenu = getMenu();
    mainMenu(menu: busMenu);
    if (busMenu.title == 'exit') {
      break;
    }
  }
}

void showMenu() {
  for (MenuOperations busMenu in MenuOperations.values) {
    stdout.write('${busMenu.value}:${busMenu.title}\t');
  }
}

MenuOperations getMenu() {
  int? menu;
  while (true) {
    showMenu();
    print('\n please enter your choose:');
    menu = int.tryParse(stdin.readLineSync() ?? ' ');
    if (menu != null && menu > 0 && menu < 9) {
      return MenuOperations.getValue(menu);
    } else {
      print('please enter a valid number between 1 to 8');
    }
  }
}

void mainMenu({required MenuOperations menu}) {
  switch (menu) {
    case MenuOperations.insertBus:
      busStation.addBuses();
      print(busStation.buses);
      break;
    case MenuOperations.definitionTravel:
      busStation.addTravel();
      break;
    case MenuOperations.reserveTicket:
      busStation.reserveTicket();
      break;
    case MenuOperations.buyTicket:
      busStation.buyTicket();
      break;
    case MenuOperations.previewBus:
      busStation.previewBus();
      break;
    case MenuOperations.cancelTicket:
      busStation.cancelTicket();
      break;
    case MenuOperations.getReports:
      busStation.getReports();
      break;
    case MenuOperations.exit:
      break;
  }
}
