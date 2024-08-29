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
  final List<String> _messages = ["Give me nutrition of rice ?"];
  final List<String> _responses = [
    "Below is the nutritional breakdown\n• Calories: 130 kcal\n• Carbohydrates: 28.2 g\n• Protein: 2.4 g\n• Fat: 0.3 g"
  ];

  Future<void> _sendMessage() async {
    final userMessage = _controller.text;

    if (userMessage.isEmpty) return;

    // Add the user's message to the list
    setState(() {
      _messages.add(userMessage);
      _controller.clear();
    });

    // Send POST request to the backend
    final url = Uri.parse('http://13.61.4.28/chat/query=$userMessage');
    print("User message: $userMessage");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    print(response.body);

    if (response.statusCode == 200) {
      // Parse the response body
      final responseBody = json.decode(response.body);

      // Add the response to the list
      setState(() {
        _responses.add(responseBody[
            'response']); // Assuming the response is under 'response' key
      });
    } else {
      // Handle error response
      setState(() {
        _responses.add('Error: Could not retrieve response');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CoolBOT'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const Drawer(),
      body: Column(
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
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch, // Allows full-width alignment
                  children: [
                    Align(
                      alignment: Alignment
                          .centerLeft, // Aligns the message to the left
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.teal[50],
                          borderRadius: BorderRadius.circular(8),
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
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _responses[index],
                            style: const TextStyle(color: Colors.black87),
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
    );
  }
}
