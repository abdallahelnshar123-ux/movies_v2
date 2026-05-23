import 'package:dartz/dartz.dart';
import 'package:movies/domain/failure/failure.dart';

abstract class OnBoardingRepository {
  Either<Failure, bool> checkOnboarding();

  void setOnboarding();
}
