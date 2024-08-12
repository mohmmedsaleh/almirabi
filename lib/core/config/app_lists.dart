import 'package:flutter/material.dart';

import 'app_enums.dart';

var messageTypesIcon = {
  // MessageTypes.warning: [Icons.warning_amber_outlined, Colors.grey[900]!],
  MessageTypes.error: [Icons.error_outline, Colors.red[400]],
  MessageTypes.connectivityOff: [Icons.wifi_off, Colors.red[400]],
  MessageTypes.connectivityOn: [Icons.wifi, Colors.green[600]],
  MessageTypes.success: [Icons.check_circle_outline, Colors.green[600]],
};
var stateList = {
  // MessageTypes.warning: [Icons.warning_amber_outlined, Colors.grey[900]!],
  RequestState.draft: [
    "assets/images/draft-button.png",
  ],
  RequestState.closed: [
    "assets/images/send-mail.png",
  ],
  RequestState.confirm: [
    "assets/images/check-mark.png",
  ],
  RequestState.cancel: [
    "assets/images/cancelled.png",
  ],
};
