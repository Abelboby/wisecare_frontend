part of '../meds_tab_screen.dart';

/// Dialog to select which medicines to request refill for.
class _RefillPrescriptionDialog extends StatefulWidget {
  const _RefillPrescriptionDialog({
    required this.suggestions,
    required this.onConfirm,
  });

  final List<RefillSuggestionModel> suggestions;
  final _RefillOnConfirmCallback onConfirm;

  static Future<void> show(
    BuildContext context, {
    required List<RefillSuggestionModel> suggestions,
    required _RefillOnConfirmCallback onConfirm,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => _RefillPrescriptionDialog(
        suggestions: suggestions,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  State<_RefillPrescriptionDialog> createState() => _RefillPrescriptionDialogState();
}

class _RefillPrescriptionDialogState extends State<_RefillPrescriptionDialog> {
  final Set<String> _selectedIds = {};
  bool _isSubmitting = false;

  bool get _hasSelection => _selectedIds.isNotEmpty;

  void _toggle(String medicationId) {
    if (_isSubmitting) return;
    setState(() {
      if (_selectedIds.contains(medicationId)) {
        _selectedIds.remove(medicationId);
      } else {
        _selectedIds.add(medicationId);
      }
    });
  }

  Future<void> _handleConfirm() async {
    if (!_hasSelection || _isSubmitting) return;
    setState(() => _isSubmitting = true);
    try {
      await widget.onConfirm(_selectedIds.toList());
      if (!mounted) return;
      Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Refill prescription',
        style: GoogleFonts.lexend(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: _MedsColors.refillTitleText,
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select medicines to request refill',
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: _MedsColors.refillSubText,
                ),
              ),
              const SizedBox(height: 16),
              ...widget.suggestions.map((suggestion) {
                final isSelected = _selectedIds.contains(suggestion.medicationId);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: InkWell(
                    onTap: _isSubmitting ? null : () => _toggle(suggestion.medicationId),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isSelected,
                            onChanged: _isSubmitting ? null : (_) => _toggle(suggestion.medicationId),
                            activeColor: _MedsColors.refillIcon,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              suggestion.medicationName,
                              style: GoogleFonts.lexend(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: _MedsColors.refillTitleText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: GoogleFonts.lexend(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: _MedsColors.refillSubText,
            ),
          ),
        ),
        FilledButton(
          onPressed: (_hasSelection && !_isSubmitting) ? _handleConfirm : null,
          style: FilledButton.styleFrom(
            backgroundColor: _MedsColors.refillIcon,
            foregroundColor: Colors.white,
          ),
          child: _isSubmitting
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  'Confirm',
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ],
    );
  }
}
