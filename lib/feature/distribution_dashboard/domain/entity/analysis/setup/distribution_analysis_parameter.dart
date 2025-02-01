import 'package:equatable/equatable.dart';

class DistributionAnalysisParameter with EquatableMixin {
  const DistributionAnalysisParameter({required this.id, required this.symbol});

  final String id;
  final String symbol;

  @override
  List<Object?> get props => [id, symbol];
}
