import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/repository/distributions_repository.dart';

class GetAllDistributionsUseCase {
  const GetAllDistributionsUseCase({required this.distributionsRepository});

  final DistributionsRepository distributionsRepository;

  Future<List<Distribution>> call() async {
    final distributions = await distributionsRepository.getAllDistributions();
    return distributions;
  }
}
