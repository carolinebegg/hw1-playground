# *A Court of Thorns and Roses*

*For instructions, consult the [CIS 1951 website](https://www.seas.upenn.edu/~cis1951/24fa/assignments/hw/hw1).*

## Explanations

**What locations/rooms does your game have?**

1. The Wall (starting location)
2. East Wall
3. West Wall
4. Approach the Wall Faerie
5. Bargaining with the Wall Faerie
6. Forest Bordering The Wall
7. Edge of the Forest
8. Forest Clearing
9. Middle of the Forest
10. Dark Forest
11. The Mortal Lands
12. The Spring Court

**What items does your game have?**

1. Magic Amulet
2. Iron Dagger

**Explain how your code is designed. In particular, describe how you used structs or enums, as well as protocols.**

*My code incorporates several key concepts we learned in class, including structs, enums, and protocols, to create a well-structured and functional game. I defined a Location protocol to serve as a blueprint for all game locations, specifying essential properties like name, description, exits, actions, and items. The Court struct conforms to this protocol and is used to instantiate all the locations in the game; in the context of the book series, a "court" refers to the different kingdoms.

Additionally, I implemented two other structs: Item and Action. The Item struct represents magical items within the game. Although it currently only stores the item's name, I designed it as a struct to allow for future expansion of item functionalities. The Action struct works in tandem with the ActionType enum to manage the various actions a player can perform to interact with their environment. The ActionType enum defines the possible actions, while the Action struct associates each action type with its corresponding descriptive message.*

**How do you use optionals in your program?**

*In my project, optionals are used to handle situations where certain values may or may not be present during gameplay, which is crucial for a text-based adventure game where player choices affect the state. A non-trivial use of optionals occurs when the player attempts to take or wear an item; the program safely checks if the item exists in the current location or inventory by using optional binding on the index returned from search methods. For example, when a player tries to take an item, the code uses if let index = location.items.firstIndex(...) to determine if the item is actually there, handling the nil case by informing the player if it's not found. This ensures that the game can gracefully handle invalid actions without crashing and provides meaningful feedback to the player. Overall, optionals enhance the game's robustness by managing the uncertainties inherent in player interactions.*

**What extra credit features did you implement, if any?**

* *I utilized rich text formatting to customize the UI of my program, enhancing its visual appeal and readability. At the start of the game, I changed the header text to green italics to make it stand out and set the tone. I also added customized end-game messages: the success message is displayed in green italics to signify achievement, while the failure messages appear in red to indicate an unfavorable outcome. Lastly, I modified the color of the heading for the available commands to green as well, creating a consistent and engaging interface throughout the game.*

## Endings

### Ending 1: Successfully Enter the Spring Court Via a Sneaky Bargain with the Wall Faerie

```
["south", "south", "south", "take amulet", "wear amulet", "north, "north", "north", "west", "approach", "bargain", "accept"]
```

### Ending 2: Successfully Enter the Spring Court Via a Hole in The Wall

```
["east", "cross"]
```

### Ending 3: Die Trying to Enter the Spring Court Via a Bad Bargain with the Wall Faerie

```
["north", "north", "north", "west", "approach", "bargain", "accept"]
```

### Ending 4: Die From a Beast Attack in the Forest 

```
["south", "south", "east"]
```