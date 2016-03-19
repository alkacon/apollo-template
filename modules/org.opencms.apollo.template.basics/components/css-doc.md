# Possible colors 
white, 
black, 
blue, 
blue-light, 
blue-lighter, 
blue-dark, 
blue-darker, 
red, 
red-light, 
red-lighter, 
red-dark, 
red-darker, 
orange, 
orange-light, 
orange-lighter, 
orange-dark, 
orange-darker, 
cyan, 
gray, 
gray-lighter, 
gray-light, 
gray-dark, 
gray-darker, 
sea, 
yellow, 
blue-cyan, 
violet, 
brown, 
red-orange, 
red-cyan, 
green, 
green-light

# Available CSS classes

## Background 
*bg-{color}*
-	{color}: One of the possible colors.

### Transparency 
*bg-{color}-{level}*	
-	{color}: One of the possible colors.	
-	{level}: Number between 1 and 9.

## Borders
*b-{color}-{line-size}-{style}*
-	{color}: One of the possible colors.
-	{line-size}: Number between 1 and 10.
-	{style}: solid, dashed, dotted
*b{side}-{color}-{line-size}-{style}*
-	{side}: top (t), right (r), bottom (b), left (l) 
-	{color}: One of the possible colors.
-	{line-size}: Number between 1 and 10.
-	{style}: solid, dashed, dotted

### Rounded Corners
*br-{radius}*
-	{radius}: Number between 1 and 30.
*br{side}-{radius}* 
-	{side}: top-left (tl), top-right (tr), bottom-left (bl),  -	bottom-right (br)
-	{radius}: Number between 1 and 10.

## Text 
### Alignment
*fa-{align}*
-	{align}: left, right, center
### Color
*fc-{color}*
-	{color}: One of the possible colors.

### Size
*fs-{fontsize}*
-	{fontsize}: 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 18, 20, 22, 24, 26, 28, 30, 36, 48, 72

## Link color
*lc-{color}*
-	{color}: One of the possible colors.

## Line height
*.lh-{height}*
-	{height}: 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20


## Margin and Padding
*m{side}-{space} or p{side}-{space}*
-	{side}: all (), vertical (v), horizontal (h), top (t), right (r), bottom (b), left (l)
-	{space}: 0, 1, 2, 3, 4, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90, 100, 500, 1000, 2000
