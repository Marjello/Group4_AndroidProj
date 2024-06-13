import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showButtons = false;
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    // Schedule the message to be added 3 seconds after the app opens
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _messages.add({'text': 'What do you want to do today?', 'isUserMessage': false});
      });

      // Schedule the buttons to be shown 2 seconds after the message
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _showButtons = true;
          _messages.add({'buttons': true});
        });
      });
    });

    _scrollController.addListener(() {
      if (_scrollController.offset > 200) {
        setState(() {
          _showBackToTopButton = true;
        });
      } else {
        setState(() {
          _showBackToTopButton = false;
        });
      }
    });
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    _controller.clear();
    setState(() {
      _messages.add({'text': text, 'isUserMessage': true});
      _showButtons = false; // Hide the buttons after sending a message
    });

    // Simulate a bot response
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _messages.add({'text': 'Echo: $text', 'isUserMessage': false});
        _showButtons = true; // Show the buttons again after bot response
        _messages.add({'buttons': true});
      });
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Info Chatbot'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF343434), Color(0xFF343434), Color(0xFF4CAF50)],
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8.0),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      if (message.containsKey('buttons') && message['buttons']) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _sendMessage('Student Info');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4D4D4D),
                                minimumSize: const Size(200, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              child: const Text(
                                'Student Info',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _sendMessage('Student Schedule');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4D4D4D),
                                minimumSize: const Size(200, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              child: const Text(
                                'Student Schedule',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _sendMessage('Student Grades');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4D4D4D),
                                minimumSize: const Size(200, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              child: const Text(
                                'Student Grades',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _sendMessage('Student Study Plan');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4D4D4D),
                                minimumSize: const Size(200, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              child: const Text(
                                'Student Study Plan',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _sendMessage('School Calendar/Activities');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4D4D4D),
                                minimumSize: const Size(200, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              child: const Text(
                                'School Calendar/Activities',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      }
                      return Row(
                        mainAxisAlignment: message['isUserMessage']
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          if (!message['isUserMessage'])
                            const CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Icon(Icons.smart_toy_outlined),
                            ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 8.0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 14.0),
                            decoration: BoxDecoration(
                              color: message['isUserMessage']
                                  ? Colors.blueAccent
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7),
                            child: Text(
                              message['text'],
                              style: TextStyle(
                                color: message['isUserMessage']
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                          if (message['isUserMessage'])
                            const CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: Icon(Icons.person),
                            ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // Add your mic button functionality here
                        },
                        icon: const Icon(Icons.mic),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _sendMessage(_controller.text),
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (_showBackToTopButton)
              Positioned(
                bottom: 70,
                right: 16,
                child: FloatingActionButton(
                  onPressed: _scrollToTop,
                  child: const Icon(Icons.arrow_upward),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
