import 'package:injectable/injectable.dart';
import 'package:movies/data/data_sources/local/on_boarding/on_boarding_local_data_source.dart';
import 'package:movies/data/exceptions/app_exceptions.dart';

import '../../../../../core/data_bases/cache/local_storage.dart';

@Injectable(as: OnBoardingLocalDataSource)
class OnBoardingLocalDataSourceImpl implements OnBoardingLocalDataSource {
  final LocalStorage _localStorage;

  OnBoardingLocalDataSourceImpl(this._localStorage);

  @override
  bool checkOnboarding() {
    try {
      return _localStorage.onboarding;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<void> setOnboarding() async {
    try {
      await _localStorage.setOnboardingDone();
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
