✅ TaskMaster - Your Ultimate ToDo Manager

A feature-rich ToDo application built using Flutter and Firebase, allowing users to manage their tasks efficiently with authentication, task management, and theme customization.

✨ Features

User Authentication: Log in and log out using Firebase Authentication.

Task Management: Add, update, delete, and mark tasks as done.

Date Selection: Schedule tasks for specific dates.

Theme Support: Switch between Light and Dark themes.

User-Specific Data: Each user's tasks are stored separately in Firebase Firestore.

🛠️ Technologies Used

Flutter

Firebase Authentication

Firebase Firestore

Provider (for state management)

SharedPreferences (for theme persistence)

📝 Firebase Configuration

Ensure that Firebase Authentication is enabled for Email/Password.

Create Firestore collections for storing user tasks.

Firestore structure example:

users
  └── userId
        └── tasks
              ├── taskId
                  └── {title, description, date, isDone}
