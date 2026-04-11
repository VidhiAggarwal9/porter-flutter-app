class ChatbotService {
  // Function to generate bot response
  static Future<String> getResponse(String message) async {
    // Simulate typing delay
    await Future.delayed(const Duration(milliseconds: 800));
    message = message.toLowerCase();
    // Greetings
    if (message.contains("hello") || message.contains("hi")) {
      return "Hello 👋 How can I help you today?";
    }
    // How are you
    else if (message.contains("how are you")) {
      return "I'm doing great 😊 How about you?";
    }
    // App info
    else if (message.contains("app") || message.contains("application")) {
      return "This is a Flutter demo app with Login, Location and Chatbot features.";
    }
    // Location
    else if (message.contains("location")) {
      return "You can view your current location by clicking the location icon in the app.";
    }
    // Product
    else if (message.contains("product")) {
      return "We have Shoes, Watches, Bags and Headphones available.";
    }
    // Price
    else if (message.contains("price")) {
      return "Prices start from ₹1499.";
    }
    // Help
    else if (message.contains("help")) {
      return "I can help you with:\n• Products\n• Location\n• App Info\n• Prices";
    }
    // Thanks
    else if (message.contains("thanks") || message.contains("thank you")) {
      return "You're welcome 😊";
    }
    // Default Response
    else {
      return "I'm not sure I understand. Try asking about products, location, or help.";
    }
  }
}