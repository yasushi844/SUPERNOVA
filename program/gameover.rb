#encoding: Shift_JIS
#GAME OVER
class Gameover <Sprite
	attr_accessor :gameend,:earthlife,:damage
	def initialize
		@lifekeep=0
		@damage=0
		@nizyu=Font.new(20)
		@sanzyu=Font.new(30)
		@yonzyu=Font.new(40)
		self.image=Image.load("image/break.png")
	end
	def game(map,earth,moon,solar,planetoff,timeover,start,result,gamemode,earthlife,mooncount,gamestart)
		@map=map
		@timeover=timeover
 		@planetoff=planetoff
		@gameend=0
		@start=start
		@gamemode=gamemode
		@earthlife=earthlife
		@mooncount=mooncount
		@gamestart=gamestart
		#月と地球が当たるとクリア　NEXT Stageへ
		if earth === moon
			@gameend=1
		#地球と太陽が当たるとゲームオーバー　
		elsif earth === solar
			if @gamemode==4&&@earthlife>0&&@lifekeep==0&&@start==1
				@lifekeep=180
				@earthlife-=5
			elsif @gamemode!=4&&@start==1
				@gameend=2
				self.y=earth.y-10
				self.x=earth.x-10
				Window.draw_font(30,10,"地球と太陽が衝突しました!!",@sanzyu) if result==1
			end
		#月と太陽が当たるとゲームオーバー
		elsif moon === solar
			@gameend=3
			self.y=moon.y-10
			self.x=moon.x-10
			Window.draw_font(30,10,"月と太陽が衝突しました!!",@sanzyu) if result==1
		#地球と隕石が当たるとゲームオーバー　
		elsif @map[(earth.y-48)/40][(earth.x-20)/40]==1||@map[(earth.y-48)/40][(earth.x+8)/40]==1|| @map[(earth.y-74)/40][(earth.x-20)/40]==1||@map[(earth.y-74)/40][(earth.x+8)/40]==1||@map[(earth.y-48)/40][(earth.x+8)/40]==1||@map[(earth.y-74)/40][(earth.x+8)/40]==1|| @map[(earth.y-48)/40][(earth.x-20)/40]==1||@map[(earth.y-74)/40][(earth.x-20)/40]==1
			@gameend=4
			self.y=earth.y-10
			self.x=earth.x-10
			Window.draw_font(30,10,"地球と隕石が衝突しました!!",@sanzyu) if result==1
		#隕石と月が当たるとゲームオーバー　
		elsif @map[(moon.y-48)/40][(moon.x-20)/40]==1||@map[(moon.y-48)/40][(moon.x+8)/40]==1|| @map[(moon.y-74)/40][(moon.x-20)/40]==1||@map[(moon.y-74)/40][(moon.x+8)/40]==1||@map[(moon.y-48)/40][(moon.x+8)/40]==1||@map[(moon.y-74)/40][(moon.x+8)/40]==1|| @map[(moon.y-48)/40][(moon.x-20)/40]==1||@map[(moon.y-74)/40][(moon.x-20)/40]==1
			@gameend=5
			self.y=moon.y-10
			self.x=moon.x-10
			Window.draw_font(30,10,"月と隕石が衝突しました!!",@sanzyu) if result==1
		#惑星に埋まったらゲームオーバー 
		elsif @planetoff==1
			if @map[(earth.y-49)/40][(earth.x-20)/40]==6||@map[(earth.y-49)/40][(earth.x+8)/40]==6|| @map[(earth.y-73)/40][(earth.x-20)/40]==6||@map[(earth.y-73)/40][(earth.x+8)/40]==6||@map[(earth.y-48)/40][(earth.x+6)/40]==6||@map[(earth.y-74)/40][(earth.x+6)/40]==6|| @map[(earth.y-48)/40][(earth.x-18)/40]==6||@map[(earth.y-74)/40][(earth.x-18)/40]==6
				@gameend=6
				self.y=earth.y-10
				self.x=earth.x-10
				#条件に応じて表示を変える
				if @gamemode==4&&@start==1
					Window.draw_font(180,0,"地球が惑星に埋まった",@sanzyu)
					Window.draw_font(220,35,"太陽の勝利",@yonzyu)
				else
					Window.draw_font(30,10,"地球が惑星に埋まりました!!",@sanzyu) if result==1
				end
			elsif @map[(moon.y-49)/40][(moon.x-20)/40]==6||@map[(moon.y-49)/40][(moon.x+8)/40]==6|| @map[(moon.y-73)/40][(moon.x-20)/40]==6||@map[(moon.y-73)/40][(moon.x+8)/40]==6||@map[(moon.y-48)/40][(moon.x+6)/40]==6||@map[(moon.y-74)/40][(moon.x+6)/40]==6|| @map[(moon.y-48)/40][(moon.x-18)/40]==6||@map[(moon.y-74)/40][(moon.x-18)/40]==6
				@gameend=7
				self.y=moon.y-10
				self.x=moon.x-10
				Window.draw_font(30,10,"月が惑星に埋まりました!!",@sanzyu) if result==1
			elsif @map[(solar.y-49)/40][(solar.x-20)/40]==6||@map[(solar.y-49)/40][(solar.x+8)/40]==6|| @map[(solar.y-73)/40][(solar.x-20)/40]==6||@map[(solar.y-73)/40][(solar.x+8)/40]==6||@map[(solar.y-48)/40][(solar.x+6)/40]==6||@map[(solar.y-74)/40][(solar.x+6)/40]==6|| @map[(solar.y-48)/40][(solar.x-18)/40]==6||@map[(solar.y-74)/40][(solar.x-18)/40]==6
				@gameend=8
				self.y=solar.y-10
				self.x=solar.x-10
				#条件に応じて表示を変える
				if @gamemode==4&&@start==1
					Window.draw_font(180,0,"太陽が惑星に埋まった",@sanzyu)
					Window.draw_font(220,35,"地球の勝利",@yonzyu)
				else
					Window.draw_font(30,10,"太陽が惑星に埋まりました!!",@sanzyu) if result==1
				end
			else
				@gameend=0
			end
		else
			@gameend=0
		end
		#リミットモード
		if @timeover==1&&@gamestart==0
			@gameend=9
			self.y=earth.y-10
			self.x=earth.x-10
			Window.draw_font(30,10,"制限時間を過ぎました",@sanzyu) if result==1
		end
		#鬼ごっこモード
		if @earthlife==0&&@gamemode==4&&@start==1
			@gameend=10
			self.y=earth.y-10
			self.x=earth.x-10
			Window.draw_font(260,35,"太陽の勝利",@yonzyu)
			Window.draw_font(240,0,"太陽が地球を破壊",@sanzyu)
		elsif @mooncount==10&&@gamemode==4&&@start==1
			@gameend=11
			self.y=solar.y-10
			self.x=solar.x-10
			Window.draw_font(260,35,"地球の勝利",@yonzyu)
			Window.draw_font(295,0,"月が完成",@sanzyu)
		end
		#連続でダメージを受けない処理
		if @lifekeep!=0
			@damage=1
			@lifekeep-=1
		else
			@damage=0
		end
		if @gameend>=2&&@gameend<=9&&result!=2&&@gamemode!=4&&@start==1 #通常のゲームでのゲームオーバー時
				Window.draw_font(100,40,"GAME OVER",@sanzyu)	#ゲームオーバーの表示
				Window.draw_font(460,10,"リトライ　ESCキー",@nizyu)
				Window.draw_font(460,40,"タイトル　ENTERキー",@nizyu)
		end
	end
	def reset
		@lifekeep=0
		@damage=0
		@gameend=0
	end
end
