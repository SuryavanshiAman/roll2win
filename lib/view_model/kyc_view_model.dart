import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:roll2win/repo/kyc_repo.dart';
import 'package:roll2win/res/app_colors.dart';
import 'package:roll2win/utils/routes_name.dart';
import 'package:roll2win/utils/toast.dart';

class AddKycViewModel with ChangeNotifier {
  final _addKycRepo = KycRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> addKycApi(dynamic data,context) async {
    setLoading(true);

    _addKycRepo.kycApi(data).then((value) {
      if (value['status'] == 200) {
        setLoading(false);
        Navigator.pushReplacementNamed(context, RoutesName.bottomNevBar);
        Utils.flushBarSuccessMessage(value['message'], context, white);
      } else {
        setLoading(false);
        Utils.flushBarErrorMessage(value['message'], context, white);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('kycApi: $error');
      }
    });
  }
}