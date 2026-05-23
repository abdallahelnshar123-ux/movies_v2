import 'package:injectable/injectable.dart';
import 'package:movies/domain/repository/on_boarding/on_boarding_repository.dart';

@injectable
class SetOnboardingDoneUseCase {
  final OnBoardingRepository _onBoardingRepository;

  SetOnboardingDoneUseCase(this._onBoardingRepository);

  void setOnboardingDone(){
    _onBoardingRepository.setOnboarding();

  }

}