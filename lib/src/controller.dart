import 'package:flutter/material.dart';
import 'package:updater/src/enums.dart';

class UpdaterController extends ChangeNotifier {
  UpdaterController({
    this.listener,
    this.onChecked,
    this.progress,
    this.onError,
  });

  ///Return [UpdateStatus] whenever new event trigger
  ///
  ///[UpdateStatus.Checking] when checking for an update
  ///
  ///[UpdateStatus.Available] when an update is available
  ///
  ///[UpdateStatus.Pending] when an update is preparing to download
  ///
  ///[UpdateStatus.Dowloading] when an update starts downloading
  ///
  ///[UpdateStatus.Completed] when the update is downloaded and ready to install
  ///
  ///[UpdateStatus.DialogDismissed] when update dialog dismissed
  ///
  ///[UpdateStatus.Cancelled] when an update is downloading and canceled
  ///
  ///[UpdateStatus.Failed] when there is an error that stoped the update to download
  Function(UpdateStatus status)? listener;

  ///Return true/false based on update available or not
  Function(bool isAvailable)? onChecked;

  ///Retrun download progress
  Function(int current, int total)? progress;

  ///Return error
  Function(Object status)? onError;

  setValue(UpdateStatus _status) {
    if (listener != null) listener!(_status);
    notifyListeners();
  }

  setAvailability(bool _isAvailable) {
    if (onChecked != null) {
      onChecked!(_isAvailable);

      notifyListeners();
    }
  }

  void setProgress(_current, _total) {
    if (progress != null) progress!(_current, _total);
    notifyListeners();
  }

  void setError(_error) {
    if (onError != null) onError!(_error);
    notifyListeners();
  }

  @override
  void dispose() {
    listener = null;
    progress = null;
    onError = null;
    super.dispose();
  }
}
