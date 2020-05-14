function character()
quads = {
love.graphics.newQuad(0, 0, 62, 54, images["player.png"]:getDimensions()),
love.graphics.newQuad(62, 0, 62, 54, images["player.png"]:getDimensions()),
love.graphics.newQuad(124, 0, 62, 54, images["player.png"]:getDimensions()),
love.graphics.newQuad(186, 0, 62, 54, images["player.png"]:getDimensions()),
love.graphics.newQuad(248, 0, 62, 54, images["player.png"]:getDimensions()),
love.graphics.newQuad(310, 0, 62, 54, images["player.png"]:getDimensions()),
love.graphics.newQuad(372, 0, 62, 54, images["player.png"]:getDimensions()),
love.graphics.newQuad(434, 0, 62, 54, images["player.png"]:getDimensions()),
love.graphics.newQuad(496, 0, 62, 54, images["player.png"]:getDimensions()),

love.graphics.newQuad(0, 54, 62, 54, images["player.png"]:getDimensions()),
love.graphics.newQuad(62, 54, 62, 54, images["player.png"]:getDimensions()),
love.graphics.newQuad(124, 54, 62, 54, images["player.png"]:getDimensions()),
love.graphics.newQuad(186, 54, 62, 54, images["player.png"]:getDimensions()),
love.graphics.newQuad(248, 54, 62, 54, images["player.png"]:getDimensions()),
love.graphics.newQuad(310, 54, 62, 54, images["player.png"]:getDimensions()),
love.graphics.newQuad(372, 54, 62, 54, images["player.png"]:getDimensions()),
love.graphics.newQuad(434, 54, 62, 54, images["player.png"]:getDimensions()),
love.graphics.newQuad(496, 54, 62, 54, images["player.png"]:getDimensions())
}
end

function love.load()
	images = { }
	for i,v in ipairs(love.filesystem.getDirectoryItems("images")) do
		if love.filesystem.isFile("images/" .. v) and
				v:sub(-4) == ".png" then
			images[v] = love.graphics.newImage("images/" .. v)
		end
	end
	music = { }
	for i,v in ipairs(love.filesystem.getDirectoryItems("music")) do
		if love.filesystem.isFile("music/" .. v) and
				(v:sub(-4) == ".wav" or v:sub(-4) == ".mp3") then
			music[v] = love.audio.newSource("music/" .. v)
		end
	end
   timeLimit = 60
   items = {}
   character()
   tr = false
   eventEnd = false
   intro = love.graphics.newVideo("images/Intro.ogv")
   event = 1
   tp = 0
   xpos = 250+37
   n = 1
   n2 = 18
   bg = 1 
   counter = 1
   min_dt = 1/60
   next_time = love.timer.getTime()
   quad = quads[n]
   quad2 = quads[n2]
   font = love.graphics.newFont("nineteen.ttf", 48)
   curpos = ypos
   up = false
   down = false
   eventExit = false
   fall = false
   ygarb = 52
   ygarb2 = 52
   ygarb3 = 52
   ygarb4 = 52
   ygarb5 = 52
   ygarb6 = 52
   ygarb7 = 52
   ygarb8 = 52
   ygarb9 = 52
   xgarb = math.random(0,989)  
   xgarb2 = math.random(0,989)
   xgarb3 = math.random(0,989) 
   xgarb4 = math.random(0,989)
   xgarb5 = math.random(0, 989)
   xgarb6 = math.random(0, 989)
   xgarb7 = math.random(0,989)
   xgarb8 = math.random(0,989)
   xgarb9 = math.random(0, 989)
   menu = false
   menuQuit = false
   Totalpts = 0
   throw = 1
   tp2 = 0
   tp3 = 0
   dir = 1
   dir2 = 2
   time_update = 0
   move1 = 1
   move2 = 1
   move3 = 1
   pts = 0
   deltaT = 0
   char_move = false
   touchx = 50
   ypos = 280
   ypos2 = 364
   curpos = ypos
   time_update = 0
   music["score1.wav"]:setVolume(0.75)
   music["score2.wav"]:setVolume(0.75)
   if love.system.getOS() == "Android" then --or love.system.getOS() == "iOS"
	   control = 1
	   love.window.setFullscreen(true)
   else 
	   control = 2
   end
   width,height = love.graphics.getDimensions()
