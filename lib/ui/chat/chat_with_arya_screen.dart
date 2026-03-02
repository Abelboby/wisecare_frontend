import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:wisecare_frontend/models/chat/chat_message_model.dart';
import 'package:wisecare_frontend/provider/chat_provider.dart';

part 'chat_with_arya_variables.dart';

class ChatWithAryaScreen extends StatelessWidget {
  const ChatWithAryaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _ChatColors.topBarBackground,
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: _ChatDimens.statusBarHeight),
              const _ChatTopBar(),
              Expanded(
                child: Consumer<ChatProvider>(
                  builder: (context, provider, _) => _ChatContent(
                    messages: provider.messages,
                    isLoading: provider.isLoading,
                    errorMessage: provider.errorMessage,
                    onClearError: () => provider.clearError(),
                  ),
                ),
              ),
              Consumer<ChatProvider>(
                builder: (context, provider, _) => _ChatInputArea(
                  onSend: (text) => provider.sendMessage(text),
                  isLoading: provider.isLoading,
                ),
              ),
            ],
          ),
          const _ChatHomeIndicator(),
        ],
      ),
    );
  }
}

class _ChatTopBar extends StatelessWidget {
  const _ChatTopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _ChatDimens.topBarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: _ChatColors.topBarBackground,
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: SizedBox(
                width: 36,
                height: 36,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                  color: _ChatColors.topBarText,
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Arya Assistant',
                  style: GoogleFonts.lexend(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 25 / 20,
                    letterSpacing: 0.5,
                    color: _ChatColors.topBarText,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: _ChatColors.onlineIndicator,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Online',
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 14 / 14,
                        color: const Color(0xFFD1D5DB),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // todo: More options - add onTap handler when ready.
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.more_vert,
                color: _ChatColors.topBarText,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatContent extends StatelessWidget {
  const _ChatContent({
    required this.messages,
    required this.isLoading,
    required this.errorMessage,
    required this.onClearError,
  });

  final List<ChatMessageModel> messages;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback onClearError;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      const _DateDivider(),
      if (errorMessage != null) ...[
        const SizedBox(height: 16),
        _ErrorMessageBanner(
          message: errorMessage!,
          onDismiss: onClearError,
        ),
        const SizedBox(height: 16),
      ],
      ...List.generate(messages.length, (i) {
        final msg = messages[i];
        return Padding(
          padding: const EdgeInsets.only(top: 24),
          child: msg.isFromUser
              ? _UserMessage(senderName: 'You', message: msg.text)
              : _AryaMessage(senderName: 'Arya', message: msg.text),
        );
      }),
      if (isLoading) ...[
        const SizedBox(height: 24),
        const _LoadingBubble(),
      ],
      const SizedBox(height: 24),
    ];

    return Container(
      color: _ChatColors.mainBackground,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          _ChatDimens.horizontalPadding,
          16,
          _ChatDimens.horizontalPadding,
          24,
        ),
        children: children,
      ),
    );
  }
}

class _ErrorMessageBanner extends StatelessWidget {
  const _ErrorMessageBanner({
    required this.message,
    required this.onDismiss,
  });

  final String message;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.lexend(
                fontSize: 14,
                color: Colors.red.shade800,
              ),
            ),
          ),
          GestureDetector(
            onTap: onDismiss,
            child: Icon(Icons.close, size: 20, color: Colors.red.shade700),
          ),
        ],
      ),
    );
  }
}

class _LoadingBubble extends StatelessWidget {
  const _LoadingBubble();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const _Avatar(isArya: true),
        const SizedBox(width: _ChatDimens.messageGap),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _ChatColors.aryaBubbleBg,
            border: Border.all(color: _ChatColors.aryaBubbleBorder),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(_ChatDimens.messageBubbleRadius),
              topRight: Radius.circular(_ChatDimens.messageBubbleRadius),
              bottomRight: Radius.circular(_ChatDimens.messageBubbleRadius),
              bottomLeft: Radius.zero,
            ),
          ),
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: _ChatColors.chipPrimaryText,
            ),
          ),
        ),
      ],
    );
  }
}

class _DateDivider extends StatelessWidget {
  const _DateDivider();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: _ChatColors.dateDividerBg,
          borderRadius: BorderRadius.circular(_ChatDimens.chipBorderRadius),
        ),
        child: Text(
          'TODAY',
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            height: 16 / 12,
            letterSpacing: 0.6,
            color: _ChatColors.dateDividerText,
          ),
        ),
      ),
    );
  }
}

class _AryaMessage extends StatelessWidget {
  const _AryaMessage({
    required this.senderName,
    required this.message,
  });

