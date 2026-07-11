
import 'dart:io';
import 'package:decora/core/utils/colors/app_colors.dart';
import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/chat/domain/repo/chat_repo.dart';
import 'package:decora/feature/chat/presentation/cubits/get_messages_cubit/get_messages_cubit.dart';
import 'package:decora/feature/chat/presentation/cubits/send_messages_cubit/send_messages_cubit.dart';
import 'package:decora/feature/chat/presentation/widgets/date_divider.dart';
import 'package:decora/feature/chat/presentation/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class _PendingMessage {
  final String tempId;
  final String text;
  final File? imageFile;
  bool failed;

  _PendingMessage({
    required this.tempId,
    required this.text,
    this.imageFile,
    this.failed = false,
  });
}

class ChatRoomViewBody extends StatefulWidget {
  final String chatId;
  final String currentUserId;
  final String userName;
  final String? userAvatar;

  const ChatRoomViewBody({
    super.key,
    required this.chatId,
    required this.currentUserId,
    required this.userName,
    this.userAvatar,
  });

  @override
  State<ChatRoomViewBody> createState() => _ChatRoomViewBodyState();
}

class _ChatRoomViewBodyState extends State<ChatRoomViewBody> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;
  final List<_PendingMessage> _pendingMessages = [];

  @override
  void initState() {
    super.initState();
    context.read<GetMessagesCubit>().getMessages(chatId: widget.chatId);
    getIt.get<ChatRepo>().markChatAsRead(
      chatId: widget.chatId,
      userId: widget.currentUserId,
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (pickedFile == null) return;
    setState(() {
      _selectedImage = File(pickedFile.path);
    });
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    final image = _selectedImage;

    if (text.isEmpty && image == null) return;

    final tempId = DateTime.now().millisecondsSinceEpoch.toString();

    setState(() {
      _pendingMessages.add(
        _PendingMessage(tempId: tempId, text: text, imageFile: image),
      );
      _selectedImage = null;
    });

    _controller.clear();
    _scrollToBottom();

    context.read<SendMessagesCubit>().sendMessage(
      chatId: widget.chatId,
      senderId: widget.currentUserId,
      text: text,
      imageFile: image,
    );
  }

  void _retryPending(_PendingMessage pending) {
    setState(() {
      pending.failed = false;
    });
    context.read<SendMessagesCubit>().sendMessage(
      chatId: widget.chatId,
      senderId: widget.currentUserId,
      text: pending.text,
      imageFile: pending.imageFile,
    );
  }

  void _reconcilePendingMessages(List<dynamic> realMessages) {
    if (_pendingMessages.isEmpty || realMessages.isEmpty) return;


    final recentOwnMessages = realMessages.reversed
        .where((m) => _senderIdOf(m) == widget.currentUserId)
        .take(_pendingMessages.length + 5)
        .toList();

    if (recentOwnMessages.isEmpty) return;

    final matchedIds = <String>{};

    for (final pending in _pendingMessages) {
      if (pending.failed) continue; 

      final hasMatch = recentOwnMessages.any((m) {
        final sameText = _textOf(m) == pending.text;
        final sameHasImage = _hasImageOf(m) == (pending.imageFile != null);
        return sameText && sameHasImage;
      });

      if (hasMatch) {
        matchedIds.add(pending.tempId);
      }
    }

    if (matchedIds.isNotEmpty) {
      setState(() {
        _pendingMessages.removeWhere((p) => matchedIds.contains(p.tempId));
      });
    }
  }

  
  String? _senderIdOf(dynamic m) {
    try {
      return m.senderId as String?;
    } catch (_) {
      return null;
    }
  }

  String _textOf(dynamic m) {
    try {
      return (m.text as String?)?.trim() ?? '';
    } catch (_) {
      return '';
    }
  }

  bool _hasImageOf(dynamic m) {
    try {
      final url = m.imageUrl as String?;
      return url != null && url.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }


  Widget _buildBubbleContainer(_PendingMessage pending) {
    final container = Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.68,
      ),
      padding: pending.imageFile != null
          ? const EdgeInsets.all(4)
          : const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E88E5),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(4),
        ),
      ),
      child: pending.imageFile != null
          ? Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    pending.imageFile!,
                    width: 200,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                if (!pending.failed)
                  const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                if (pending.failed)
                  const Icon(Icons.error_outline,
                      color: Colors.red, size: 32),
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    pending.text,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                if (pending.failed) ...[
                  const SizedBox(width: 8),
                  const Icon(Icons.error_outline,
                      color: Colors.red, size: 16),
                ],
              ],
            ),
    );

    if (pending.imageFile != null && !pending.failed) {
      return Opacity(opacity: 0.6, child: container);
    }
    return container;
  }

  Widget _buildPendingBubble(_PendingMessage pending) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildBubbleContainer(pending),
            ],
          ),
          if (pending.failed)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: GestureDetector(
                onTap: () => _retryPending(pending),
                child: const Text(
                  'please try again!',
                  style: TextStyle(fontSize: 11, color: Colors.red),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocListener<SendMessagesCubit, SendMessagesState>(
            listener: (context, sendState) {
          
              if (sendState is SendMessagesFailure &&
                  _pendingMessages.isNotEmpty) {
                setState(() {
                  final firstUnfailed = _pendingMessages.firstWhere(
                    (p) => !p.failed,
                    orElse: () => _pendingMessages.first,
                  );
                  firstUnfailed.failed = true;
                });
              }
            },
            child: BlocConsumer<GetMessagesCubit, GetMessagesState>(
              listener: (context, state) {
                if (state is GetMessagesSuccess) {
                  _reconcilePendingMessages(state.messages);
                  _scrollToBottom();
                }
              },
              builder: (context, state) {
                if (state is GetMessagesLoading) {
                  return const Center(child: SizedBox());
                }
                if (state is GetMessagesFailure) {
                  return Center(child: Text(state.message));
                }
                if (state is GetMessagesSuccess) {
                  final messages = state.messages;

                  if (messages.isEmpty && _pendingMessages.isEmpty) {
                    return const Center(child: Text('No messages yet'));
                  }

                  final itemCount =
                      messages.length + 1 + _pendingMessages.length;

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const DateDivider(label: 'Today');
                      }

                      final msgIndex = index - 1;

                      if (msgIndex < messages.length) {
                        final msg = messages[msgIndex];
                        return MessageBubble(
                          message: msg,
                          currentUserId: widget.currentUserId,
                          userName: widget.userName,
                          userAvatar: widget.userAvatar,
                        );
                      }

                      final pendingIndex = msgIndex - messages.length;
                      return _buildPendingBubble(
                          _pendingMessages[pendingIndex]);
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),

        if (_selectedImage != null)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            height: 500,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _selectedImage!,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedImage = null),
                    child: const CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.black54,
                      child: Icon(Icons.close, size: 14, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),

        Container(
          color: AppColors.lightBackground,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                IconButton(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.image_outlined,
                      color: AppColors.accentGold),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightBackground,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (_) => _sendMessage(),
                      textInputAction: TextInputAction.send,
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: 'Message...',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.accentGold,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send_rounded,
                        color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}