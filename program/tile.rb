#encoding: Shift_JIS
#�X�C�b�`�^�C��
class Tile <Sprite
	attr_accessor :planeton,:planetoff,:moonon,:moonoff
	def game(map,earth,moon,solar)
		@map=map
		#�n���ƃX�C�b�`�^�C�����������...
		if @map[(earth.y-48)/40][(earth.x-20)/40]==11||@map[(earth.y-48)/40][(earth.x+8)/40]==11|| @map[(earth.y-74)/40][(earth.x-20)/40]==11||@map[(earth.y-74)/40][(earth.x+8)/40]==11||@map[(earth.y-48)/40][(earth.x+8)/40]==11||@map[(earth.y-74)/40][(earth.x+8)/40]==11|| @map[(earth.y-48)/40][(earth.x-20)/40]==11||@map[(earth.y-74)/40][(earth.x-20)/40]==11
			@planeton=1
			@planetoff=0

		#���ƃX�C�b�`�^�C�����������...
		elsif @map[(moon.y-48)/40][(moon.x-20)/40]==11||@map[(moon.y-48)/40][(moon.x+8)/40]==11|| @map[(moon.y-74)/40][(moon.x-20)/40]==11||@map[(moon.y-74)/40][(moon.x+8)/40]==11||@map[(moon.y-48)/40][(moon.x+8)/40]==11||@map[(moon.y-74)/40][(moon.x+8)/40]==11|| @map[(moon.y-48)/40][(moon.x-20)/40]==11||@map[(moon.y-74)/40][(moon.x-20)/40]==11
			@planeton=1
			@planetoff=0
		#覐΂ƃX�C�b�`�^�C�����������...
		elsif @map[(solar.y-48)/40][(solar.x-20)/40]==11||@map[(solar.y-48)/40][(solar.x+8)/40]==11|| @map[(solar.y-74)/40][(solar.x-20)/40]==11||@map[(solar.y-74)/40][(solar.x+8)/40]==11||@map[(solar.y-48)/40][(solar.x+8)/40]==11||@map[(solar.y-74)/40][(solar.x+8)/40]==11|| @map[(solar.y-48)/40][(solar.x-20)/40]==11||@map[(solar.y-74)/40][(solar.x-20)/40]==11
			@planeton=1
			@planetoff=0
		end
		#�n���ƃX�C�b�`�^�C�����������...
		if @map[(earth.y-48)/40][(earth.x-20)/40]==12||@map[(earth.y-48)/40][(earth.x+8)/40]==12|| @map[(earth.y-74)/40][(earth.x-20)/40]==12||@map[(earth.y-74)/40][(earth.x+8)/40]==12||@map[(earth.y-48)/40][(earth.x+8)/40]==12||@map[(earth.y-74)/40][(earth.x+8)/40]==12|| @map[(earth.y-48)/40][(earth.x-20)/40]==12||@map[(earth.y-74)/40][(earth.x-20)/40]==12
			@planetoff=1
		#���ƃX�C�b�`�^�C�����������...
		elsif @map[(moon.y-48)/40][(moon.x-20)/40]==12||@map[(moon.y-48)/40][(moon.x+8)/40]==12|| @map[(moon.y-74)/40][(moon.x-20)/40]==12||@map[(moon.y-74)/40][(moon.x+8)/40]==12||@map[(moon.y-48)/40][(moon.x+8)/40]==12||@map[(moon.y-74)/40][(moon.x+8)/40]==12|| @map[(moon.y-48)/40][(moon.x-20)/40]==12||@map[(moon.y-74)/40][(moon.x-20)/40]==12
			@planetoff=1
		#覐΂ƃX�C�b�`�^�C�����������...
		elsif @map[(solar.y-48)/40][(solar.x-20)/40]==12||@map[(solar.y-48)/40][(solar.x+8)/40]==12|| @map[(solar.y-74)/40][(solar.x-20)/40]==12||@map[(solar.y-74)/40][(solar.x+8)/40]==12||@map[(solar.y-48)/40][(solar.x+8)/40]==12||@map[(solar.y-74)/40][(solar.x+8)/40]==12|| @map[(solar.y-48)/40][(solar.x-20)/40]==12||@map[(solar.y-74)/40][(solar.x-20)/40]==12
			@planetoff=1
		end

		#�n���ƃX�C�b�`�^�C�����������...
		if @map[(earth.y-48)/40][(earth.x-20)/40]==13||@map[(earth.y-48)/40][(earth.x+8)/40]==13|| @map[(earth.y-74)/40][(earth.x-20)/40]==13||@map[(earth.y-74)/40][(earth.x+8)/40]==13||@map[(earth.y-48)/40][(earth.x+8)/40]==13||@map[(earth.y-74)/40][(earth.x+8)/40]==13|| @map[(earth.y-48)/40][(earth.x-20)/40]==13||@map[(earth.y-74)/40][(earth.x-20)/40]==13
			@moonon=1
		#���ƃX�C�b�`�^�C�����������...
		elsif @map[(moon.y-48)/40][(moon.x-20)/40]==13||@map[(moon.y-48)/40][(moon.x+8)/40]==13|| @map[(moon.y-74)/40][(moon.x-20)/40]==13||@map[(moon.y-74)/40][(moon.x+8)/40]==13||@map[(moon.y-48)/40][(moon.x+8)/40]==13||@map[(moon.y-74)/40][(moon.x+8)/40]==13|| @map[(moon.y-48)/40][(moon.x-20)/40]==13||@map[(moon.y-74)/40][(moon.x-20)/40]==13
			@moonon=1
		#覐΂ƃX�C�b�`�^�C�����������...
		elsif @map[(solar.y-48)/40][(solar.x-20)/40]==13||@map[(solar.y-48)/40][(solar.x+8)/40]==13|| @map[(solar.y-74)/40][(solar.x-20)/40]==13||@map[(solar.y-74)/40][(solar.x+8)/40]==13||@map[(solar.y-48)/40][(solar.x+8)/40]==13||@map[(solar.y-74)/40][(solar.x+8)/40]==13|| @map[(solar.y-48)/40][(solar.x-20)/40]==13||@map[(solar.y-74)/40][(solar.x-20)/40]==13
			@moonon=1
		end

		#�n���ƃX�C�b�`�^�C�����������...
		if @map[(earth.y-48)/40][(earth.x-20)/40]==14||@map[(earth.y-48)/40][(earth.x+8)/40]==14|| @map[(earth.y-74)/40][(earth.x-20)/40]==14||@map[(earth.y-74)/40][(earth.x+8)/40]==14||@map[(earth.y-48)/40][(earth.x+8)/40]==14||@map[(earth.y-74)/40][(earth.x+8)/40]==14|| @map[(earth.y-48)/40][(earth.x-20)/40]==14||@map[(earth.y-74)/40][(earth.x-20)/40]==14
			@moonon=0
			@moonoff=1
		#���ƃX�C�b�`�^�C�����������...
		elsif @map[(moon.y-48)/40][(moon.x-20)/40]==14||@map[(moon.y-48)/40][(moon.x+8)/40]==14|| @map[(moon.y-74)/40][(moon.x-20)/40]==14||@map[(moon.y-74)/40][(moon.x+8)/40]==14||@map[(moon.y-48)/40][(moon.x+8)/40]==14||@map[(moon.y-74)/40][(moon.x+8)/40]==14|| @map[(moon.y-48)/40][(moon.x-20)/40]==14||@map[(moon.y-74)/40][(moon.x-20)/40]==14
			@moonon=0
			@moonoff=1
		#覐΂ƃX�C�b�`�^�C�����������...
		elsif @map[(solar.y-48)/40][(solar.x-20)/40]==14||@map[(solar.y-48)/40][(solar.x+8)/40]==14|| @map[(solar.y-74)/40][(solar.x-20)/40]==14||@map[(solar.y-74)/40][(solar.x+8)/40]==14||@map[(solar.y-48)/40][(solar.x+8)/40]==14||@map[(solar.y-74)/40][(solar.x+8)/40]==14|| @map[(solar.y-48)/40][(solar.x-20)/40]==14||@map[(solar.y-74)/40][(solar.x-20)/40]==14
			@moonon=0
			@moonoff=1
		end
	end
end
