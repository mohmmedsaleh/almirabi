import 'package:get/get.dart';

enum MessageTypes { warning, error, connectivityOff, connectivityOn, success }

enum RequestState {
  draft('draft'),
  closed('done_seended'),
  confirm('confirm'),
  cancel('cancel');

  const RequestState(this.text);
  final String text;

  @override
  String toString() => '${text.tr}';
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

enum Loaddata { requests }

// enum SessionState {
//   open,
//   closed,
// }
