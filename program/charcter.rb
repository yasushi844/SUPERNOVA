#encoding: Shift_JIS
#地球
class Earth<Sprite
	attr_accessor :point
	def initialize
		self.image=Image.load("image/earth.png")
	end
	def mode(map,planeton,planetoff,point)
		@map=map
		@planeton=planeton
		@planetoff=planetoff
		@e_f=0
		@e_d=0
		@e_u=0
		@e_r=0
		@e_l=0
		@point=point
		if @planeton==1&&@planetoff==0
			@e_f=1
		end
		#地球が下に動くプログラム
		if Input.key_down?(K_DOWN)
			@point-=1
			if (@map[(self.y-46)/40][(self.x+8)/40]>=0&&@map[(self.y-46)/40][(self.x+8)/40]<=2)||(@map[(self.y-46)/40][(self.x+8)/40]>=11&&@map[(self.y-46)/40][(self.x+8)/40]<=17)||(@e_f==1&&@map[(self.y-46)/40][(self.x+8)/40]==6)
				@e_d=1
			end
			if @e_d==1
				if (@map[(self.y-46)/40][(self.x-20)/40]>=0&&@map[(self.y-46)/40][(self.x-20)/40]<=2)||(@map[(self.y-46)/40][(self.x-20)/40]>=11&&@map[(self.y-46)/40][(self.x-20)/40]<=17)||(@e_f==1&&@map[(self.y-46)/40][(self.x-20)/40]==6)
					@e_d=2
				end
			end
			if @e_d==2
				self.y+=2
			end
		end
		#地球が上に動くプログラム
		if Input.key_down?(K_UP)
			@point-=1
			if (@map[(self.y-76)/40][(self.x+8)/40]>=0&&@map[(self.y-76)/40][(self.x+8)/40]<=2)||(@map[(self.y-76)/40][(self.x+8)/40]>=11&&@map[(self.y-76)/40][(self.x+8)/40]<=17)||(@e_f==1&&@map[(self.y-76)/40][(self.x+8)/40]==6)
				@e_u=1
			end
			if @e_u==1
				if (@map[(self.y-76)/40][(self.x-20)/40]>=0&&@map[(self.y-76)/40][(self.x-20)/40]<=2)||(@map[(self.y-76)/40][(self.x-20)/40]>=11&&@map[(self.y-76)/40][(self.x-20)/40]<=17)||(@e_f==1&&@map[(self.y-76)/40][(self.x-20)/40]==6)
					@e_u=2
				end
			end
			if @e_u==2
				self.y-=2
			end
		end
		#地球が右に動くプログラム
		if Input.key_down?(K_RIGHT)
			@point-=1
			if (@map[(self.y-74)/40][(self.x+10)/40]>=0&&@map[(self.y-74)/40][(self.x+10)/40]<=2)||(@map[(self.y-74)/40][(self.x+10)/40]>=11&&@map[(self.y-74)/40][(self.x+10)/40]<=17)||(@e_f==1&&@map[(self.y-74)/40][(self.x+10)/40]==6)
				@e_r=1
			end
			if @e_r==1
				if (@map[(self.y-48)/40][(self.x+10)/40]>=0&&@map[(self.y-48)/40][(self.x+10)/40]<=2)||(@map[(self.y-48)/40][(self.x+10)/40]>=11&&@map[(self.y-48)/40][(self.x+10)/40]<=17)||(@e_f==1&&@map[(self.y-48)/40][(self.x+10)/40]==6)
					@e_r=2
				end
			end
			if @e_r==2
				self.x+=2
			end
		end
		#地球が左に動くプログラム
		if Input.key_down?(K_LEFT)
			@point-=1
			if (@map[(self.y-74)/40][(self.x-22)/40]>=0&&@map[(self.y-74)/40][(self.x-22)/40]<=2)||(@map[(self.y-74)/40][(self.x-22)/40]>=11&&@map[(self.y-74)/40][(self.x-22)/40]<=17)||(@e_f==1&&@map[(self.y-74)/40][(self.x-22)/40]==6)
				@e_l=1
			end
			if @e_l==1
				if (@map[(self.y-48)/40][(self.x-22)/40]>=0&&@map[(self.y-48)/40][(self.x-22)/40]<=2)||(@map[(self.y-48)/40][(self.x-22)/40]>=11&&@map[(self.y-48)/40][(self.x-22)/40]<=17)||(@e_f==1&&@map[(self.y-48)/40][(self.x-22)/40]==6)
					@e_l=2
				end
			end
			if @e_l==2
				self.x-=2
			end
		end
	end
