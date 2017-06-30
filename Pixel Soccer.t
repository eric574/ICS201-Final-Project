import GUI
forward procedure RunGame ()
forward procedure Instructions ()
setscreen ("graphics:639;399")
var centrex : int := maxx div 2
var centrey : int := maxy div 2
var font1, font2, IntroButtonID : int
var response : string
var flag : boolean := false
var backgroundID, background : int

var bpx, bpy, rpx, rpy, cx, cy, rs, bs, cc, BlueSpeed, RedSpeed, regspeed, sprintspeed, Exit : int
var chars : array char of boolean

bpx := 350 + 50             %blue player x
bpy := 200                  %blue player y
rpx := 350 - 50             %red player x
rpy := 200                  %red player y
cx := 350                   %ball x
cy := 200                   %ball y
cc := 0                     %changes ball colour
rs := 0                     %red teamm score
bs := 0                     %blue team score
Exit := 0
BlueSpeed := 1            %blue speed
RedSpeed := 1               %red speed
regspeed := 4               %Regualar Speed
sprintspeed := 5            %Sprinting speed
var uI : string             %Gets user input
var num : int
var font : int
font := Font.New ("Times New Roman:30")

procedure Intro
    cls
    GUI.SetBackgroundColour (14)
    drawbox (centrex - 100, centrey - 70, centrex + 250, centrey + 100, black)
    font1 := Font.New ("Palatino:12:Bold,Italic")
    Font.Draw ("Welcome to Eric's Soccer Game!", centrex - 70, centrey + 50, font1, black)

    font2 := Font.New ("Palatino:12:Bold,Italic")
    %Make sure to include the date after finishing the program
    Font.Draw ("This program was finished: June 15th", centrex - 70, centrey, font2, black)
end Intro

procedure Background
    View.Set ("graphics:517;576")
    backgroundID := Pic.FileNew ("SoccerPixel.bmp")
    background := Sprite.New (backgroundID)
    Sprite.SetHeight (background, -1)
    Sprite.SetPosition (background, 517 div 2, 576 div 2, true)
    Sprite.Show (background)
    Time.Delay (3000)
end Background

procedure Intro1
    %changes output screen size
    View.Set ("graphics:700;400")
    View.Set ("nobuttonbar")
    cls
    Font.Draw ("Type continue to play the game or quit to quit playing.", centrex - 150, centrey + 50, font1, black)
	get response
	if response = "continue" then
	    Instructions ()
	end if
	if response = "quit" then
	    cls
	    put "You have chosen to quit. \n"
	    Time.Delay (1000)
	    put "The program will now terminate. \n"
	    Time.Delay (1000)
	    cls
	end if
end Intro1

body procedure Instructions
    cls
    Font.Draw ("Type yes to read the instructions or no to play the game.", centrex - 150, centrey + 50, font1, black)
    loop
	get response
	if response = "yes" then
	    cls
	    put "This game is mean to be a multiplayer game that supports two players \n"
	    Time.Delay (1000)
	    put "The objective of the game is to place the soccer ball in the other opponent's "
	    put "net \n"
	    Time.Delay (1000)
	    put "Doing so will give you one point, which will be dispayed on the top. \n"
	    Time.Delay (1000)
	    put "The game ends with either one of the players reaching the score cap, which is "
	    put "determined by user input. \n"
	    Time.Delay (1000)
	    put "For the player on the left, use the WASD keys to move about and for the player "
	    put "on the right, use the left, up, down, irght keys to move about \n"
	    Time.Delay (1000)
	    put "You could also block your opponent by positioning yourself between the soccer "
	    put "ball and your net \n"
	    Time.Delay (1000)
	    put "Have fun! \n"
	    Time.Delay (1000)
	    cls
	    put "Type Play to start playing the game. \n"
	    Time.Delay (1000)
	    loop
		get response
		if response = "Play" then
		    RunGame ()
		end if
		exit when response = "Play"
	    end loop
	elsif response = "no" then
	    put "You will now proceed to the game. \n"
	    Time.Delay (1000)
	    RunGame ()
	end if
	exit when response = "yes" or response = "no"
    end loop
end Instructions

procedure VarReset
    bpx := 350 + 50         %blue player x
    bpy := 200              %blue player y
    rpx := 350 - 50         %red player x
    rpy := 200              %red player y
    cx := 350               %ball x
    cy := 200               %ball y
    cc := 0                 %changes ball colour
    rs := 0                 %red teamm score
    bs := 0                 %blue team score
    Exit := 0
    BlueSpeed := 1        %blue speed
    RedSpeed := 1           %red speed
    regspeed := 4           %Regualar Speed
    sprintspeed := 5        %Sprinting speed
    var uI : string         %Gets user input
    var num : int
end VarReset


