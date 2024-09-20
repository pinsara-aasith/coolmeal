import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = ['Hi !'];
  final List<String> _responses = ["Hi !! I am food related chat bot . "];
  // For set circular process indicater
  bool _isLoading = false;

  Future<void> _sendMessage() async {
    final userMessage = _controller.text;

    if (userMessage.isEmpty) return;

    // Add the user's message to the list
    setState(() {
      _messages.add(userMessage);
      _controller.clear();
      _isLoading = true; // Show the loading indicator
    });

    // Send POST request to the backend
    final url = Uri.parse('http://13.61.4.28/chat?query=$userMessage');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'query': userMessage, // Add the userMessage to the request body
      }),
    );

    if (response.statusCode == 200) {
      // Parse the response body
      final responseBody = json.decode(response.body);

      setState(() {
        _responses.add(responseBody['response']
            ['result']); // Assuming 'result' contains the string you want
        _isLoading = false; // Hide the loading indicator
      });
    } else {
      // Handle error response
      setState(() {
        _responses.add('Error: Could not retrieve response');
        _isLoading = false; // Hide the loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CoolBOT',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 193, 39),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Color.fromARGB(255, 2, 2, 2),
              size: 30,
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const Drawer(),
      body: Stack(
        children: [
          Column(
            children: [
              // Add image
              const Image(
                image: AssetImage('assets/images/chatbot_page.png'),
                width: 200,
                height: 200,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .stretch, // Allows full-width alignment
                      children: [
                        Align(
                          alignment: Alignment
                              .centerLeft, // Aligns the message to the left
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 211, 232, 231),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              _messages[index],
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        if (index < _responses.length)
                          Align(
                            alignment: Alignment
                                .centerRight, // Aligns the response to the right
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 124, 246, 134),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 124, 246, 134),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  _responses[index],
                                  style: const TextStyle(color: Colors.black87),
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Type here',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: _sendMessage,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          color: Colors.teal,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Display the loading indicator when _isLoading is true
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
