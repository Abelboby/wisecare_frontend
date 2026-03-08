/// Response from GET /vitals/history.
class VitalsHistoryResponse {
  const VitalsHistoryResponse({
    required this.userId,
    this.timeRange,
    required this.count,
    required this.snapshots,
    required this.statistics,
  });

  final String userId;
  final VitalsHistoryTimeRange? timeRange;
  final int count;
  final List<VitalsHistorySnapshot> snapshots;
  final VitalsHistoryStatistics statistics;

  factory VitalsHistoryResponse.fromJson(Map<String, dynamic> json) {
    final snapshotsRaw = json['snapshots'];
    final statsRaw = json['statistics'];
    return VitalsHistoryResponse(
      userId: (json['userId'] as String?) ?? '',
      timeRange: json['timeRange'] != null
          ? VitalsHistoryTimeRange.fromJson(
              json['timeRange'] as Map<String, dynamic>,
            )
          : null,
      count: (json['count'] as num?)?.toInt() ?? 0,
      snapshots: snapshotsRaw is List
          ? (snapshotsRaw)
              .map((e) => VitalsHistorySnapshot.fromJson(
                    e as Map<String, dynamic>,
                  ))
              .toList()
          : [],
      statistics: statsRaw is Map<String, dynamic>
          ? VitalsHistoryStatistics.fromJson(statsRaw)
          : VitalsHistoryStatistics.empty(),
    );
  }
}

class VitalsHistoryTimeRange {
  const VitalsHistoryTimeRange({
    required this.start,
    required this.end,
    required this.hours,
  });

  final String start;
  final String end;
  final int hours;

  factory VitalsHistoryTimeRange.fromJson(Map<String, dynamic> json) {
    return VitalsHistoryTimeRange(
      start: (json['start'] as String?) ?? '',
      end: (json['end'] as String?) ?? '',
      hours: (json['hours'] as num?)?.toInt() ?? 0,
    );
  }
}

/// Single snapshot in history (same shape as WebSocket vitals_update).
class VitalsHistorySnapshot {
  const VitalsHistorySnapshot({
    required this.userId,
    required this.timestamp,
    required this.heartRate,
    required this.oxygenSaturation,
    required this.bpSystolic,
    required this.bpDiastolic,
    required this.weight,
    required this.risk,
    required this.riskFactors,
  });

  final String userId;
  final String timestamp;
  final int heartRate;
  final double oxygenSaturation;
  final int bpSystolic;
  final int bpDiastolic;
  final double weight;
  final String risk;
  final List<String> riskFactors;

  factory VitalsHistorySnapshot.fromJson(Map<String, dynamic> json) {
    return VitalsHistorySnapshot(
      userId: (json['userId'] as String?) ?? '',
      timestamp: (json['timestamp'] as String?) ?? '',
      heartRate: _toInt(json['heartRate']),
      oxygenSaturation: _toDouble(json['oxygenSaturation']),
      bpSystolic: _toInt(json['bpSystolic']),
      bpDiastolic: _toInt(json['bpDiastolic']),
      weight: _toDouble(json['weight']),
      risk: (json['risk'] as String?) ?? 'LOW',
      riskFactors: json['riskFactors'] != null ? List<String>.from(json['riskFactors'] as List) : [],
    );
  }

  static int _toInt(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString()) ?? 0;
  }

  static double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is double) return v;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }
}

class VitalsHistoryStatistics {
  const VitalsHistoryStatistics({
    required this.heartRate,
    required this.bloodPressure,
    required this.oxygenSaturation,
    required this.riskDistribution,
  });

  final MinMaxAvg heartRate;
  final BloodPressureStats bloodPressure;
  final MinMaxAvg oxygenSaturation;
  final RiskDistribution riskDistribution;

  factory VitalsHistoryStatistics.fromJson(Map<String, dynamic> json) {
    return VitalsHistoryStatistics(
      heartRate: json['heartRate'] is Map<String, dynamic>
          ? MinMaxAvg.fromJson(json['heartRate'] as Map<String, dynamic>)
          : MinMaxAvg.empty(),
      bloodPressure: json['bloodPressure'] is Map<String, dynamic>
          ? BloodPressureStats.fromJson(
              json['bloodPressure'] as Map<String, dynamic>,
            )
          : BloodPressureStats.empty(),
      oxygenSaturation: json['oxygenSaturation'] is Map<String, dynamic>
          ? MinMaxAvg.fromJson(
              json['oxygenSaturation'] as Map<String, dynamic>,
            )
          : MinMaxAvg.empty(),
      riskDistribution: json['riskDistribution'] is Map<String, dynamic>
          ? RiskDistribution.fromJson(
              json['riskDistribution'] as Map<String, dynamic>,
            )
          : RiskDistribution.empty(),
    );
  }

  static VitalsHistoryStatistics empty() {
    return VitalsHistoryStatistics(
      heartRate: MinMaxAvg.empty(),
      bloodPressure: BloodPressureStats.empty(),
      oxygenSaturation: MinMaxAvg.empty(),
      riskDistribution: RiskDistribution.empty(),
    );
  }
}

class MinMaxAvg {
  const MinMaxAvg({
    required this.min,
    required this.max,
    required this.avg,
  });

  final double min;
  final double max;
  final double avg;

  factory MinMaxAvg.fromJson(Map<String, dynamic> json) {
    return MinMaxAvg(
      min: _toDouble(json['min']),
      max: _toDouble(json['max']),
      avg: _toDouble(json['avg']),
    );
  }

  static double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }

  static MinMaxAvg empty() => const MinMaxAvg(min: 0, max: 0, avg: 0);
}

class BloodPressureStats {
  const BloodPressureStats({
    required this.systolic,
    required this.diastolic,
  });

  final MinMaxAvg systolic;
  final MinMaxAvg diastolic;

  factory BloodPressureStats.fromJson(Map<String, dynamic> json) {
    return BloodPressureStats(
      systolic: json['systolic'] is Map<String, dynamic>
          ? MinMaxAvg.fromJson(json['systolic'] as Map<String, dynamic>)
          : MinMaxAvg.empty(),
      diastolic: json['diastolic'] is Map<String, dynamic>
          ? MinMaxAvg.fromJson(json['diastolic'] as Map<String, dynamic>)
          : MinMaxAvg.empty(),
    );
  }

  static BloodPressureStats empty() {
    return BloodPressureStats(
      systolic: MinMaxAvg.empty(),
      diastolic: MinMaxAvg.empty(),
    );
  }
}

class RiskDistribution {
  const RiskDistribution({
    required this.low,
    required this.medium,
    required this.high,
    required this.critical,
  });

  final int low;
  final int medium;
  final int high;
  final int critical;

  factory RiskDistribution.fromJson(Map<String, dynamic> json) {
    return RiskDistribution(
      low: (json['LOW'] as num?)?.toInt() ?? 0,
      medium: (json['MEDIUM'] as num?)?.toInt() ?? 0,
      high: (json['HIGH'] as num?)?.toInt() ?? 0,
      critical: (json['CRITICAL'] as num?)?.toInt() ?? 0,
    );
  }

  static RiskDistribution empty() => const RiskDistribution(low: 0, medium: 0, high: 0, critical: 0);

  int get total => low + medium + high + critical;
}
