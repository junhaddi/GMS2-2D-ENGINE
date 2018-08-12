/// @description Insert description here
// You can write your code in this editor
if (instance_exists(obj_chr))
{
	if (round(obj_chr.y + (obj_chr.sprite_width / 2)) > y)
	{
		mask_index = -1;
	}
	else
	{
		mask_index = spr_platform;
	}
}