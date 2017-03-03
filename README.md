# About
Diminutive World is an experimental text based RPG game that I am working on.
The idea is to hopefully have a text based map that the user can walk around
freely on.

# Using the code
I am building the code in an Xcode project. I am not sure quite yet on how to
run the code without using Xcode, but here are some things that will need to be
edited for a specific computer.

In file room loader constant `MapPath` should be changed to match the path to
the directory the project is in for the given computer. Hopefully, this can be
fixed later, but because Xcode project puts the compiled file in a different
folder, we have to have the exact path.

# Creating a Map
A map file expects the following format:
The first line should have two integers separated by a comma (",")
The first integer expresses the height of the map and the second expresses width

An example of a room that is 5x5:
```
5, 5
```
The next `height` lines should have `width` characters, these characters design
the room

Example of a room that is 5x5:
```
_____
#   #
#   #
#   #
-----
```

**Character meaning are listed below**

The last lines of the map represent the transfer points Each line should have
the following format

The first two numbers represent the position of the room in which the door is
located the third argument represents the name of the room that the door leads
to (the name of the file the rooms information is in) the last two numbers
represent the destinations room destination position.

Example:
```
0, 14, roomB, 3, 5
```
Here the block at position 0, 14 leads to roomB at position 3, 5.

# Example Room Building
```
15, 15
________ ______
|             |
|             |
|             |
|             |
|             |
|             |
|             |
|             |
|             |
|             |
|             |
|             |
|             |
---------------
0, 7, otherRoom, 14, 7
```

Builds a room that is 15x15 has one door. The door is at (0, 7) and it leads
to (14, 7) in the other room.


# Playing the game

In the game, the character reacts every time you hit enter. There character
reacts based on what input you gave it.
## Moving around
The character can move in 4 different directions the directions and the inputs
that make them move in those directions (any of the inputs work):

  Direction  |     Input
------------ | -------------
   North     |  "go north", "north", "w"
   East      |  "go east",  "east", "d"
   South     |  "go south", "south", "s"
   West      |  "go west",  "west",  "a"


## Interacting with object
Every block is interactable. If you want to interact with a block, you
just type "interact" and you will interact with the block of the direction you
are facing. You are generally facing in the direction you last went (so if you
walk north, you will be facing north")

