part of '../meds_tab_screen.dart';

class _MedsGreeting extends StatelessWidget {
  const _MedsGreeting({required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, $userName',
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              height: 28 / 18,
              color: _MedsColors.greetingText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Today's Schedule",
            style: GoogleFonts.lexend(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              height: 36 / 30,
              color: _MedsColors.scheduleTitleText,
            ),
          ),
        ],
      ),
    );
  }
}
