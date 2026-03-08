/// Data model for a single vitals_update payload from the WebSocket.
class VitalsModel {
  final String userId;
  final String timestamp;
  final int heartRate;
  final double oxygenSaturation;
  final int bpSystolic;
  final int bpDiastolic;
  final double weight;
  final String risk;
  final List<String> riskFactors;

  const VitalsModel({
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

  factory VitalsModel.fromJson(Map<String, dynamic> json) {
    return VitalsModel(
      userId: (json['userId'] as String?) ?? '',
      timestamp: (json['timestamp'] as String?) ?? '',
      heartRate: _toInt(json['heartRate']),
      oxygenSaturation: _toDouble(json['oxygenSaturation']),
      bpSystolic: _toInt(json['bpSystolic']),
      bpDiastolic: _toInt(json['bpDiastolic']),
      weight: _toDouble(json['weight']),
      risk: (json['risk'] as String?) ?? 'LOW',
      riskFactors: json['riskFactors'] != null
          ? List<String>.from(json['riskFactors'] as List)
          : [],
    );
  }

  /// Formatted blood-pressure string, e.g. "120/80".
  String get bpLabel => '$bpSystolic/$bpDiastolic';

  /// Heart rate as a string, e.g. "72".
  String get heartRateLabel => '$heartRate';

  /// Risk with first letter capitalised, e.g. "Low".
  String get riskLabel {
    if (risk.isEmpty) return '';
    return risk[0] + risk.substring(1).toLowerCase();
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
