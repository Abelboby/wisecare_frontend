part of '../wallet_screen.dart';

class _WalletTopupSection extends StatelessWidget {
  const _WalletTopupSection({
    required this.isTopupLoading,
    required this.onRequestTopup,
  });

  final bool isTopupLoading;
  final VoidCallback onRequestTopup;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: _WalletColors.topupButton,
          borderRadius: BorderRadius.circular(_WalletDimens.topupButtonRadius),
          child: InkWell(
            onTap: isTopupLoading ? null : onRequestTopup,
            borderRadius: BorderRadius.circular(_WalletDimens.topupButtonRadius),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: _WalletDimens.topupButtonPaddingVertical,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_WalletDimens.topupButtonRadius),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 15,
                    offset: Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isTopupLoading)
                    const SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        color: _WalletColors.topupButtonText,
                        strokeWidth: 2,
                      ),
                    )
                  else
                    const Icon(
                      Icons.add_circle_outline,
                      color: _WalletColors.topupButtonText,
                      size: 25,
                    ),
                  const SizedBox(width: 16),
                  Text(
                    isTopupLoading ? 'Sending request...' : 'Request Top-up',
                    style: GoogleFonts.lexend(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 28 / 20,
                      color: _WalletColors.topupButtonText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Taps your family members to add funds for you.',
            textAlign: TextAlign.center,
            style: GoogleFonts.lexend(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 20 / 14,
              color: _WalletColors.labelText,
            ),
          ),
        ),
      ],
    );
  }
}
