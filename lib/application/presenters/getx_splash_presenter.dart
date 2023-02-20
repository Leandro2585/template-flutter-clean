import 'package:get/get.dart';
import 'package:meta/meta.dart';

import 'package:flutter_clean/ui/pages/pages.dart';
import 'package:flutter_clean/domain/usecases/usecases.dart';

class GetxSplashPresenter implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;
  final _navigateTo = RxString(null);

  GetxSplashPresenter({@required this.loadCurrentAccount});

  @override
  Stream<String> get navigateToStream => _navigateTo.stream;

  @override
  Future<void> checkAccount({int durationInSeconds = 10}) async {
    await Future.delayed(Duration(seconds: durationInSeconds));
    try {
      final account = await loadCurrentAccount.load();
      // _navigateTo.value = account == null ? '/login' : '/home';
      _navigateTo.value = '/login';
    } catch (error) {
      _navigateTo.value = '/login';
    }
  }
}
