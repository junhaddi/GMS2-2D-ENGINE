
//	Get Player Input
var key_left, key_right, key_jump, key_sit;
key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_jump = keyboard_check_pressed(vk_up);
key_sit = keyboard_check(vk_down);

//	Cal Direction
var chr_movDir;
chr_movDir = key_right - key_left;

//	Set Speed
chr_vspeed += chr_gravity;
chr_hspeed = chr_movDir * chr_walkSpeed;
clamp(chr_vspeed, -chr_vspeedMax, chr_vspeedMax);

//	Set Xdir
if (chr_movDir != 0)
{
	chr_xdir = chr_movDir;
}

//	Set Jump
if (key_jump && chr_jumpCount > 0)
{
	chr_vspeed = -chr_jumpPower;
	chr_jumpCount -= 1;
}

//	Horizontal Collision
repeat (abs(chr_hspeed))
{
    var chr_mov;
    chr_mov = false;
    if (place_meeting(x + chr_movDir, y, Block))
    {
		//	climb
        for (var i = 1; i <= chr_slopeMax; i++)
        {
            if (!place_meeting(x + chr_movDir, y - i, Block))
            {
                x += chr_movDir;
                y -= i;
                chr_mov = true;  
				show_debug_message("climb");
                break;
            }
        }
        if (chr_mov == false)
        {
            chr_movDir = 0;
			show_debug_message("block");
        }
    }
	else
	{
		//	Down
        if (!place_meeting(x + chr_movDir, y + 1, Block) && place_meeting(x + chr_movDir, y + 2, Block))
        {
            x += chr_movDir; 
            y += 1;     
            chr_mov = true;
			show_debug_message("down");
        }
        if (chr_mov == false) 
        {
            x += chr_movDir; 
        }
    }
}

//	Vertical Collision
if (place_meeting(x, y + chr_vspeed, Block))
{
	while (!place_meeting(x, y + sign(chr_vspeed), Block))
	{
		y += sign(chr_vspeed);
	}
	chr_vspeed = 0;
}
y += chr_vspeed;

//	Jump Reset
if (place_meeting(x, y + 1, Block) && chr_vspeed == 0)
{
	chr_jumpCount = chr_jumpCountMax;
}