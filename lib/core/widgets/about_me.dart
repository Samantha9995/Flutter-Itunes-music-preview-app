import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

// Copyright (c) 2025 SADev. All rights reserved.

class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});

  @override
  Widget build(BuildContext context) {
    final logger = Get.find<Logger>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('about_the_developer').tr(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/47018729?s=400&u=ac0b960ea6d173bf2403ab5e9a465071665e6da4&v=4'),
            ),
            const SizedBox(height: 16),
            const Text('SADev',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text('Android & Flutter Developer',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                "Hey! I'm Samantha, an Android & Flutter Developer working on this iTunes music preview app. I'm passionate about building great mobile experiences and love discovering new music. Feel free to reach out! Check out my GitHub and I hope you enjoy using this app!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: Image.asset('assets/images/github_icon.png',
                        width: 24, height: 24),
                    onPressed: () async {
                      // Mark the function as async
                      final Uri url =
                          Uri.parse('https://github.com/Samantha9995');
                      if (await canLaunchUrl(url)) {
                        // Check if the URL can be launched
                        await launchUrl(url); // Launch the URL
                      } else {
                        // Handle the error if the URL couldn't be launched
                        logger.e('Could not launch gitURL');
                        // Optionally, show an error message to the user using a SnackBar or AlertDialog
                      }
                    }),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Copyright © 2025 SADev',
                style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
