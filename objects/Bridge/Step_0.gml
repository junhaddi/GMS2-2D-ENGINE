/// @description Insert description here
// You can write your code in this editor
repeat(abs(floor(block_speed)))
{
	if (!place_empty(x + block_dir, y))
	{
		block_dir *= -1;
		break;
	}
	x += block_speed * block_dir;
}