procedure OutputScreen
    %changes output screen size
    View.Set ("graphics:700;400")
    View.Set ("nobuttonbar")
end OutputScreen


procedure HowManyPoints
    cls
    loop
	%shows controls
	locate (1, 20) %Locate (1, 20)
	put "Red team use : WASD. " ..
	put "Blue team : arrow keys. "


	%Asks the user how many points someone needs to win
	locate (2, 1)
	put "How many points would you like to play to?"
	get uI
	put ""

	if strintok (uI) then
	    num := strint (uI)
	    put num
	else
	    locate (1, 1)
	    put "That's not a whole number."
	    delay (2000)
	    cls
	end if

	if num > 99 then
	    put "You can only play up to 99 points."
	    delay (2000)
	    cls

	else
	    exit
	end if
    end loop
end HowManyPoints


procedure Visuals

    %background
    drawfillbox (0, 0, maxx, maxy, green)                   %grass
    drawbox (20, 20, maxx - 20, maxy - 20, white)           %touchline
    drawline (350, 20, 350, maxy - 20, white)               %center line
    drawoval (350, 200, 40, 40, white)                      %center circle
    drawfillbox (0, 200 - 50, 19, 200 + 50, black)          %Red team net
    drawfillbox (700 - 20, 200 - 50, 700, 200 + 50, black)     %Blue team net

end Visuals

procedure boundaries
    %boundaries
    if bpx > 690 then     %blue team
	bpx := 690
    elsif bpx < 10 then
	bpx := 10
    elsif bpy > 380 then
	bpy := 380
    elsif bpy < 10 then
	bpy := 10

    elsif rpx > 690 then     %red team
	rpx := 690
    elsif rpx < 10 then
	rpx := 10
    elsif rpy > 380 then
	rpy := 380
    elsif rpy < 10 then
	rpy := 10
    end if
end boundaries


procedure BlueColision

    %collisions
    if cx > bpx and cx < bpx + 18 and cy < bpy + 12 and cy > bpy - 12 then       %right side of blue player to ball
	cx := cx + regspeed
	cy := bpy
	cc := 14
    elsif cx < bpx and cx > bpx - 18 and cy < bpy + 12 and cy > bpy - 12 then       %left side of blue player to ball
	cx := cx - regspeed
	cy := bpy
	cc := 14
    elsif cy > bpy and cy < bpy + 18 and cx < bpx + 12 and cx > bpx - 12 then       %top side of blue player to ball
	cy := cy + regspeed
	cx := bpx
	cc := 14
    elsif cy < bpy and cy > bpy - 18 and cx < bpx + 12 and cx > bpx - 12 then       %bottom side of blue player to ball
	cy := cy - regspeed
	cx := bpx
	cc := 14
    end if

end BlueColision


procedure RedColision

    if cx > rpx and cx < rpx + 18 and cy < rpy + 12 and cy > rpy - 12 then          %right side of red player to ball
	cx := cx + regspeed
	cy := rpy
	cc := 12
    elsif cx < rpx and cx > rpx - 18 and cy < rpy + 12 and cy > rpy - 12 then       %left side of red player to ball
	cx := cx - regspeed
	cy := rpy
	cc := 12
    elsif cy > rpy and cy < rpy + 18 and cx < rpx + 12 and cx > rpx - 12 then       %top side of red player to ball
	cy := cy + regspeed
	cx := rpx
	cc := 12
    elsif cy < rpy and cy > rpy - 18 and cx < rpx + 12 and cx > rpx - 12 then       %bottom side of red player to ball
	cy := cy - regspeed
	cx := rpx
	cc := 12
    end if

end RedColision


procedure touchline
    %touch line {not letting ball go over touch line}
    if cy < 18 then
	cy := cy + 10
    elsif cy > maxy - 18 then
	cy := cy - 10
    elsif cx < 20 then
	cx := cx + 10
    elsif cx > maxx - 10 then
	cx := cx - 10
    end if
end touchline


procedure BlueControl
    %controls for blue team
    Input.KeyDown (chars)

    if chars (KEY_UP_ARROW) then
	bpy := bpy + BlueSpeed
    end if

    if chars (KEY_RIGHT_ARROW) then
	bpx := bpx + BlueSpeed
    end if

    if chars (KEY_LEFT_ARROW) then
	bpx := bpx - BlueSpeed
    end if

    if chars (KEY_DOWN_ARROW) then
	bpy := bpy - BlueSpeed
    end if

end BlueControl


procedure RedControl
    %controls for red team
    Input.KeyDown (chars)

    if chars ('w') then
	rpy := rpy + RedSpeed
    end if
    if chars ('d') then
	rpx := rpx + RedSpeed
    end if

    if chars ('a') then
	rpx := rpx - RedSpeed
    end if

    if chars ('s') then
	rpy := rpy - RedSpeed
    end if

