
//	Get Player Input
var key_left, key_right, key_jump, key_sit;
key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_jump = keyboard_check_pressed(vk_up);
key_sit = keyboard_check(vk_down);

//	Set Speed
chr_vspeed += chr_gravity;
chr_hspeed = key_right - key_left;
clamp(chr_vspeed, -chr_vspeedMax, chr_vspeedMax);

//	Set Xdir
if (chr_hspeed != 0)
{
	chr_xdir = chr_hspeed;
}

//	Jump
if (key_jump && chr_jumpCount > 1)
{
	chr_vspeed = -chr_jumpPower;
	chr_jumpCount -= 1;
}

//	Horizontal Collision
repeat (abs(chr_hspeed * chr_walkSpeed))
{
    var mov;
    mov = false;
    if (place_meeting(x + chr_hspeed, y, Block))
    {
		//	climb
        for (var i = 1; i <= chr_slopeMax; i++)
        {
            if (!place_meeting(x + chr_hspeed, y - i, Block))
            {
                x += chr_hspeed;
                y -= i;
                mov = true;   
                break;
            }
        }
        if (mov == false)
        {
            chr_hspeed = 0;
        }
    }
	else
	{
		//	Down
        for (var i = chr_slopeMax; i >= 1; i--)
        {
            if (!place_meeting(x + chr_hspeed, y + i, Block))
            {
                if (place_meeting(x + chr_hspeed, y + i + 1, Block))
                {
                    x += chr_hspeed; 
                    y += i;     
                    mov = true;    
                }
            }
        }
        if (mov == false) 
        {
            x += chr_hspeed; 
        }
    }
}

//	Vertical Collision
if (place_meeting(x, y + 1, Block))
{
	chr_jumpCount = chr_jumpCountMax;
}

if (place_meeting(x, y + chr_vspeed, Block))
{
	while (!place_meeting(x, y + sign(chr_vspeed), Block))
	{
		y += sign(chr_vspeed);
	}
	chr_vspeed = 0;
}
y += chr_vspeed;