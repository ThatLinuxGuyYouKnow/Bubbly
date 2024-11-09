import 'package:bubbly/chats/chat.dart';
import 'package:bubbly/users/users.dart';
import 'package:bubbly/widgets/StandardTextField.dart';
import 'package:bubbly/widgets/backButton.dart';
import 'package:bubbly/widgets/buttons.dart';
import 'package:bubbly/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatNew extends StatefulWidget {
  const ChatNew({super.key});

  @override
  State<ChatNew> createState() => _ChatNewState();
}

class _ChatNewState extends State<ChatNew> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _usernameSearchController =
      TextEditingController();
  final Users _users = Users();

  bool _userSelected = false;
  String? _contactNewUsername;
  List<String> _matchedUsers = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _usernameSearchController.addListener(_handleUsernameSearch);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _usernameSearchController.dispose();
    super.dispose();
  }

  Future<void> _handleUsernameSearch() async {
    if (_usernameSearchController.text.trim().isEmpty) {
      setState(() => _matchedUsers = []);
      return;
    }

    setState(() => _isLoading = true);
    try {
      final matches = await _users.getUsersByMatch(
          steppedUsername: _usernameSearchController.text.trim());
      setState(() => _matchedUsers = matches);
    } catch (e) {
      // Handle error appropriately
      debugPrint('Error searching users: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showMatchedUsers() {
    if (_matchedUsers.isEmpty) return;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'Matching Users',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _matchedUsers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(_matchedUsers[index]),
                      onTap: () {
                        setState(() {
                          _contactNewUsername = _matchedUsers[index];
                          _userSelected = true;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: screenHeight * 0.22,
            pinned: true,
            backgroundColor: Colors.purpleAccent.withOpacity(.02),
            elevation: 0,
            leading: Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.05),
              child: const CustomBackButton(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1.0,
              titlePadding: EdgeInsets.only(
                left: screenWidth * 0.05,
                bottom: screenHeight * 0.02,
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      StandardText(
                        textContent: 'New Chat',
                        textFontSize: 25,
                        textWeight: FontWeight.bold,
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.bubble_chart, color: Colors.purple),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    'Reach out to someone new!',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.purple,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: screenHeight * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  StandardText(
                    textContent: 'Enter frens username',
                    textFontSize: 15,
                    textWeight: FontWeight.bold,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  if (_userSelected && _contactNewUsername != null)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => Chat(
                              recipientUsername: _contactNewUsername!,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.person, color: Colors.purple),
                            const SizedBox(width: 8),
                            Text(
                              _contactNewUsername!,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => setState(() {
                                _userSelected = false;
                                _contactNewUsername = null;
                              }),
                            )
                          ],
                        ),
                      ),
                    )
                  else
                    StandardTextEditingField(
                      controller: _usernameSearchController,
                      valueValidator: (value) => null,
                      hintText: '@username',
                      trailingWidget: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : null,
                    ),
                  if (_matchedUsers.isNotEmpty && !_userSelected)
                    TextButton(
                      onPressed: _showMatchedUsers,
                      child: Text('${_matchedUsers.length} matches found'),
                    ),
                  SizedBox(height: screenHeight * 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StandardButton(
                        onButtonTap: () {},
                        buttonTitle: 'Start A Conversation',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
