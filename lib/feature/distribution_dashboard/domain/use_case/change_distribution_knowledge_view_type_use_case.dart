import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_knowledge_view_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard.dart';

class ChangeDistributionKnowledgeViewTypeUseCase {
  const ChangeDistributionKnowledgeViewTypeUseCase({required this.distributionDashboard});

  final DistributionDashboard distributionDashboard;

  Future<void> call(DistributionKnowledgeViewType knowledgeViewType) async {
    await distributionDashboard.setKnowledgeViewType(knowledgeViewType);
  }
}