  final String senderName;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _Avatar(isArya: true),
        const SizedBox(width: _ChatDimens.messageGap),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                senderName,
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 20 / 14,
                  color: _ChatColors.senderNameText,
                ),
              ),
              const SizedBox(height: _ChatDimens.senderNameGap),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 48, 16),
                decoration: BoxDecoration(
                  color: _ChatColors.aryaBubbleBg,
                  border: Border.all(color: _ChatColors.aryaBubbleBorder),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(_ChatDimens.messageBubbleRadius),
                    topRight: Radius.circular(_ChatDimens.messageBubbleRadius),
                    bottomRight: Radius.circular(_ChatDimens.messageBubbleRadius),
                    bottomLeft: Radius.zero,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Text(
                  message,
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 29 / 18,
                    color: _ChatColors.aryaBubbleText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UserMessage extends StatelessWidget {
  const _UserMessage({
    required this.senderName,
    required this.message,
  });

  final String senderName;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                senderName,
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 20 / 14,
                  color: _ChatColors.senderNameText,
                ),
              ),
              const SizedBox(height: _ChatDimens.senderNameGap),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 42, 16),
                decoration: BoxDecoration(
                  color: _ChatColors.userBubbleBg,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(_ChatDimens.messageBubbleRadius),
                    topRight: Radius.circular(_ChatDimens.messageBubbleRadius),
                    bottomLeft: Radius.circular(_ChatDimens.messageBubbleRadius),
                    bottomRight: Radius.zero,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  message,
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 29 / 18,
                    color: _ChatColors.userBubbleText,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: _ChatDimens.messageGap),
        _Avatar(isArya: false),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.isArya});

  final bool isArya;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _ChatDimens.avatarSize,
      height: _ChatDimens.avatarSize,
      decoration: BoxDecoration(
        color: _ChatColors.aryaBubbleBorder,
        border: Border.all(color: Colors.white),
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Icon(
        isArya ? Icons.smart_toy_outlined : Icons.person,
        color: _ChatColors.senderNameText,
        size: 24,
      ),
    );
  }
}

class _ChatInputArea extends StatefulWidget {
  const _ChatInputArea({
    required this.onSend,
    required this.isLoading,
  });

  final void Function(String text) onSend;
  final bool isLoading;

  @override
  State<_ChatInputArea> createState() => _ChatInputAreaState();
}

class _ChatInputAreaState extends State<_ChatInputArea> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty || widget.isLoading) return;
    widget.onSend(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final bool canSend = _controller.text.trim().isNotEmpty && !widget.isLoading;
    return Container(
      padding: const EdgeInsets.fromLTRB(
        _ChatDimens.inputAreaPadding,
        _ChatDimens.inputAreaPadding,
        _ChatDimens.inputAreaPadding,
        _ChatDimens.inputAreaBottomPadding,
      ),
      decoration: BoxDecoration(
        color: _ChatColors.inputAreaBg,
        border: Border(
          top: BorderSide(color: _ChatColors.inputAreaBorder),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 4,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              // todo: Add attachment - add onTap handler when ready.
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Container(
                width: _ChatDimens.addButtonSize,
                height: _ChatDimens.addButtonSize,
                decoration: BoxDecoration(
                  color: _ChatColors.textInputBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  color: _ChatColors.iconMuted,
                  size: 25,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  height: 28 / 18,
                  color: _ChatColors.textInputPlaceholder,
                ),
                filled: true,
                fillColor: _ChatColors.textInputBg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(_ChatDimens.textInputBorderRadius),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                height: 28 / 18,
                color: _ChatColors.aryaBubbleText,
              ),
              maxLines: 4,
              minLines: 1,
              enabled: !widget.isLoading,
              onChanged: (_) => setState(() {}),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: canSend ? _handleSend : null,
            child: Container(
              width: _ChatDimens.sendButtonSize,
              height: _ChatDimens.sendButtonSize,
              decoration: BoxDecoration(
                color: canSend ? _ChatColors.sendButtonBg : _ChatColors.sendButtonBg.withValues(alpha: 0.5),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 10,
                    offset: Offset(0, 10),
                  ),
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: widget.isLoading
                  ? Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatHomeIndicator extends StatelessWidget {
  const _ChatHomeIndicator();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: _ChatDimens.homeIndicatorBottom,
      child: Center(
        child: Container(
          width: _ChatDimens.homeIndicatorWidth,
          height: _ChatDimens.homeIndicatorHeight,
          decoration: BoxDecoration(
            color: _ChatColors.homeIndicator,
            borderRadius: BorderRadius.circular(_ChatDimens.chipBorderRadius),
          ),
        ),
      ),
    );
  }
}
