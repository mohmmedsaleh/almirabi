enum MessageTypes { warning, error, connectivityOff, connectivityOn, success }

enum TicketState {
  newTicket('New'),
  inProgress('In Progress'),
  closed('Closed');

  const TicketState(this.text);
  final String text;

  @override
  String toString() => 'TicketState($text)';
}

enum SessionState {
  openSession('Open'),
  closedSession('Close');

  const SessionState(this.text);
  final String text;

  @override
  String toString() => 'SessionState($text)';
}

enum SideUserMenu {
  dashboard,
  pointOfSale,
  orders,
  products,
  customers,
  units,
  reports,
  configuration,
  categories,
  databaseInfoSetting,
  dataManagement
}

enum Loaddata {
  products,
  customers,
  categories,
  vendors,
  stockWarehouses,
  priceList,
  productUnit,
  userPermissions,
  posInfo,
  paymentType,
}

// enum SessionState {
//   open,
//   closed,
// }
