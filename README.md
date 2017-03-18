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
A map is created using XML.

Currently the accepted tags for a room are:
<door>... </door>
<wall>... </wall>
<size> ... </size>

<door> need the following tags and formats
<location> int, int </location>
<destinationRoom> someRoomName </destinationRoom>
<destinationLocation> int, int <destinationLocation>

An extra wall can be built in the following manner:
<wall> x, y </wall>

Where x, y is the x and y position of the wall within the room.
(Note: the top left corner of the room is 0, 0)

<size> sets the size of the room (the room is assumed to be surrounded by walls)
Size format:
<size> height, width </size>


Making a room having battles is done by setting the battle rate.
The battle rate is an integer out of 100 and can be set like this:

<battleRate> 10 </battleRate>
