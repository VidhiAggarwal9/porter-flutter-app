import 'package:flutter/material.dart';
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  List<Map<String, String>> messages = [];
  void sendMessage() {
    String userMessage = controller.text;
    if (userMessage.isEmpty) return;
    setState(() {
      messages.add({
        "sender": "user",
        "message": userMessage,
      });});
    controller.clear();
    botReply(userMessage);
  }void botReply(String message) {
    String reply = "I didn't understand";
    if (message.toLowerCase().contains("hello")) {
      reply = "Hello! How can I help you?";
    } else if (message.toLowerCase().contains("location")) {
      reply = "Click location icon to get your location";
    } else if (message.toLowerCase().contains("help")) {
      reply = "I am here to assist you";
    }Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        messages.add({
          "sender": "bot",
          "message": reply,
        });});});}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chatbot"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isUser =
                    messages[index]["sender"] == "user";
                return Container(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser
                          ? Colors.blue
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      messages[index]["message"]!,
                      style: TextStyle(
                        color: isUser
                            ? Colors.white
                            : Colors.black,
                      ),),),);},),),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "Type message...",
                    contentPadding: EdgeInsets.all(10),
                  ),),),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: sendMessage,
              )],)],),);}}