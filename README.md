
# Fitness-Tracker-flutter-project
This a dart&amp; flutter project for graduation.

# Fitness Tracker App

A comprehensive cross-platform fitness tracking application that allows users to track workouts, daily steps, calories burned, set fitness goals, view progress, and manage daily goals. Built with Flutter and Firebase, the app provides an interactive and user-centered design.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Screenshots](#screenshots)
- [Installation](#installation)
- [Usage](#usage)
- [Folder Structure](#folder-structure)
- [Technologies Used](#technologies-used)
- [Contributing](#contributing)
- [License](#license)

## Overview

The **Fitness Tracker App** is designed to help users manage their fitness journeys by setting goals, logging workouts, tracking steps, monitoring calorie intake, and viewing daily progress reports. User data is securely stored using Firebase Authentication and Firestore.

## Features

- **User Authentication:** Sign up and log in functionality with Firebase Authentication.
- **Goal Setting:** Users can set daily step and calorie goals.
- **Workout Logging:** Log various workouts with duration and calories burned.
- **Daily Steps Logging:** Track steps taken each day.
- **Progress Report:** View daily and cumulative progress against goals.
- **Settings:** User settings for viewing details and logging out.
- **Real-time Updates:** All data, including goals and progress, sync in real-time with Firestore.

## Screenshots

![image](https://github.com/user-attachments/assets/92dbc0a2-251c-4108-af0e-093f6a8168b8)
![image](https://github.com/user-attachments/assets/55532728-fe86-4269-8b3f-d55d5ff14ff9)
![image](https://github.com/user-attachments/assets/32b1a834-6f7c-4bb3-bf2b-470fabf9e162)
![image](https://github.com/user-attachments/assets/98b8a1b5-8525-4d1f-8767-7a1ae7bbb125)
![image](https://github.com/user-attachments/assets/ce27aead-9fe0-4b58-9c9d-4e3449b57495)
![image](https://github.com/user-attachments/assets/e2c6189e-4b91-4d8e-8204-7861cf42a98e)

## Installation

To set up this project locally, follow these steps:

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/SilasHAKUZWIMANA/Fitness-Tracker-flutter-project.git
   cd Fitness-Tracker-flutter-project

Install Dependencies: Ensure Flutter is installed. Then, install the project dependencies:

## bash

flutter pub get

## Configure Firebase:

Go to the Firebase Console, create a new project, and add an Android and/or iOS app.
Download the google-services.json (Android) or GoogleService-Info.plist (iOS) file and place it in the appropriate directories.
Enable Authentication and Firestore Database on Firebase.
Update the Firestore rules to secure data access.
Run the Application:

## bash

flutter run
## Usage

## Dashboard

The Dashboard displays a greeting, daily goals, quick actions for logging activities, recent activity summaries, and a button to view the detailed progress report.

## Quick Actions

Quick actions allow users to:
Set Goal: Define daily goals for steps and calories.
Add Workout: Log a new workout session.
Log Steps: Input daily step count.
Update Progress: Review or update personal fitness progress.

## Progress Report

The Progress Report screen provides an overview of the user's fitness journey over time, with details on steps, calories, and workouts.

User Settings
In the Settings, users can view their profile information (name, email, phone) and log out of the application.
## Folder Structure

fitness_tracker_app
|-- lib/
|   |-- main.dart                # Entry point of the application
|   |-- dashboard_screen.dart     # Main Dashboard screen
|   |-- goal_setting_screen.dart  # Screen for setting fitness goals
|   |-- workout_screen.dart       # Screen for adding a workout session
|   |-- step_entry_screen.dart    # Screen for logging daily steps
|   |-- progress_entry_screen.dart# Screen for updating progress
|   |-- progress_report_screen.dart # Screen for viewing detailed progress report
|   |-- login_screen.dart         # User authentication screen
|-- assets/                       # Folder for assets (images, icons, etc.)
|-- pubspec.yaml                  # Pubspec file with dependencies

## Technologies Used

Dart with Flutter - For building the cross-platform user interface.
Firebase - Backend as a service for authentication and real-time data storage with Firestore.
Cloud Firestore - Secure and scalable data storage for user goals, workouts, and progress tracking.
Contributing

## Fork the repository.

Create a new branch with your feature or bug fix.
Commit and push changes to your fork.
Open a pull request with a detailed description of your changes.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

This `README.md` provides clear instructions for setting up, using, and understanding the app’s structure.

# fitness_tracker

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
