import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import to change status bar color
import 'package:url_launcher/url_launcher.dart';

// 1. **Introduction**
// This page represents the developer's profile in the app, showcasing their background, skills, and contact information. The profile is divided into sections: an image, name, biography, technical skills, and social media links.
class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});
  // URLs for GitHub, LinkedIn, and YouTube profiles
  final String githubUrl = 'https://github.com/salimbyte';
  final String linkedinUrl = 'https://www.linkedin.com/in/salim-suleiman-35b08620a?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=ios_app';
  final String youtubeUrl = 'https://youtube.com/@salimbyte?si=-oVkx8ltuIixbldR';

  // Function to launch URLs
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  // Helper method to create styled buttons
  Widget _buildSocialButton(String url, String label) {
    return ElevatedButton(
      onPressed: () => _launchURL(url),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        backgroundColor: Colors.green,
        elevation: 1, // Remove the shadow from the AppBar
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5), // Adjusted border radius here
        ),
        textStyle: TextStyle(fontSize: 16),
      ),
      child: Text(label),
    );
  }



  @override
  Widget build(BuildContext context) {
    // 2. **Status Bar Customization**
    // Set the status bar color to green, providing a consistent and branded look throughout the app.
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.green, // Set the status bar color to green
      statusBarIconBrightness: Brightness.light, // Optional: set status bar icons to light color
    ));

    return Scaffold(
      // 3. **AppBar**
      // The AppBar at the top includes the title 'About Me' and has a green background to match the overall theme.
      appBar: AppBar(
        title: const Text('About Me'),
        backgroundColor: Colors.green, // Set the AppBar color to green
        elevation: 2, // Remove the shadow from the AppBar
      ),
      body: SingleChildScrollView(  // Allows the content to be scrolled if it exceeds the screen size
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 4. **Profile Image Section**
              // Displays a circular profile image using the ClipOval widget. This ensures that the image has a circular shape.
              Center(
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/salim3.jpeg', // Ensure the image is in the correct folder
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,  // Ensures the image fills the space without distortion
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // 5. **Name and Title**
              // The developer's name and student ID are displayed here, with distinct styling for emphasis.
              const Text(
                'Salim Suleiman Abubakar',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "U1/21/CSC/0796",
                style: TextStyle(fontSize: 15, color: Colors.black38),
              ),
              const SizedBox(height: 16),
              // 6. **About Me Section**
              // A brief paragraph explaining who the developer is and their current focus areas.
              const Text(
                'I\'m a software engineer who enjoys programming, building different apps, and creating coding tutorials on YouTube. I\'m currently focused on learning Flutter development and exploring new technologies like React.js, Python, Svelte.js, REST APIs, and Django.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              const Text(
                'I aim to start or join a successful company with the goal of having a positive impact on the world. I am dedicated to giving my best to make this dream a reality.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              // 8. **Technical Skills Section**
              // Lists the technical skills the developer possesses. These include expertise in various programming languages and technical domains like web scraping and database management.
              const Text(
                'Technical Skills:',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.arrow_forward_rounded, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      const Text('Web Scraping', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.arrow_forward_rounded, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      const Text('Product Management', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.arrow_forward_rounded, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      const Text('Design and Analysis of Algorithms', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.arrow_forward_rounded, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      const Text('Artificial Intelligence', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.arrow_forward_rounded, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      const Text('Compiler Design', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.arrow_forward_rounded, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      const Text('YouTube Content Creation', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.arrow_forward_rounded, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      const Text('Google Search Expertise', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.arrow_forward_rounded, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      const Text('Problem Solving', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.arrow_forward_rounded, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      const Text('Startup Contributions', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.arrow_forward_rounded, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      const Text('Open Source Contributions', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.arrow_forward_rounded, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      const Text('Basic Database Management', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // 9. **Languages Section**
              // Lists the developer's programming language skills such as Python, JavaScript, HTML, and CSS.
              const Text(
                'Languages I Know:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.arrow_forward_rounded, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      const Text('Python', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.arrow_forward_rounded, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      const Text('Java', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.arrow_forward_rounded, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      const Text('Javascript', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.arrow_forward_rounded, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      const Text('Html & Csc', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // 9. **Languages Section**
              // Lists the developer's programming language skills such as Python, JavaScript, HTML, and CSS.
              const Text(
                'Software Engineering Report: Flutter Development and UI/UX Implementation:',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                '1. Introduction',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'This report documents the development process of a Flutter-based mobile application with a focus on both functional and user interface (UI) design. The app’s primary feature is a weather application that allows users to search for city weather and explore details on a dedicated page. The app also includes a personal profile page that showcases the developer’s bio and contact information.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              const Text(
                '2. Project Overview',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.arrow_forward_rounded, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      const Text('Weather App', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  // const Icon(Icons.check_circle, color: Colors.green, size: 20),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                "1. The project includes the following core components:",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              const Text(
                "2. Displays real-time weather details such as temperature, humidity, and condition.",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              const Text(
                "3. Provides an intuitive search interface with location suggestions",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.arrow_forward_rounded, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      const Text('Developer Profile Page', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  // const Icon(Icons.check_circle, color: Colors.green, size: 20),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                "1. Displays personal information, skills, and social media links.",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              const Text(
                "2. Organized into sections for easy navigation, featuring a clean and responsive design.",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              // 11. **Social Media Links Section**
              // Provides buttons for users to follow the developer on various platforms like GitHub, LinkedIn, and YouTube.
              const Text(
                'Follow Me Online:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // 10. **Social Media Links Buttons**
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton(githubUrl, 'GitHub'),
                      SizedBox(width: 5),
                      _buildSocialButton(linkedinUrl, 'LinkedIn'),
                      SizedBox(width: 5),
                      _buildSocialButton(youtubeUrl, 'YouTube'),
                    ],
                  ),
              ),
              )],
          ),
        ),
      ),
    );
  }
}