end
function love.draw()
	local cur_time = love.timer.getTime()
	if next_time <= cur_time then
      next_time = cur_time
      return
	end
	love.timer.sleep(next_time - cur_time)
    love.graphics.setFont(font)
	love.graphics.scale(width/1024,height/600)
	local tp = tp + love.timer.getDelta()
	if event == 1 then 
		love.graphics.draw(intro, 0, 0)
	end 
	if event == 2 then
		love.graphics.draw(images["title_screen.png"],0,0)
	end
	if event == 3 then 
		love.graphics.draw(images["Select_Screen.png"],0,0)
	end
	if event == 4 then
		if bg == 1 then
			love.graphics.draw(images["court.png"],0,-40)
		elseif bg == 2 then
			love.graphics.draw(images["court2.png"],0,-40)
		elseif bg == 3 then
			love.graphics.draw(images["court3.png"],0,-40)
		end
		love.graphics.draw(images["player.png"],quad,xpos-37,ypos,0,2,2)
		if menu == false then
			deltaT = deltaT + love.timer.getDelta()
			love.graphics.draw(images["Layout.png"],0,0)
		elseif menu == true then
			love.graphics.draw(images["Layout2.png"],0,0)
		end
		love.graphics.print("FPS:"..love.timer.getFPS(), 750, 10)
		love.graphics.print("Points: "..pts, 10, 10)
		love.graphics.print("collect the falling objects", 250, 450)
		love.graphics.print("can and bottle: +1 point", 250, 475)
		love.graphics.print("book: +2 points",250, 500)
		love.graphics.print("battery: -1 point",250,525)
		love.graphics.print("light bulb: -2 points", 250, 550)
		love.graphics.print("use touch pad to move", 600, 475)
		love.graphics.print("clock: +1 sec",600, 500)
		love.graphics.print("Objective", 250, 420)
		love.graphics.print("Time Left: "..tonumber(string.format("%.0f", 60-deltaT)), 350, 10)
		love.graphics.draw(images["can.png"],xgarb,ygarb)
		love.graphics.draw(images["can.png"],xgarb2,ygarb2)
		love.graphics.draw(images["battery.png"],xgarb3,ygarb3)
		love.graphics.draw(images["bottle.png"],xgarb4,ygarb4)
		love.graphics.draw(images["book.png"],xgarb5,ygarb5)
		love.graphics.draw(images["light_bulb.png"],xgarb6,ygarb6)
		love.graphics.draw(images["bottle.png"],xgarb7,ygarb7)
		love.graphics.draw(images["clock.png"],xgarb8,ygarb8)
		love.graphics.draw(images["battery.png"],xgarb9,ygarb9)
		if menu == true then love.graphics.draw(images["menu.png"],0,0) end
	end
	if event == 5 then 
		love.graphics.draw(images["court4.png"],0,0)
	end
	if event == 6 then
		love.graphics.draw(images["court5.png"],0,0)
		love.graphics.print("Results...", 0, 0)
		love.graphics.print("Points: "..pts, 500, 200)
		love.graphics.print("Skill Level: "..tonumber(string.format("%.2f", pts/60)), 500, 250)
		love.graphics.print("Touch anywhere to exit!",0,550)
	end