end
#月
class Moon <Sprite
	def initialize
		self.image=Image.load("image/moon.png")
	end
	def mode(earth,map,planeton,planetoff,moonon)
		@map=map
		@planeton=planeton
		@planetoff=planetoff
		@moonon=moonon
		@m_f=0
		@m_d=0
		@m_u=0
		@m_r=0
		@m_l=0
		if @planeton==1&&@planetoff==0
			@m_f=1
		end
		#月が下に動くプログラム
		if earth.y>self.y&&@moonon==0
			@m_d=1
		elsif earth.y<self.y&&@moonon==1
			@m_d=1
		end
		if @m_d==1
			if @map[(self.y-46)/40][(self.x+8)/40]!=7||@map[(self.y-8)/40][(self.x+8)/40]!=7
				if @map[(self.y-46)/40][(self.x+8)/40]==0||@map[(self.y-46)/40][(self.x+8)/40]==1||@map[(self.y-46)/40][(self.x+8)/40]==3||(@map[(self.y-46)/40][(self.x+8)/40]>=7&&@map[(self.y-46)/40][(self.x+8)/40]<=17)||(@m_f==1&&@map[(self.y-46)/40][(self.x+8)/40]==6)
					@m_d=2
				end
			end
		end
		if @m_d==2
			if @map[(self.y-46)/40][(self.x-20)/40]!=7||@map[(self.y-8)/40][(self.x-20)/40]!=7
				if @map[(self.y-46)/40][(self.x-20)/40]==0||@map[(self.y-46)/40][(self.x-20)/40]==1||@map[(self.y-46)/40][(self.x-20)/40]==3||@map[(self.y-46)/40][(self.x-20)/40]>=7&&@map[(self.y-46)/40][(self.x-20)/40]<=17||(@m_f==1&&@map[(self.y-46)/40][(self.x-20)/40]==6)
					@m_d=3
				end
			end
		end
		if @m_d==3
			self.y+=2
		end
		#月が上に動くプログラム
		if earth.y<self.y&&@moonon==0
			@m_u=1
		elsif earth.y>self.y&&@moonon==1
			@m_u=1
		end
		if @m_u==1
			if @map[(self.y-114)/40][(self.x+8)/40]!=8||map[(self.y-76)/40][(self.x+8)/40]!=8
				if @map[(self.y-76)/40][(self.x+8)/40]==0||@map[(self.y-76)/40][(self.x+8)/40]==1||@map[(self.y-76)/40][(self.x+8)/40]==3||(@map[(self.y-76)/40][(self.x+8)/40]>=7&&@map[(self.y-76)/40][(self.x+8)/40]<=17)||(@m_f==1&&@map[(self.y-76)/40][(self.x+8)/40]==6)
					@m_u=2
				end
			end
		end
		if @m_u==2
			if @map[(self.y-114)/40][(self.x-20)/40]!=8||map[(self.y-76)/40][(self.x-20)/40]!=8
				if @map[(self.y-76)/40][(self.x-20)/40]==0||@map[(self.y-76)/40][(self.x-20)/40]==1||@map[(self.y-76)/40][(self.x-20)/40]==3||(@map[(self.y-76)/40][(self.x-20)/40]>=7&&@map[(self.y-76)/40][(self.x-20)/40]<=17)||(@m_f==1&&@map[(self.y-76)/40][(self.x-20)/40]==6)
					@m_u=3
				end
			end
		end
		if @m_u==3
			self.y-=2
		end
		#月が右に動くプログラム
		if earth.x>self.x&&@moonon==0
			@m_l=1
		elsif earth.x<self.x&&@moonon==1
			@m_l=1
		end
		if @m_l==1
			if @map[(self.y-74)/40][(self.x+10)/40]!=10||@map[(self.y-74)/40][(self.x+48)/40]!=10
				if @map[(self.y-74)/40][(self.x+10)/40]==0||@map[(self.y-74)/40][(self.x+10)/40]==1||@map[(self.y-74)/40][(self.x+10)/40]==3||(@map[(self.y-74)/40][(self.x+10)/40]>=7&&@map[(self.y-74)/40][(self.x+10)/40]<=17)||(@m_f==1&&@map[(self.y-74)/40][(self.x+10)/40]==6)
					@m_l=2
				end
			end
		end
		if @m_l==2
			if @map[(self.y-48)/40][(self.x+10)/40]!=10||@map[(self.y-48)/40][(self.x+48)/40]!=10
				if @map[(self.y-48)/40][(self.x+10)/40]==0||@map[(self.y-48)/40][(self.x+10)/40]==1||@map[(self.y-48)/40][(self.x+10)/40]==3||(@map[(self.y-48)/40][(self.x+10)/40]>=7&&@map[(self.y-48)/40][(self.x+10)/40]<=17)||(@m_f==1&&@map[(self.y-48)/40][(self.x+10)/40]==6)
					@m_l=3
				end
			end
		end
		if @m_l==3
			self.x+=2
		end
		#月が左に動くプログラム
		if earth.x<self.x&&@moonon==0
			@m_r=1
		elsif earth.x>self.x&&@moonon==1
			@m_r=1
		end
		if @m_r==1
			if @map[(self.y-74)/40][(self.x-22)/40]!=9||@map[(self.y-74)/40][(self.x-60)/40]!=9
				if @map[(self.y-74)/40][(self.x-22)/40]==0||@map[(self.y-74)/40][(self.x-22)/40]==1||@map[(self.y-74)/40][(self.x-22)/40]==3||(@map[(self.y-74)/40][(self.x-22)/40]>=7&&@map[(self.y-74)/40][(self.x-22)/40]<=17)||(@m_f==1&&@map[(self.y-74)/40][(self.x-22)/40]==6)
					@m_r=2
				end
			end
		end
		if @m_r==2
			if @map[(self.y-48)/40][(self.x-22)/40]!=9||@map[(self.y-48)/40][(self.x-60)/40]!=9
				if @map[(self.y-48)/40][(self.x-22)/40]==0||@map[(self.y-48)/40][(self.x-22)/40]==1||@map[(self.y-48)/40][(self.x-22)/40]==3||(@map[(self.y-48)/40][(self.x-22)/40]>=7&&@map[(self.y-48)/40][(self.x-22)/40]<=17)||(@m_f==1&&@map[(self.y-48)/40][(self.x-22)/40]==6)
					@m_r=3
				end
			end
		end
		if @m_r==3
			self.x-=2
		end
	end