end RedControl


procedure players
    %blue players
    drawfilloval (bpx, bpy, 10, 10, 77)

    %red players
    drawfilloval (rpx, rpy, 10, 10, 12)

end players


procedure ball
    %ball
    drawfilloval (cx, cy, 7, 7, 14)
    drawoval (cx, cy, 7, 7, 7)
    drawoval (cx, cy, 8, 8, cc)
end ball


%changes and check score
procedure BlueScore

    if cx < 22 and cy > 200 - 40 and cy < 200 + 40 then     %blue score
	cls
	locatexy (300, 200)
	put "GOAL FOR THE BLUE TEAM!"
	bs := bs + 1
	bpx := 350 + 50     %blue player x
	bpy := 200          %blue player y
	rpx := 350 - 50     %red player x
	rpy := 200          %red player y
	cx := 350           %ball x
	cy := 200           %ball y
	cc := 0             %changes ball colour
	delay (1000)
	cls
	locatexy (350, 200)
	put "3"
	delay (1000)
	cls
	locatexy (350, 200)
	put "2"
	delay (1000)
	cls
	locatexy (350, 200)
	put "1"
	delay (1000)
	cls
    elsif bs = num then
	cls
	locatexy (350, 200)
	put "BLUE TEAM WINS!"
	delay (2000)
	Exit := 1

    elsif rs = num then
	cls
	locatexy (350, 200)
	put "RED TEAM WINS!"
	delay (2000)
	Exit := 1

    end if
end BlueScore


procedure RedScore
    if cx > maxx - 22 and cy > 200 - 40 and cy < 200 + 40 then     %red score
	cls
	locatexy (300, 200)
	put "GOAL FOR THE RED TEAM!"
	rs := rs + 1
	bpx := 350 + 50     %blue player x
	bpy := 200          %blue player y
	rpx := 350 - 50     %red player x
	rpy := 200          %red player y
	cx := 350           %ball x
	cy := 200           %ball y
	cc := 0             %changes ball colour
	delay (1000)
	cls
	locatexy (350, 200)
	put "3"
	delay (1000)
	cls
	locatexy (350, 200)
	put "2"
	delay (1000)
	cls
	locatexy (350, 200)
	put "1"
	delay (1000)
	cls
    elsif bs = num then
	cls
	locatexy (350, 200)
	put "BLUE TEAM WINS!"
	delay (2000)
	Exit := 1

    elsif rs = num then
	cls
	locatexy (350, 200)
	put "RED TEAM WINS!"
	delay (2000)
	Exit := 1
    end if
end RedScore


procedure ScoreDisplay
    locatexy (1, maxy - 10)
    put "Red: ", rs

    locatexy (maxx - 80, maxy - 10)
    put "Blue: ", bs

end ScoreDisplay


procedure sprint
    %If the ball is within a distance of 18 from the blue player
    if cx > bpx - 18 and cx < bpx + 18 and cy > bpy - 18 and cy < bpy + 18 then
	BlueSpeed := regspeed
    else
	BlueSpeed := sprintspeed
    end if

    %If the ball is within a distance of 18 from the red player
    if cx > rpx - 18 and cx < rpx + 18 and cy > rpy - 18 and cy < rpy + 18 then
	RedSpeed := regspeed
    else
	RedSpeed := sprintspeed
    end if

end sprint

procedure winner
    if bs = num then
	cls
	locatexy (150, 200)
	Font.Draw ("BLUE TEAM WINS!", 150, 200, font, black)
	delay (2000)
	flag := true
	Exit := 1

    elsif rs = num then
	cls
	locatexy (150, 200)
	Font.Draw ("RED TEAM WINS!", 150, 200, font, black)
	delay (2000)
	flag := true
	Exit := 1
    end if
end winner

Intro ()
Time.Delay (3000)
cls
Background ()
Time.Delay (1000)
Sprite.Hide (background)
Intro1 ()
Time.Delay (1000)

body procedure RunGame

    VarReset     %Used to reset all of the methods and variables
    OutputScreen     %Uses View.Set
    HowManyPoints     %Get the score cap from the user

    loop
	OutputScreen
	Visuals     %Draw field
	touchline     %First collision detection procedure
	boundaries     %Second collision detection procedure
	BlueColision     %Third collision detection procedure
	RedColision     %Fourth collision detection procedure
	BlueControl     %Input from blue user
	RedControl     %Input from red user

	%Draw everything else
	players     %Draw players
	ball     %Draws ball
	winner     %Output winner
	BlueScore     %When blue user scores
	RedScore     %When red user scores
	ScoreDisplay     %Display the scores of red and blue users
	sprint     %Set the speeds of each user
	exit when flag = true
	delay (20)
    end loop
    if flag then
	cls
	Intro1 ()
    end if
end RunGame
