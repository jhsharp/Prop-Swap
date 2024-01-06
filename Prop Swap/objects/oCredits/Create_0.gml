text[0] = "Programming/Design:\nJacob Sharp\n   \nArt:\nLuke Sharp";
text[1] = "Music:\n   \nMenu Theme:\n\"8 Bit Metal\" by SketchyLogic\n   \nCredits Theme:\n\"Lines of Code\" by Trevor Lentz"
text[2] = "Area 1 Theme:\n\"Map\" by SketchyLogic\n   \nArea 2 Theme:\n\"Mercury\" by SketchyLogic\n   \nArea 3 Theme:\n\"Soul Protector\" by DJ Soul 22"
text[3]	= "Game Produced With\nGameMaker Studio 2";
text[4] = "This game was originally made for\nGMTK Game Jam 2021\n     \nThe theme of the jam was\n\"Joined Together\"";
text[5] = "Thank you for playing!\n          \nWe hope you enjoyed it!";

spd = 0.25;
letters = 0;
currentline = 0;
length = string_length(text[currentline]);
mytext = "";

finished = false;
wait_time = room_speed * 5;
wait = true;

RES_W = 1024;
RES_H = 768;