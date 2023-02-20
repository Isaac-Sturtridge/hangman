# hangman
This is a command-line game of hangman, played through Ruby. File saves are handled using basic JSON.

To play, run the code on the command line. Type a single letter to advance your guesses.
If you type 'save {filename}', your game will be saved. You can then exit the command line and resume your session with 'load {filename}'. Be aware that as of current build, looking inside the savefile will spoil the answer.