import 'enum_bus_menu.dart';
import 'dart:io';

void main(List<String> arguments) {

  while(true){
    MenuOperations busMenu = getMenu();
    mainMenu(menu: busMenu);

  }

}



void showMenu() {
  for(MenuOperations busMenu in MenuOperations.values ){
    stdout.write('${busMenu.value}:${busMenu.title}\t');
  }
}

MenuOperations getMenu(){
  int? menu;
  while (true) {
    showMenu();
    print('\n please enter your choose:');
    menu = int.tryParse(stdin.readLineSync() ?? ' ');
    if (menu != null && menu > 0 && menu < 9 ) {
      return  MenuOperations.getValue(menu);
    } else {
      print('please enter a valid number between 1 to 8');
    }
  }

}

void mainMenu({required MenuOperations menu}){

  switch(menu){
    case MenuOperations.insertBus:
      print(menu.title);
      break;
    case MenuOperations.definitionTravel:
      print(menu.title);
      break;
    case MenuOperations.reserveTicket:
      print(menu.title);
      break;
    case MenuOperations.buyTicket:
      print(menu.title);
      break;
    case MenuOperations.previewBus:
      print(menu.title);
      break;
    case MenuOperations.cancelTicket:
      print(menu.title);
      break;
    case MenuOperations.getReports:
      print(menu.title);
      break;
    case MenuOperations.exit:
      break;
  }


}