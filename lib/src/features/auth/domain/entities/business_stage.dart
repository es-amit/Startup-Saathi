import 'package:startup_saathi/src/components/enums/growth.dart';

class BusinessStage {
  final String concept;
  final String traction;
  final String productLaunched;
  final Growth growth;

  BusinessStage({
    required this.concept,
    required this.traction,
    required this.productLaunched,
    required this.growth,
  });
}
