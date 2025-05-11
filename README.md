Firebase Configuration

Ensure that Firebase Authentication is enabled for Email/Password.

Create Firestore collections for storing user tasks.

Firestore structure example:

users
  └── userId
        └── tasks
              ├── taskId
                  └── {title, description, date, isDone}

📸 Details

Login Screen: User authentication via Firebase.

Task List: Display all tasks with status indicators.

Task Editor: Add, update, and delete tasks.

Dark and Light Themes: User-controlled theme switching.

🤝 Contributing

Fork the repository.

Create a new branch (feature/new-feature).

Commit changes.

Push to the branch.

Create a Pull Request.

📧 Contact

For any questions or suggestions, feel free to reach out at [Your Email Address].
