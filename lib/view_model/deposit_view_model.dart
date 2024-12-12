import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:roll2win/repo/deposit_repo.dart';
import 'package:roll2win/res/launcher.dart';
import 'package:roll2win/utils/toast.dart';
import 'package:roll2win/view_model/user_view_model.dart';



class DepositViewModel with ChangeNotifier {
  final _depositRepo = DepositRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> depositApi(dynamic amount,context) async {
    setLoading(true);
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    print(userId);
    print("userId");
    Map data={
      "userid":userId,
      "amount":amount.toString()
    };

    _depositRepo.depositApi(data).then((value) {
      if (value['status'] == 'SUCCESS') {
        setLoading(false);
        final url =value['payment_link'].toString();
        print("DepositURl:$url");
        Launcher.launchURL(url);
      } else {
        setLoading(false);
        Utils.showErrorToast(value['message']);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}