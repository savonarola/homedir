This project is custom config bundle.
The config is installed on many machines, which work under Linux or MacOS
When making changes
* Make them portable, never use MacOS/Linux specific paths. Portability options:
  - Use generic paths and commands, relying on PATH.
  - In shell/installation code, use switch based on uname.
  - For something completely specific, suppress usage on unavailable platform.
* Make them installed and activated via `install.py`.
* Never make local configs reference this project's configs unless the reference/link is created via installation.