end
function garbage()
	if xgarb >= xpos and xgarb <= xpos+37+24*2 and ygarb >= ypos then
		pts = pts + 1
		love.audio.rewind(music["score2.wav"])
		music["score2.wav"]:play()
		ygarb = 52
		xgarb = math.random(0,989)
	end
	if xgarb2 >= xpos and xgarb2 <= xpos+37+24*2 and ygarb2 >= ypos then
		pts = pts + 1
		love.audio.rewind(music["score2.wav"])
		music["score2.wav"]:play()
		ygarb2 = 52
		xgarb2 = math.random(0,989)
	end
	if xgarb3 >= xpos and xgarb3 <= xpos+37+24*2 and ygarb3 >= ypos then
		if pts > 0 then
			pts = pts - 1
		end	
		love.audio.rewind(music["score1.wav"])
		music["score1.wav"]:play()
		ygarb3 = 52
		xgarb3 = math.random(0,989)
	end
	if xgarb4 >= xpos and xgarb4 <= xpos+37+24*2 and ygarb4 >= ypos then
		pts = pts + 1
		love.audio.rewind(music["score2.wav"])
		music["score2.wav"]:play()
		ygarb4 = 52
		xgarb4 = math.random(0,989)
	end
	if xgarb5 >= xpos and xgarb5 <= xpos+37+24*2 and ygarb5 >= ypos then
		pts = pts + 2
		love.audio.rewind(music["score2.wav"])
		music["score2.wav"]:play()
		ygarb5 = 52
		xgarb5 = math.random(0,989)
	end
	if xgarb6 >= xpos and xgarb6 <= xpos+37+24*2 and ygarb6 >= ypos then
		if pts > 0 then
			pts = pts - 2
		end	
		love.audio.rewind(music["score1.wav"])
		music["score1.wav"]:play()
		ygarb6 = 52
		xgarb6 = math.random(0,989)
	end
	if xgarb7 >= xpos and xgarb7 <= xpos+37+24*2 and ygarb7 >= ypos then
		pts = pts + 1
		love.audio.rewind(music["score2.wav"])
		music["score2.wav"]:play()
		ygarb7 = 52
		xgarb7 = math.random(0,989)
	end
	if xgarb8 >= xpos and xgarb8 <= xpos+37+24*2 and ygarb8 >= ypos then
		deltaT = deltaT - 1
		love.audio.rewind(music["item.wav"])
		music["item.wav"]:play()
		ygarb8 = 52
		xgarb8 = math.random(0,989)
	end
	if xgarb9 >= xpos and xgarb9 <= xpos+37+24*2 and ygarb9 >= ypos then
		if pts > 0 then
			pts = pts - 1
		end
		love.audio.rewind(music["score1.wav"])
		music["score1.wav"]:play()
		ygarb9 = 52
		xgarb9 = math.random(0,989)
	end
	if ygarb < 322 then
		ygarb = ygarb + 4
	else
		ygarb = 52
		xgarb = math.random(0,989)
	end
	if ygarb2 < 322 then
		ygarb2 = ygarb2 + 4
	else
		ygarb2 = 52
		xgarb2 = math.random(0,989)
	end
	if ygarb3 < 322 then
		ygarb3 = ygarb3 + 5
	else
		ygarb3 = 52
		xgarb3 = math.random(0,989)
	end
	if ygarb4 < 322 then
		ygarb4 = ygarb4 + 3
	else
		ygarb4 = 52
		xgarb4 = math.random(0,989)
	end
	if ygarb5 < 322 then
		ygarb5 = ygarb5 + 3
	else
		ygarb5 = 52
		xgarb5 = math.random(0,989)
	end
	if ygarb6 < 322 then
		ygarb6 = ygarb6 + 3
	else
		ygarb6 = 52
		xgarb6 = math.random(0,989)
	end
	if ygarb7 < 322 then
		ygarb7 = ygarb7 + 4
	else
		ygarb7 = 52
		xgarb7 = math.random(0,989)
	end
	if ygarb8 < 322 then
		ygarb8 = ygarb8 + 2
	else
		ygarb8 = 52
		xgarb8 = math.random(0,989)
	end
	if ygarb9 < 322 then
		ygarb9 = ygarb9 + 4
	else
		ygarb9 = 52
		xgarb9 = math.random(0,989)
	end
end
function animation()
	time_update = time_update + love.timer.getDelta()
	if char_move == true then  
		if dir == 1 then
			if time_update > 0.05 then
				if n > 9 or n== 9 then 
					n = 1
				else
					n = n+1
				end
				time_update = 0
			end
		end
		if dir == 2 then
			if time_update > 0.05 then
				if n < 10 or n== 10 then
					n = 18
				else 
					n = n-1
				end
				time_update = 0
			end
		end
	else
		if dir == 1 then
			n = 1
		end
		if dir == 2 then
			n = 18
		end
		time_update = 0
	end
	if eventExit == true and time_update > 0.1 then
		counter = counter + 1
		if counter == 2 then 
			event = 3
			eventExit = false
		end
	end
