import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_knowledge_view_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard.dart';

class GetDistributionKnowledgeViewTypeUseCase {
  const GetDistributionKnowledgeViewTypeUseCase({required this.distributionDashboard});

  final DistributionDashboard distributionDashboard;

  Future<DistributionKnowledgeViewType> call() async {
    return await distributionDashboard.getKnowledgeViewType();
  }
}
