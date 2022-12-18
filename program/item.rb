#encoding: Shift_JIS
class Moonpiece <Sprite
	def initialize
		self.image=Image.load("image/moonpiece.png")
	end
	def syutugen(map,earth,solar,item)
		@map=map
		@flag=0
		while @flag==0
			self.x=Random.rand(13)*40+60
			self.y=Random.rand(8)*40+120
			if earth===self||solar===self||item===self
			elsif @map[(self.y-48)/40][(self.x+8)/40]==0
				@flag=1
			end
		end
	end
end
class Item <Sprite
	attr_accessor :earthitem,:solaritem,:earthlife,:mooncount,:solarmode,:meteorite
	def initialize
		@randomitem=Image.load("image/randomitem.png")
		@earhtitem1=Image.load("image/solarmode.png")
		@earhtitem2=Image.load("image/earthlifeup.png")
		@earhtitem3=Image.load("image/earthmoonpieceup.png")
		@solaritem1=Image.load("image/meteoritea.png")
		@solaritem2=Image.load("image/earthdamage.png")
		@solaritem3=Image.load("image/earthmoonpiecedown.png")
		@item=0
		@itemcount=0
		@count=0
		@itemflag=0
		@earthitem=-1
		@solaritem=-1
		@flag2=0
		@itemcountflag=1200
		@solarmode=0
		@solarmodecount=0
		@solarmodeflag=0
		@meteorite=0
		self.image=@randomitem
	end
	def hit(earth,solar)#当たる
		if @earthitem!=1&&@solaritem!=1
			if earth===self&&@flag2==0
				@earthitem=1
			elsif solar===self&&@flag2==0
				@solaritem=1
			end
		end
	end
	def a(earthlife,mooncount)#効果
		@earthlife=earthlife
		@mooncount=mooncount
		if @earthitem==1
			@count+=1
			if @count>=1&&@count<=10
				self.image=@earhtitem1
			elsif @count>=11&&@count<=20
				self.image=@earhtitem2
			else
				self.image=@earhtitem3
			end
		elsif @solaritem==1
			@count+=1
			if @count>=1&&@count<=10
				self.image=@solaritem1
			elsif @count>=11&&@count<=20
				self.image=@solaritem2
			else
				self.image=@solaritem3
			end
		end
		if @itemflag==5&&@flag2==0
			@item=Random.rand(3)+1
			@flag2=1
			@count=0
			@itemcount=0
			if @earthitem==1
				@earthitem=0
				if @item==1
					@solarmodeflag=Random.rand(10)*20+180
					@solarmode=1
					self.image=@earhtitem1
				elsif @item==2
					@earthlife+=1
					self.image=@earhtitem2
				else
					@mooncount+=1
					self.image=@earhtitem3
				end
			elsif @solaritem==1
				@solaritem=0
				if @item==1
					@meteorite=1
					self.image=@solaritem1
				elsif @item==2
					@earthlife-=1
					self.image=@solaritem2
				else
					@mooncount-=1
					self.image=@solaritem3
				end
			end
		elsif @flag2==0&&@count==30
			@itemflag+=1
			@count=0
		elsif @flag2==1
			@count+=1
			if @count==180
				@flag2=0
				@itemcountflag=Random.rand(10)*60+600
				@earthitem=-1
				@solaritem=-1
				@itemflag=0
				@count=0
				@item=0
				self.x=0
				self.y=0
			end
		end
		#太陽が動かなくなるアイテムの処理
		if @solarmode==1
			@solarmodecount+=1
			if @solarmodecount==@solarmodeflag
				@solarmode=0
				@solarmodecount=0
				@solarmodeflag=0
			end
		end
	end
	def syutugen(map,earth,solar,moonpiece)
		@flag=0
		@map=map
		if @itemcount==@itemcountflag
			self.image=@randomitem
			while @flag==0
				self.x=Random.rand(13)*40+60
				self.y=Random.rand(8)*40+115
				if earth===self||solar===self||moonpiece===self
				elsif @map[(self.y-48)/40][(self.x+8)/40]==0
					@flag=1
				end
			end
			@itemcountflag=-1
			@earthitem=0
			@solaritem=0
		elsif @earthitem==-1&&@solaritem==-1
			@itemcount+=1
		end
	end
	def reset
		@item=0
		@itemcount=0
		@count=0
		@itemflag=0
		@earthitem=-1
		@solaritem=-1
		@flag2=0
		@itemcountflag=1200
		@solarmode=0
		@solarmodecount=0
		@solarmodeflag=0
		@meteorite=0
	end
end
class Meteorite <Sprite
	attr_accessor :earthlife,:damage,:meteorite
	def initialize
		self.image=Image.load("image/meteorite.png")
		@meteoritecount=0
		@flag=0
		@damage=0
		@lifekeep=0
		@meteorite=1
	end
	def a(map,earth,solar,moonpiece,item,meteoriteflag)
		@map=map
		@meteoriteflag=meteoriteflag
		if @meteoriteflag==1
			@flag=0
			@meteoriteflag=0
		end
		while @flag==0
			self.x=Random.rand(13)*40+60
			self.y=Random.rand(8)*40+115
			if earth===self||solar===self||moonpiece===self||item===self
			elsif @map[(self.y-48)/40][(self.x+8)/40]==0
				@flag=1
			end
		end
		@meteoritecount+=1
		if @meteoritecount==600
			@meteorite=0
			@meteoritecount=0
			@meteoriteflag=0
		else
			@meteorite=1
		end
	end
	def hit(earth,earthlife)
		@earthlife=earthlife
		if @lifekeep>0
			@lifekeep-=1
		else
			@damage=0
		end
		if earth===self&&@lifekeep==0
			@lifekeep=180
			@damage=1
			@earthlife-=5
		end
	end
end