end
function direction()
	if dir == 1 and char_move == false then n = 1 end
	if dir == 2 and char_move == false then n = 18 end
	if dir2 == 1 and char_move == false then n2 = 1 end
	if dir2 == 2 and char_move == false then n2 = 18 end
end
function controls()
	tp = tp+love.timer.getDelta()
	if control == 1 then
		if event == 2 then
			touches = love.touch.getTouches()
			for i, id in ipairs(touches) do
				eventExit = true
				event = 50
			end
			tp = 0
		end
		if event == 3 and tp > 1 then     
			touches = love.touch.getTouches()
			for i, id in ipairs(touches) do 
				x, y = love.touch.getPosition(id)
				if x >= (9*(width/1024)) and x <= (1011*(width/1024)) and y >= (76*(height/600)) and y <= (214*(height/600)) then
					event = 4
					bg = 1
				end
				if x >= (9*(width/1024)) and x <= (1011*(width/1024)) and y >= (225*(height/600)) and y <= (362*(height/600)) then
					event = 4
					bg = 2
				end
				if x >= (9*(width/1024)) and x <= (1011*(width/1024)) and y >= (372*(height/600)) and y <= (510*(height/600)) then
					event = 4
					bg = 3
				end
			end
		end
		if event == 4 then
			tp2 = tp2 + love.timer.getDelta()
			touches = love.touch.getTouches()
			for i, id in ipairs(touches) do
				x, y = love.touch.getPosition(id)
				if x > (150*(width/1024)) and x < (512*(width/1024)) then touchx = 100 end
				if x < (50*(width/1024)) then touchx = 0 end
				if x > (50*(width/1024)) and x < (150*(width/1024)) then touchx = 50 end
				if x > (869*(width/1024)) and x < (1024*(width/1024)) and y > 0 and y < (50*(height/600)) then
					if menu == true then menu = false end
					if menu == false then menu = true end
				end
				if menu == true then
					if x > (356*(width/1024)) and x < (680*(width/1024)) then
						if y < (225*(height/600)) and y > (127*(height/600)) then
							menu = false
						elseif y > (225*(height/600)) and y < (323*(height/600)) then
							menuQuit = true
						end
					end
				end
			end
			if menu == true then touchx = 50 end
			if touchx == 100 then
				if xpos <= 925 then
					xpos = xpos + 5
					dir = 1
					char_move = true
				end
			elseif touchx == 0 then
				if xpos+(37) >= 50 then
					xpos = xpos - 5
					dir = 2
					char_move = true
				end
			else
				char_move = false
			end
		end
	end
	if control == 2 then
		if event == 5 then 
			x, y = love.mouse.getPosition()
			if x > 0 and x < (69*(width/1024)) and y > 0 and y < (57*(height/600)) and love.mouse.isDown(1) then
				event =  2
			end
		end
		if event == 6 then
			tp3 = tp3 + love.timer.getDelta()
			if love.mouse.isDown(1)==true and tp3 > 0.5 then
				event = 2
				pts = 0
				tp3 = 0
			end
		end
		if event == 2 then
			x, y = love.mouse.getPosition()
			if love.mouse.isDown(1) == true then
				eventExit = true
				event = 50
			end
			tp = 0
		end
		if event == 3 and tp > 1 then                                         
			x, y = love.mouse.getPosition()
			if x >= (9*(width/1024)) and x <= (1011*(width/1024)) and y >= (76*(height/600)) and y <= (214*(height/600)) then
				if love.mouse.isDown(1) == true then
					event = 4
					bg = 1
				end
			end
			if x >= (9*(width/1024)) and x <= (1011*(width/1024)) and y >= (225*(height/600)) and y <= (362*(height/600)) then
				if love.mouse.isDown(1) == true then
					event = 4
					bg = 2
				end
			end
			if x >= (9*(width/1024)) and x <= (1011*(width/1024)) and y >= (372*(height/600)) and y <= (510*(height/600)) then
				if love.mouse.isDown(1) == true then
					event = 4
					bg = 3
				end
			end
		end
		if event == 4 then
			tp2 = tp2 + love.timer.getDelta()
			x, y = love.mouse.getPosition()
			if love.mouse.isDown(1) == false then
				touchx = 50
				char_move = false
			end
			if love.keyboard.isDown("d") then touchx = 100 end
			if love.keyboard.isDown( "a") then touchx = 0 end
			if love.keyboard.isDown( "space") and tp2 > 0.2 then
				if menu == false then
					menu = true
				elseif menu == true then
					menu = false
				end
				tp2 = 0
			end
			if love.mouse.isDown(1) == true then
				if x > (150*(width/1024)) and x < (512*(width/1024))  then touchx = 100 end
				if x < (50*(width/1024)) then touchx = 0 end
				if x > (50*(width/1024)) and x < (150*(width/1024)) then touchx = 50 end
				if (974*(width/1024)) > x and (874*(width/1024)) < x and (550*(height/600)) > y and y > (450*(height/600))  then
					if down == false and up == false then 
						curpos = ypos-75
					end
				end
				if x > (869*(width/1024)) and x < (1024*(width/1024)) and y > 0 and y < (50*(height/600)) then
					if menu == true then menu = false end
					if menu == false then menu = true end
				end
				if menu == true then
					if x > (356*(width/1024)) and x < (680*(width/1024)) then
						if y < (225*(height/600)) and y > (127*(height/600)) then
							menu = false
						elseif y > (225*(height/600)) and y < (323*(height/600)) then
							menuQuit = true
						end
					end
				end
			end
			if menu == true then touchx = 50 end
			if touchx == 100 then
				if xpos <= 925 then
					xpos = xpos + 5
					dir = 1
					char_move = true
				end
			elseif touchx == 0 then
				if xpos+(37) >= 50 then
					xpos = xpos - 5
					dir = 2
					char_move = true
				end
			else
				char_move = false
			end
		end
		if love.mouse.isDown(2) == true then love.event.quit() end
		if love.keyboard.isDown("p") and tp2 > 0.2 then
			if love.window.getFullscreen() == false then
				love.window.setFullscreen(true)
			else
				love.window.setFullscreen(false)
			end
			tp2 = 0
			width,height = love.graphics.getDimensions()
		end
	end
