import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description_component.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description_text_component.dart';

class DistributionDescriptionBulletedList extends DistributionDescriptionComponent {
  const DistributionDescriptionBulletedList({required this.items});

  final List<DistributionDescriptionTextComponent> items;

  @override
  List<Object?> get props => [super.props, items];
}
