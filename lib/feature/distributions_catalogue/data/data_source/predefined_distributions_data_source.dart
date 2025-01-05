import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_description_ui.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_type.dart';

abstract interface class PredefinedDistributionsDataSource {
  Future<List<DistributionModel>> getAll();
}

class PredefinedDistributionsDataSourceImpl implements PredefinedDistributionsDataSource {
  @override
  Future<List<DistributionModel>> getAll() async {
    return [
      DistributionModel(
        name: 'Rozkład normalny',
        shortDescription:
            'Symetryczna krzywa w kształcie dzwonu, która trafnie opisuje wiele zjawisk, takich jak wzrost czy wyniki egzaminów.',
        type: DistributionType.contiunous,
        parameters: [
          DistributionParameter('mean', 'Średnia'),
          DistributionParameter('dev', 'Odchylenie standardowe'),
        ],
        extendedDescription: DistributionDescriptionUi(),
        applicationsDescription: DistributionDescriptionUi(),
      ),
      DistributionModel(
        name: 'Rozkład normalny',
        shortDescription:
            'Symetryczna krzywa w kształcie dzwonu, która trafnie opisuje wiele zjawisk, takich jak wzrost czy wyniki egzaminów.',
        type: DistributionType.contiunous,
        parameters: [
          DistributionParameter('mean', 'Średnia'),
          DistributionParameter('dev', 'Odchylenie standardowe'),
        ],
        extendedDescription: DistributionDescriptionUi(),
        applicationsDescription: DistributionDescriptionUi(),
      ),
      DistributionModel(
        name: 'Rozkład normalny',
        shortDescription:
            'Symetryczna krzywa w kształcie dzwonu, która trafnie opisuje wiele zjawisk, takich jak wzrost czy wyniki egzaminów.',
        type: DistributionType.contiunous,
        parameters: [
          DistributionParameter('mean', 'Średnia'),
          DistributionParameter('dev', 'Odchylenie standardowe'),
        ],
        extendedDescription: DistributionDescriptionUi(),
        applicationsDescription: DistributionDescriptionUi(),
      ),
      DistributionModel(
        name: 'Rozkład normalny',
        shortDescription:
            'Symetryczna krzywa w kształcie dzwonu, która trafnie opisuje wiele zjawisk, takich jak wzrost czy wyniki egzaminów.',
        type: DistributionType.discrete,
        parameters: [
          DistributionParameter('mean', 'Średnia'),
          DistributionParameter('dev', 'Odchylenie standardowe'),
        ],
        extendedDescription: DistributionDescriptionUi(),
        applicationsDescription: DistributionDescriptionUi(),
      ),
      DistributionModel(
        name: 'Rozkład normalny',
        shortDescription:
            'Symetryczna krzywa w kształcie dzwonu, która trafnie opisuje wiele zjawisk, takich jak wzrost czy wyniki egzaminów.',
        type: DistributionType.discrete,
        parameters: [
          DistributionParameter('mean', 'Średnia'),
          DistributionParameter('dev', 'Odchylenie standardowe'),
        ],
        extendedDescription: DistributionDescriptionUi(),
        applicationsDescription: DistributionDescriptionUi(),
      ),
    ]; // TODO: ADD DISTRIBUTIONS
  }
}
