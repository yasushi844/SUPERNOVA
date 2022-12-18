#encoding: Shift_JIS
#スイッチタイル
class Tile <Sprite
	attr_accessor :planeton,:planetoff,:moonon,:moonoff
	def game(map,earth,moon,solar)
		@map=map
		#地球とスイッチタイルが当たると...
		if @map[(earth.y-48)/40][(earth.x-20)/40]==11||@map[(earth.y-48)/40][(earth.x+8)/40]==11|| @map[(earth.y-74)/40][(earth.x-20)/40]==11||@map[(earth.y-74)/40][(earth.x+8)/40]==11||@map[(earth.y-48)/40][(earth.x+8)/40]==11||@map[(earth.y-74)/40][(earth.x+8)/40]==11|| @map[(earth.y-48)/40][(earth.x-20)/40]==11||@map[(earth.y-74)/40][(earth.x-20)/40]==11
			@planeton=1
			@planetoff=0

		#月とスイッチタイルが当たると...
		elsif @map[(moon.y-48)/40][(moon.x-20)/40]==11||@map[(moon.y-48)/40][(moon.x+8)/40]==11|| @map[(moon.y-74)/40][(moon.x-20)/40]==11||@map[(moon.y-74)/40][(moon.x+8)/40]==11||@map[(moon.y-48)/40][(moon.x+8)/40]==11||@map[(moon.y-74)/40][(moon.x+8)/40]==11|| @map[(moon.y-48)/40][(moon.x-20)/40]==11||@map[(moon.y-74)/40][(moon.x-20)/40]==11
			@planeton=1
			@planetoff=0
		#隕石とスイッチタイルが当たると...
		elsif @map[(solar.y-48)/40][(solar.x-20)/40]==11||@map[(solar.y-48)/40][(solar.x+8)/40]==11|| @map[(solar.y-74)/40][(solar.x-20)/40]==11||@map[(solar.y-74)/40][(solar.x+8)/40]==11||@map[(solar.y-48)/40][(solar.x+8)/40]==11||@map[(solar.y-74)/40][(solar.x+8)/40]==11|| @map[(solar.y-48)/40][(solar.x-20)/40]==11||@map[(solar.y-74)/40][(solar.x-20)/40]==11
			@planeton=1
			@planetoff=0
		end
		#地球とスイッチタイルが当たると...
		if @map[(earth.y-48)/40][(earth.x-20)/40]==12||@map[(earth.y-48)/40][(earth.x+8)/40]==12|| @map[(earth.y-74)/40][(earth.x-20)/40]==12||@map[(earth.y-74)/40][(earth.x+8)/40]==12||@map[(earth.y-48)/40][(earth.x+8)/40]==12||@map[(earth.y-74)/40][(earth.x+8)/40]==12|| @map[(earth.y-48)/40][(earth.x-20)/40]==12||@map[(earth.y-74)/40][(earth.x-20)/40]==12
			@planetoff=1
		#月とスイッチタイルが当たると...
		elsif @map[(moon.y-48)/40][(moon.x-20)/40]==12||@map[(moon.y-48)/40][(moon.x+8)/40]==12|| @map[(moon.y-74)/40][(moon.x-20)/40]==12||@map[(moon.y-74)/40][(moon.x+8)/40]==12||@map[(moon.y-48)/40][(moon.x+8)/40]==12||@map[(moon.y-74)/40][(moon.x+8)/40]==12|| @map[(moon.y-48)/40][(moon.x-20)/40]==12||@map[(moon.y-74)/40][(moon.x-20)/40]==12
			@planetoff=1
		#隕石とスイッチタイルが当たると...
		elsif @map[(solar.y-48)/40][(solar.x-20)/40]==12||@map[(solar.y-48)/40][(solar.x+8)/40]==12|| @map[(solar.y-74)/40][(solar.x-20)/40]==12||@map[(solar.y-74)/40][(solar.x+8)/40]==12||@map[(solar.y-48)/40][(solar.x+8)/40]==12||@map[(solar.y-74)/40][(solar.x+8)/40]==12|| @map[(solar.y-48)/40][(solar.x-20)/40]==12||@map[(solar.y-74)/40][(solar.x-20)/40]==12
			@planetoff=1
		end

		#地球とスイッチタイルが当たると...
		if @map[(earth.y-48)/40][(earth.x-20)/40]==13||@map[(earth.y-48)/40][(earth.x+8)/40]==13|| @map[(earth.y-74)/40][(earth.x-20)/40]==13||@map[(earth.y-74)/40][(earth.x+8)/40]==13||@map[(earth.y-48)/40][(earth.x+8)/40]==13||@map[(earth.y-74)/40][(earth.x+8)/40]==13|| @map[(earth.y-48)/40][(earth.x-20)/40]==13||@map[(earth.y-74)/40][(earth.x-20)/40]==13
			@moonon=1
		#月とスイッチタイルが当たると...
		elsif @map[(moon.y-48)/40][(moon.x-20)/40]==13||@map[(moon.y-48)/40][(moon.x+8)/40]==13|| @map[(moon.y-74)/40][(moon.x-20)/40]==13||@map[(moon.y-74)/40][(moon.x+8)/40]==13||@map[(moon.y-48)/40][(moon.x+8)/40]==13||@map[(moon.y-74)/40][(moon.x+8)/40]==13|| @map[(moon.y-48)/40][(moon.x-20)/40]==13||@map[(moon.y-74)/40][(moon.x-20)/40]==13
			@moonon=1
		#隕石とスイッチタイルが当たると...
		elsif @map[(solar.y-48)/40][(solar.x-20)/40]==13||@map[(solar.y-48)/40][(solar.x+8)/40]==13|| @map[(solar.y-74)/40][(solar.x-20)/40]==13||@map[(solar.y-74)/40][(solar.x+8)/40]==13||@map[(solar.y-48)/40][(solar.x+8)/40]==13||@map[(solar.y-74)/40][(solar.x+8)/40]==13|| @map[(solar.y-48)/40][(solar.x-20)/40]==13||@map[(solar.y-74)/40][(solar.x-20)/40]==13
			@moonon=1
		end

		#地球とスイッチタイルが当たると...
		if @map[(earth.y-48)/40][(earth.x-20)/40]==14||@map[(earth.y-48)/40][(earth.x+8)/40]==14|| @map[(earth.y-74)/40][(earth.x-20)/40]==14||@map[(earth.y-74)/40][(earth.x+8)/40]==14||@map[(earth.y-48)/40][(earth.x+8)/40]==14||@map[(earth.y-74)/40][(earth.x+8)/40]==14|| @map[(earth.y-48)/40][(earth.x-20)/40]==14||@map[(earth.y-74)/40][(earth.x-20)/40]==14
			@moonon=0
			@moonoff=1
		#月とスイッチタイルが当たると...
		elsif @map[(moon.y-48)/40][(moon.x-20)/40]==14||@map[(moon.y-48)/40][(moon.x+8)/40]==14|| @map[(moon.y-74)/40][(moon.x-20)/40]==14||@map[(moon.y-74)/40][(moon.x+8)/40]==14||@map[(moon.y-48)/40][(moon.x+8)/40]==14||@map[(moon.y-74)/40][(moon.x+8)/40]==14|| @map[(moon.y-48)/40][(moon.x-20)/40]==14||@map[(moon.y-74)/40][(moon.x-20)/40]==14
			@moonon=0
			@moonoff=1
		#隕石とスイッチタイルが当たると...
		elsif @map[(solar.y-48)/40][(solar.x-20)/40]==14||@map[(solar.y-48)/40][(solar.x+8)/40]==14|| @map[(solar.y-74)/40][(solar.x-20)/40]==14||@map[(solar.y-74)/40][(solar.x+8)/40]==14||@map[(solar.y-48)/40][(solar.x+8)/40]==14||@map[(solar.y-74)/40][(solar.x+8)/40]==14|| @map[(solar.y-48)/40][(solar.x-20)/40]==14||@map[(solar.y-74)/40][(solar.x-20)/40]==14
			@moonon=0
			@moonoff=1
		end
	end
end
