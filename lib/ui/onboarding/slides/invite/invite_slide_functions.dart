part of 'invite_slide_screen.dart';

void copyInviteCode(BuildContext context, String code) {
  if (code == _InviteSlidePlaceholder.code) return;
  Clipboard.setData(ClipboardData(text: code));
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Code copied to clipboard')),
    );
  }
}

Future<void> shareInviteCode(String code) async {
  if (code == _InviteSlidePlaceholder.code) return;
  try {
    await Share.share(
      'Connect with me on WiseCare. Use this code: $code',
      subject: 'WiseCare family connect code',
    );
  } catch (_) {}
}
