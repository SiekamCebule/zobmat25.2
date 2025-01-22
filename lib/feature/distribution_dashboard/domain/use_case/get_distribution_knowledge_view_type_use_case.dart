import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_knowledge_view_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard_repository.dart';

class GetDistributionKnowledgeViewTypeUseCase {
  const GetDistributionKnowledgeViewTypeUseCase({
    required this.distributionDashboardRepository,
  });

  final DistributionDashboardRepository distributionDashboardRepository;

  Future<DistributionKnowledgeViewType> call() async {
    return await distributionDashboardRepository.getKnowledgeViewType();
  }
}
