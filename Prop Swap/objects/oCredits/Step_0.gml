//Progress Text
letters += spd;
mytext = string_copy(text[currentline], 1, floor(letters));

//Next Line
if (letters >= length)
{
	if (finished == false)
	{
		finished = true;
		alarm[0] = wait_time;
	}
	if (wait == false)
	{
		if (currentline + 1 == array_length_1d(text))
		{
			SlideTransition(TRANS_MODE.GOTO, rMenu);
		}
		else
		{
			currentline++;
			letters = 0;
			length = string_length(text[currentline]);
			finished = false;
			wait = true;
		}
	}
}