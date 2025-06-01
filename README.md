# Woven Monopoly (Ruby CLI Version)

This is a beginner-friendly Ruby version of the Woven Monopoly game.  
It’s a simple command-line app where the dice rolls are set ahead of time, the game is deterministic.

---

## Game Rules

- 4 players: Peter, Billy, Charlotte, Sweedal
- Everyone starts with **$16** and begins on **GO**
- Roll values are preloaded from a JSON file (so the game is predictable)
- You earn **$1** every time you pass GO
- If you land on an unowned property, you **must** buy it
- If you land on someone else’s property, you pay rent
  - Rent is doubled if the owner has all properties of that color
- The game ends when **someone goes bankrupt**
- The player with the **most money left** wins

---

##  How to Run

1. Make sure you have **Ruby** installed
2. Clone the project
    git clone https://github.com/shwetha-raghava10/woven_monopoly.git
    cd woven_monopoly
3. In your terminal, run:
    ruby main.rb
Choose a roll file:
Enter 1 for rolls_1.json
Enter 2 for rolls_2.json

##  Project Structure
woven_monopoly/
├── main.rb            # Runs the game
├── README.md          # This file
├── data/
│   ├── board.json     # Property layout
│   ├── rolls_1.json   # First set of rolls
│   └── rolls_2.json   # Second set of rolls
├── lib/
│   ├── board.rb       # Loads board data
│   ├── game.rb        # Main game logic
│   ├── player.rb      # Player class
│   └── property.rb    # Property class