end
function love.update(dt)
	next_time = next_time + min_dt
	tp = tp+love.timer.getDelta()

	if event == 1 then
		intro:play()
		if intro:isPlaying( ) then 
			event = 1 
		else
			event = 2
		end
	end
	if event == 1 or event == 2 or event == 3 then
		if music["8-bit Detective.wav"]:isPlaying() then
			
		else
			music["8-bit Detective.wav"]:play()
		end
		
	end
	if eventExit == true then 
		event = 3
		eventExit = false
	end
	if event == 4 then
		if pts < 0 then pts = 0 end
		love.audio.pause(music["8-bit Detective.wav"])
		if bg == 1 then
			if music["Turn for Me.mp3"]:isPlaying() then
			else
				music["Turn for Me.mp3"]:play()
			end
		elseif bg == 2 then
			if music["Mystic Africa Loop.wav"]:isPlaying() then
			else
				music["Mystic Africa Loop.wav"]:play()
			end
		elseif bg == 3 then
			if music["Space Loop.wav"]:isPlaying() then
			else
				music["Space Loop.wav"]:play()
			end
		end
		quad = quads[n]
		quad2 = quads[n2]
		tp = 0
		if menu == false then
			garbage()
		end
	end
	controls()
	animation()
	direction()
	if deltaT >= 60 or menuQuit == true then
		menu = false
		menuQuit = false
		event = 6
		music["Mystic Africa Loop.wav"]:pause()
		music["Space Loop.wav"]:pause()
		music["Turn for Me.mp3"]:pause()
		ygarb = 52
		ygarb2 = 52
		ygarb3 = 52
		ygarb4 = 52
		ygarb5 = 52
		ygarb6 = 52
		xpos = 250+37
		xgarb = math.random(0,989)
		xgarb2 = math.random(0,989)
		xgarb3 = math.random(0,989)
		xgarb4 = math.random(0,989)
		xgarb5 = math.random(0,989)
		xgarb6 = math.random(0,989)
		deltaT = 0
	end
end
function love.touchpressed(id, x, y, pressure)
	if event == 6 then
		tr = true
	end
end
function love.touchreleased(id, x, y, pressure)
	touchx = 50
	char_move = false
	if tr == true then
		event = 2
		tr = false
		pts = 0
	end
end