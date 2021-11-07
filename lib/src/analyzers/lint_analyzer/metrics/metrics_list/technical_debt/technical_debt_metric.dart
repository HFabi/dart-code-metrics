import 'package:analyzer/dart/ast/ast.dart';

import '../../../models/entity_type.dart';
import '../../../models/internal_resolved_unit_result.dart';
import '../../../models/scoped_class_declaration.dart';
import '../../../models/scoped_function_declaration.dart';
import '../../metric_utils.dart';
import '../../models/file_metric.dart';
import '../../models/metric_computation_result.dart';
import '../../models/metric_documentation.dart';
import '../../models/metric_value.dart';

const _documentation = MetricDocumentation(
  name: 'Technical Debt',
  shortName: 'TECHDEBT',
  measuredType: EntityType.fileEntity,
  recomendedThreshold: 0,
);

/// Technical Debt (TECHDEBT)
///
/// Technical debt is a concept in software development that reflects the
/// implied cost of additional rework caused by choosing an easy solution now
/// instead of using a better approach that would take longer.
class TechnicalDebtMetric extends FileMetric<int> {
  static const String metricId = 'technical-debt';

  TechnicalDebtMetric({Map<String, Object> config = const {}})
      : super(
          id: metricId,
          documentation: _documentation,
          threshold: readNullableThreshold<int>(config, metricId),
          levelComputer: valueLevel,
        );

  @override
  MetricComputationResult<int> computeImplementation(
    AstNode node,
    Iterable<ScopedClassDeclaration> classDeclarations,
    Iterable<ScopedFunctionDeclaration> functionDeclarations,
    InternalResolvedUnitResult source,
    Iterable<MetricValue<num>> otherMetricsValues,
  ) =>
      const MetricComputationResult(value: 10);

  @override
  String commentMessage(String nodeType, int value, int? threshold) {
    final exceeds = threshold != null && value > threshold
        ? ', exceeds the maximum of $threshold allowed'
        : '';
    final debt = '$value swe ${value == 1 ? 'hour' : 'hours'} of debt';

    return 'This $nodeType has $debt$exceeds.';
  }
}