end
#太陽
class Solar <Sprite
	def initialize
		self.image=Image.load("image/solar.png")
	end
	def mode(map,planeton,planetoff,gamemode,start)
		@map=map
		@planeton=planeton
		@planetoff=planetoff
		@gamemode=gamemode	
		@start=start
		@s_f=0
		@s_d=0
		@s_u=0
		@s_r=0
		@s_l=0
		if @planeton==1&&@planetoff==0
			@s_f=1
		end
		if (Input.key_down?(K_DOWN)&&(@gamemode!=4||start!=1))||(Input.key_down?(K_S)&&@gamemode==4&&start==1)
			if @map[(self.y-46)/40][(self.x+8)/40]!=7||@map[(self.y-8)/40][(self.x+8)/40]!=7
				if @map[(self.y-46)/40][(self.x+8)/40]==0||@map[(self.y-46)/40][(self.x+8)/40]==1||@map[(self.y-46)/40][(self.x+8)/40]==4||(@map[(self.y-46)/40][(self.x+8)/40]>=7&&@map[(self.y-46)/40][(self.x+8)/40]<=17)||(@s_f==1&&@map[(self.y-46)/40][(self.x+8)/40]==6)
					@s_d=1
				end
			end
			if @s_d==1
				if @map[(self.y-46)/40][(self.x-20)/40]!=7||@map[(self.y-8)/40][(self.x-20)/40]!=7
					if @map[(self.y-46)/40][(self.x-20)/40]==0||@map[(self.y-46)/40][(self.x-20)/40]==1||@map[(self.y-46)/40][(self.x-20)/40]==4||(@map[(self.y-46)/40][(self.x-20)/40]>=7&&@map[(self.y-46)/40][(self.x-20)/40]<=17)||(@s_f==1&&@map[(self.y-46)/40][(self.x-20)/40]==6)
						@s_d=2
					end
				end
			end
			if @s_d==2
				self.y+=2
			end

		end
		if (Input.key_down?(K_UP)&&(@gamemode!=4||start!=1))||(Input.key_down?(K_W)&&@gamemode==4&&start==1)
			if @map[(self.y-114)/40][(self.x+8)/40]!=8||map[(self.y-76)/40][(self.x+8)/40]!=8
				if @map[(self.y-76)/40][(self.x+8)/40]==0||@map[(self.y-76)/40][(self.x+8)/40]==1||@map[(self.y-76)/40][(self.x+8)/40]==4||(@map[(self.y-76)/40][(self.x+8)/40]>=7&&@map[(self.y-76)/40][(self.x+8)/40]<=17)||(@s_f==1&&@map[(self.y-76)/40][(self.x+8)/40]==6)
					@s_u=1
				end
			end
			if @s_u==1
				if @map[(self.y-114)/40][(self.x-20)/40]!=8||@map[(self.y-76)/40][(self.x-20)/40]!=8
					if @map[(self.y-76)/40][(self.x-20)/40]==0||@map[(self.y-76)/40][(self.x-20)/40]==1||@map[(self.y-76)/40][(self.x-20)/40]==4||(@map[(self.y-76)/40][(self.x-20)/40]>=7&&@map[(self.y-76)/40][(self.x-20)/40]<=17)||(@s_f==1&&@map[(self.y-76)/40][(self.x-20)/40]==6)
						@s_u=2
					end
				end
			end
			if @s_u==2
				self.y-=2
			end
		end
		if (Input.key_down?(K_RIGHT)&(@gamemode!=4||start!=1))||(Input.key_down?(K_D)&&@gamemode==4&&start==1)
			if @map[(self.y-74)/40][(self.x+10)/40]!=10||@map[(self.y-74)/40][(self.x+48)/40]!=10
				if @map[(self.y-74)/40][(self.x+10)/40]==0||@map[(self.y-74)/40][(self.x+10)/40]==1||@map[(self.y-74)/40][(self.x+10)/40]==4||(@map[(self.y-74)/40][(self.x+10)/40]>=7&&@map[(self.y-74)/40][(self.x+10)/40]<=17)||(@s_f==1&&@map[(self.y-74)/40][(self.x+10)/40]==6)
					@s_r=1
				end
			end
			if @s_r==1
				if @map[(self.y-48)/40][(self.x+10)/40]!=10||@map[(self.y-48)/40][(self.x+48)/40]!=10
					if @map[(self.y-48)/40][(self.x+10)/40]==0||@map[(self.y-48)/40][(self.x+10)/40]==1||@map[(self.y-48)/40][(self.x+10)/40]==4||(@map[(self.y-48)/40][(self.x+10)/40]>=7&&@map[(self.y-48)/40][(self.x+10)/40]<=17)||(@s_f==1&&@map[(self.y-48)/40][(self.x+10)/40]==6)
						@s_r=2
					end
				end
			end
			if @s_r==2
				self.x+=2
			end
		end
		if (Input.key_down?(K_LEFT)&&(@gamemode!=4||start!=1))||(Input.key_down?(K_A)&&@gamemode==4&&start==1)
			if @map[(self.y-74)/40][(self.x-22)/40]!=9||@map[(self.y-74)/40][(self.x-60)/40]!=9
				if @map[(self.y-74)/40][(self.x-22)/40]==0||@map[(self.y-74)/40][(self.x-22)/40]==1||@map[(self.y-74)/40][(self.x-22)/40]==4||(@map[(self.y-74)/40][(self.x-22)/40]>=7&&@map[(self.y-74)/40][(self.x-22)/40]<=17)||(@s_f==1&&@map[(self.y-74)/40][(self.x-22)/40]==6)
					@s_l=1
				end
			end
			if @s_l==1
				if @map[(self.y-48)/40][(self.x-22)/40]!=9||@map[(self.y-48)/40][(self.x-60)/40]!=9
					if @map[(self.y-48)/40][(self.x-22)/40]==0||@map[(self.y-48)/40][(self.x-22)/40]==1||@map[(self.y-48)/40][(self.x-22)/40]==4||(@map[(self.y-48)/40][(self.x-22)/40]>=7&&@map[(self.y-48)/40][(self.x-22)/40]<=17)||(@s_f==1&&@map[(self.y-48)/40][(self.x-22)/40]==6)
						@s_l=2
					end
				end
			end
			if @s_l==2
				self.x-=2
			end
		end
	end
end
