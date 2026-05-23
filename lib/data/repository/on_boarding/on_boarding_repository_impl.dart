import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/data/data_sources/local/on_boarding/on_boarding_local_data_source.dart';
import 'package:movies/data/exceptions/app_exceptions.dart';
import 'package:movies/data/mapper/exception_mapper.dart';
import 'package:movies/domain/failure/failure.dart';
import 'package:movies/domain/repository/on_boarding/on_boarding_repository.dart';

@Injectable(as: OnBoardingRepository)
class OnBoardingRepositoryImpl implements OnBoardingRepository {
  final OnBoardingLocalDataSource _onBoardingLocalDataSource;

  OnBoardingRepositoryImpl(this._onBoardingLocalDataSource);

  @override
  Either<Failure, bool> checkOnboarding() {
    try {
      var onBoarding = _onBoardingLocalDataSource.checkOnboarding();
      return Right(onBoarding);
    } on AppException catch (e) {
      return Left(e.toFailure());
    }
  }

  // @override
  // Future<Either<Failure, Unit>> setOnboarding() async {
  //   try {
  //     await _onBoardingLocalDataSource.setOnboarding();
  //     return Right(unit);
  //   } on AppException catch (e) {
  //     return Left(e.toFailure());
  //   }
  // }
  @override
  void setOnboarding()  {
     _onBoardingLocalDataSource.setOnboarding();
  }
}
