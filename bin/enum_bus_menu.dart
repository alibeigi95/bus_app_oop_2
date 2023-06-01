enum MenuOperations {
  insertBus(1, 'insert bus'),
  definitionTravel(2, 'definition of travel'),
  reserveTicket(3, 'reserve ticket'),
  buyTicket(4, 'buy ticket'),
  previewBus(5, 'preview bus'),
  cancelTicket(6, 'cancel ticket'),
  getReports(7, 'get report'),
  exit(8, 'exit');

  const MenuOperations(this.value, this.title);

  final int value;
  final String title;

  factory MenuOperations.getValue(final int value) {
    switch (value) {
      case 1:
        return MenuOperations.insertBus;
      case 2:
        return MenuOperations.definitionTravel;
      case 3:
      return MenuOperations.reserveTicket;
      case 4:
      return MenuOperations.buyTicket;
      case 5:
      return MenuOperations.previewBus;
      case 6:
        return MenuOperations.cancelTicket;
      case 7:
        return MenuOperations.getReports;
      case 8:
        return MenuOperations.exit;
      default:
        return MenuOperations.insertBus;
    }
  }
}