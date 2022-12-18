#encoding: Shift_JIS

require"dxruby"
require"yaml"			#マップの設定
#それぞれのclassをプログラムにまとめたもの
require_relative"program/charcter.rb"
require_relative"program/gameover.rb"
require_relative"program/tile.rb"
require_relative"program/item.rb"
require_relative"program/system.rb"
file_name="map/map1.yml"		#初期のmapを宣言
@map = YAML.load_file(file_name)	#mapを読み込みむ
@map_tile = []				#配列の宣言
@map_tile[0]=Image.new(40,40,C_DEFAULT)			#何も無い空間
@map_tile[1]=Image.load("image/meteorite.png")		#隕石（あたってはいけないマス）
@map_tile[2]=Image.load("image/earthtile.png")		#地球タイル（地球しか通れないマス）
@map_tile[3]=Image.load("image/moontile.png")		#月タイル（月しか通れないマス）
@map_tile[4]=Image.load("image/solartile.png")		#太陽タイル（太陽しか通れないマス）
@map_tile[5]=Image.load("image/wall.png")		#壁
@map_tile[6]=Image.load("image/planet.png")		#惑星(スイッチによって通れたり通れなかったり)
@map_tile[7]=Image.load("image/cometUP.png")		#彗星(方向制限マス↑)
@map_tile[8]=Image.load("image/cometDOWN.png")		#彗星(方向制限マス↓)
@map_tile[9]=Image.load("image/cometRIGHT.png")		#彗星(方向制限マス→)
@map_tile[10]=Image.load("image/cometLEFT.png")		#彗星(方向制限マス←)
@map_tile[11]=Image.load("image/planetkey.png")		#惑星スイッチON(惑星を消すスイッチ)
@map_tile[12]=Image.load("image/planetswich.png")	#惑星スイッチOFF(惑星を出すスイッチ)
@map_tile[13]=Image.load("image/moonkey.png")		#引力スイッチON(月を反発させるスイッチ）
@map_tile[14]=Image.load("image/moonswich.png")		#引力スイッチOFF(月を元に戻すスイッチ)
@map_tile[15]=Image.new(40,40,C_DEFAULT)		#キャラクター(地球)
@map_tile[16]=Image.new(40,40,C_DEFAULT)		#キャラクター(月)
@map_tile[17]=Image.new(40,40,C_DEFAULT)		#キャラクター(太陽)
@map_tile[18]=Image.load("image/planet.png")		#リセット(惑星の画像を元に戻す)
@map_tile[19]=Image.load("image/planetbreak.png")	#惑星を壊した時の画像

#変数宣言
start=0
stageflag=0
result=1
flag=0
mapload=0
gamestart=0
pushflag=0
moonplace=0
solarplace=0
#スコアアタック
score=0
point=0
#対戦モード
mooncount=0
earthlife=10
damagecount=0
meteoriteflag=0
#ステージクリアしたときのフラグ
clear=1
clearflag=0
#ステージ
stage=5
world=0
gameset=0
reset=0
#地球の動きや画面に映すのを制限
mode=0
#マップ
map=0
limit=0
count=0
#モード選択
gamemode=0
#チュートリアル
page=1
tutorial=0
#class変換
#キャラクター
earth=Earth.new
moon=Moon.new
solar=Solar.new
#ゲームオーバー
gameover=Gameover.new
#タイル
tile=Tile.new
#システム
line=Line.new
count=Count.new
#鬼ごっこ
item=Item.new
moonpiece=Moonpiece.new
meteorite=Meteorite.new
words=Words.new

#スイッチ
planetkey = Sprite.new(300,40,Image.load("image/planetkeymin.png"))
planetswich = Sprite.new(340,40,Image.load("image/planetswichmin.png"))
moonkey = Sprite.new(380,40,Image.load("image/moonkeymin.png"))
moonswich = Sprite.new(420,40,Image.load("image/moonswichmin.png"))

#画像
cross = Image.load("image/cross.png")
#背景
background = Sprite.new(0,0,Image.load("image/Background.png"))
background2 = Sprite.new(0,0,Image.load("image/Background2.png"))

Window.loop do	#本文
	Sprite.draw(background)	#背景の出力

	if start==0	#タイトル画面
		#変数をリセット
		line.idou
		line.draw
		words.gamestart(gamemode,line)
		#システム表示
		if line.y==225		#ゲーム開始
			if gamemode>=1
				if Input.key_push?(K_SPACE)
					mode=1
					map=1
					reset=0
					stageflag=1
					clear=1
					start=1
					gamestart=1
					mapload=0
					result=1
					count.reset
					gameover.reset
					#モード別
					if gamemode==2||gamemode==3
						limit=0
						score=0
					elsif gamemode==4
						earthlife=10
						mooncount=0
						map=Random.rand(2)+52
					end
				end
			end
		elsif line.y==275	#モード選択
			if Input.key_push?(K_SPACE)
				gamemode+=1
				#ゲームモードの行き過ぎた場合
				if gamemode>4
					gamemode=1
				end
			end
		elsif line.y==325	#遊び方
			if Input.key_push?(K_SPACE)
				map=101
				start=2
				stageflag=1
			end
		elsif line.y==375	#ゲーム終了
			if Input.key_push?(K_SPACE)
				break
			end
		end
	end
	if start==1		 #ゲームスタート
		#ゲームモード別のマップの呼び出し
		if clearflag==1||gamestart==1
			if gamemode==1&&map!=50&&gamestart==0	#じっくりモード
				map+=1
			elsif (gamemode==2||gamemode==3)	#リミットモードとスコアアタック
				map=clear*5+Random.rand(5)-4
				#マップごとのリミットとポイント
				if (map>=1&&map<=3)||map==6||map==10
					limit=limit+30
					point=4500
				elsif map==4||map==5||(map>=7&&map<=9)||(map>=11&&map<=13)||(map>=21&&map<=25)||(map>=28&&map<=32)
					limit=limit+40
					point=6000
				elsif (map>=14&&map<=18)||map==26||map==27||(map>=33&&map<=35)
					limit=limit+50
					point=7500
				elsif (map>=19&&map<=20)||(map>=36&&map<=40)
					limit=limit+60
					point=9000
				elsif map>=41&&map<=45
					limit=limit+70
					point=10500
				elsif map>=46&&map<=50
					limit=limit+80
					point=12000
				end
			end
			#他のモードと同じ処理をしないようにするため
			if gamemode==2
				limit=0
			elsif gamemode==3
				point=0
			end
			#クリアフラグを0にして処理を被らせない
			clearflag=0
			gamestart=0
		end
	end
	if stageflag==1	#マップのリセットやフラグのリセット
		if map>=1&&map<=100		#通常map
			file_name="map/map#{map}.yml"		#マップを決定
		elsif map>=101&&map<=109	#チュートリアルmap
			file_name="map/tutorial#{map-100}.yml"	#マップを決定
		end
		@map = YAML.load_file(file_name)
		stageflag=0
		mapload=1
		tile.planeton=0
		tile.planetoff=0
		tile.moonon=0
		tile.moonoff=0
		@map_tile[6]=@map_tile[18]
		moonplace=0
		solarplace=0
		#キャラクターの座標指定
		for i in 0..14
			for j in 0..9
				if @map[j][i]==15	#地球の座標
					earth.x=i*40+20
					earth.y=j*40+80
				end
				if @map[j][i]==16	#月の座標
					moonplace=1
					moon.x=i*40+20
					moon.y=j*40+80
				end
				if @map[j][i]==17	#太陽の座標
					solarplace=1
					solar.x=i*40+20
					solar.y=j*40+80
				end
			end
		end
		if moonplace==0		#鬼ごっこモード時
			moon.x=0		#月の座標を0にする
			moon.y=0
		elsif solarplace==0	#チュートリアル時
			solar.x=0		#太陽の座標を0にする
			solar.y=0
		end
	end
	if start!=0&&mapload==1&&result!=3	#ゲームスタート時にすべてのモードに共通する処理
		Window.draw_tile(20,75,@map,@map_tile ,0 ,0 ,15 ,10)		#マップの出力
		#タイム,リミットをカウントするclass
		if start==1&&((gameover.gameend!=9&&gamemode==3)||gamemode==4)
			count.countup(gamemode)
			count.countdown(gamemode,limit,gameset)
			#class内で変わった変数を元の変数に代入する
			limit=count.limit
		end

		#GAMECLEARまたはGAMEOVERを判断するClass
		gameover.game(@map,earth,moon,solar,tile.planetoff,count.timeover,start,result,gamemode,earthlife,mooncount,gamestart)
		#class内で変わった変数を元の変数に代入する
		earthlife=gameover.earthlife

		if result==2||result==3||(gameover.gameend>=2&&gameover.gameend<=11)
			mode=0				#キャラクターを動かさないようにする処理
		end

		tile.game(@map,earth,moon,solar)	#スイッチの処理

		if start==1&&gamemode==4		#アイテムや隕石の表示
			if item.earthitem!=-1&&item.solaritem!=-1
				item.draw		#アイテムを表示
			end
			if item.meteorite==1
				meteorite.draw		#隕石を表示
			end
		end
		#キャラクター出力
		if (result!=3&&gameover.damage==0&&meteorite.damage==0||earthlife==0)||start==2
			earth.draw	#地球を出力

		else
			if damagecount>=5&&damagecount<=10
				earth.draw	#地球を出力
			end
			damagecount+=1
			if damagecount==10
				damagecount=0
			end
		end
		if start==2||(result!=3&&gamemode!=4)
			moon.draw	#月を出力
		end
		if (result!=3&&start==1)||(start==2&&(page>=13&&page<=19)||(page>=25&&page<=28)||(page>=47&&page<=53)||(page>=64&&page<=75))
			solar.draw	#太陽を出力
		end

		#キャラクターそれぞれの移動宣言
		if (start==1&&mode==1&&gameset==0)||(start==2&&(page==11||page==18||page==23||page==27||page==34||page==37||page==45||page==52||page==62||page==73))
			earth.mode(@map,tile.planeton,tile.planetoff,point)
			if (start==1&&gamemode!=4)||start==2	#鬼ごっこモードのとき以外は動く
				moon.mode(earth,@map,tile.planeton,tile.planetoff,tile.moonon)
			end
			if (start==1&&gamemode!=4||item.solarmode!=1)||(start==2&&(page==18||page==27||page==52||page==73))	#鬼ごっこモードと太陽がうごけなくなるアイテムを使われたとき以外は動く
				solar.mode(@map,tile.planeton,tile.planetoff,gamemode,start)
			end
		end
		if gameover.gameend>=2&&gameover.gameend<=11&&start==1
			gameover.draw #ゲームオーバー時の演出
		end

		#ワールド,マップの計算
		if map%5==1
			world=map/5+1
		elsif map%5==0
			world=map/5
		end
		stage=map%5
		if stage==0
			stage=5
		end

		#スイッチタイルを踏んだ後の処理
		if tile.planeton==1&&result<=2&&tile.planetoff==0
			@map_tile[6]=@map_tile[19]
		end
		if tile.moonon==1&&tile.moonoff==1
			tile.moonoff=0
		end
		#惑星（お邪魔タイル）の画像処理と変数処理
		if tile.planetoff==1&&result<=2
			@map_tile[6]=@map_tile[18]
			if tile.planeton==1
				tile.planeton=0
			end
		end
	end
	case start	 #ゲームのプレイ状況
	when 1		 #ゲームスタート
		#ステージクリアをしたとき
		if gameover.gameend==1
			stageflag=1
			clearflag=1
			#クリアという変数を増やす
			if gamemode==2||gamemode==3
				clear+=1
				#スコアの加算
				if gamemode==2
					score=score+point
				end
			end
		end
		if gamemode==1 #じっくりモード
			#マップを行ったりきたり
			if (Input.key_down?(K_Z)&&map<50)||(Input.key_down?(K_X)&&map>1)
				stageflag=1
				pushflag+=1
				#長押しでステージ移動をすばやく済ませる
				if pushflag==30&&Input.key_down?(K_Z)&&map<50
					map+=1
					pushflag=20
				elsif pushflag==30&&Input.key_down?(K_X)&&map>1
					map-=1
					pushflag=20
				#ボタンを押すとステージ移動する
				elsif Input.key_push?(K_Z)&&map<50
					map+=1
				elsif Input.key_push?(K_X)&&map>1
					map-=1
				end
			else 
				pushflag=0
			end
		elsif gamemode==2 #スコアモード
			point=earth.point
			point-=1
		elsif gamemode==4 #鬼ごっこ
			if gameover.gameend==6||gameover.gameend==8||gameover.gameend==10||gameover.gameend==11			#ゲームセット
				gameset=1
				#表示する時間
				if count.gameset==2
					start=0
					mooncount=0
					meteoriteflag=0
					gameset=0
					item.reset
					count.reset
				end
			else		#試合中の処理
				#月の欠片を表示
				if moonpiece.x!=0&&moonpiece.y!=0
					moonpiece.draw
				end
				#アイテムの処理をするclass
				item.hit(earth,solar)
				item.a(earthlife,mooncount)
				item.syutugen(@map,earth,solar,moonpiece)
				#class内で変わった変数を元の変数に代入する
				earthlife=item.earthlife
				mooncount=item.mooncount
				#アイテムが隕石だった場合
				if item.meteorite==1
					meteorite.a(@map,earth,solar,moonpiece,item,meteoriteflag)
					meteorite.hit(earth,earthlife)
					meteoriteflag=0
					#class内で変わった変数を元の変数に代入する
					earthlife=meteorite.earthlife
					item.meteorite=meteorite.meteorite
				else
					meteoriteflag=1
				end
				if count.moonflag==1
					moonpiece.syutugen(@map,earth,solar,item)	#時間で月の欠片をリセットするclass

				end
				if earth===moonpiece||solar===moonpiece			#月の欠片を回収したときの処理
					if earth===moonpiece
						mooncount+=1
					else
						count.ls+=2
					end
					moonpiece.x=0
					moonpiece.y=0
				end
			end
			#月の欠片の個数が行き過ぎた場合
			if mooncount>10		#月のライフが0以下の場合
				mooncount=10
			elsif mooncount<0	#月のライフが10以上の場合
				mooncount=0
			end
			#地球のライフが行き過ぎた場合
			if earthlife<0		#地球のライフが0以下の場合
				earthlife=0
			elsif earthlife>10	#地球のライフが10以上の場合
				earthlife=10
			end
		end
		case result		#ゲームの状態
		when 1 			#通常時
			if gameover.gameend==0||gameover.gameend==10||gameover.gameend==11
				mode=1			#キャラクターの動きを制限
				words.play(gamemode,gameset,world,stage,clear,score,earthlife,mooncount,count.h,count.lm,count.rm,count.ls,count.rs) #リセットの表示
			end
			if gamemode!=4		#鬼ごっこモードじゃないとき
				if Input.key_push?(K_ESCAPE)		#リセットを使用時
					if gameover.gameend==9
						map=0
						clear=1
						limiT=0
						count.limit=0
						clearflag=1
						reset=0
					else
						if gamemode==2		#スコアモード
							point-=500
						end
						reset+=1		#リセット回数をプラス1
					end
					gameover.gameend=0		#変数をリセット
					stageflag=1
					result=1
					mode=1
				end
				if Input.key_push?(K_RETURN)		#メニュー画面へ戻る
					result=2
				end
			end
		when 2			#諦めてタイトルへ戻る場合
			words.menu	#メニュー時の文字の出力するclass
			if Input.key_push?(K_ESCAPE)		#タイトルに戻る
				start=0
				count.reset
			end
			if Input.key_push?(K_RETURN)		#ゲームに戻る
				result=1
			end
		when 3			#ゴールしたとき
			words.clear(gamemode,score,reset,count.h,count.lm,count.rm,count.ls,count.rs)	#クリアしたときの文字を出力するclass
			if Input.key_push?(K_RETURN)		#タイトル画面へ
				start=0
				result=1
			elsif Input.key_push?(K_ESCAPE)		#ゲーム終了
				break
			end
		end
		if gamemode!=4		#スイッチの状況を出力する
			if tile.planeton==1&&result<=2
				Sprite.draw(planetkey)		#画像(惑星スイッチON)
			elsif tile.planetoff==1&&result<=2
				Sprite.draw(planetswich)	#画像(惑星スイッチOFF)
			end
			if tile.moonoff==1&&result<=2
				Sprite.draw(moonswich)		#画像(引力スイッチON)
			elsif tile.moonon==1&&result<=2
				Sprite.draw(moonkey)		#画像(引力スイッチOFF)
			end
		else
			if item.solarmode==1		#太陽が動けないときの処理
				Window.draw(solar.x,solar.y,cross)	#太陽の上に×印をつける
			end
		end
		if clear==11		#リミットモード,タイムアタックのクリア
			gameover.gameend=0
			result=3
			clear=1
		end
	when 2			#チュートリアル	
		words.tutorial(page) 		#チュートリアルでの説明文などを出力するclass
		if Input.key_push?(K_ESCAPE)||page==76		#タイトルへ戻るまたはステージリセットまたはチュートリアルを完璧に進めたら
			start=0
			page=1
			map=0
			flag=0
			stageflag=0
			tile.planeton=0
			tile.planetoff=0
			tile.moonon=0
			tile.moonoff=0
			@map_tile[6]=@map_tile[18]
			gameover.gameend=0
		end
		if tile.planeton==1&&tile.planetoff==0		#スイッチタイルを踏んだ後の処理
			@map_tile[6]=@map_tile[19]
		end
		if tile.moonon==1&&tile.moonoff==1
			tile.moonoff=0
		end
		#次へ進む
		if page==11||page==18||page==23||page==27||page==34||page==37||page==45||page==52||page==62||page==73	#キャラを動かして次へ進む
			#GAMECLEARとGAMEOVERの処理
			if page==34&&earth.x>=300&&earth.x<=340&&earth.y>=310&&earth.y<=312
				page+=1
			elsif gameover.gameend==1
				page+=1
				flag=1
			elsif gameover.gameend>=2&&gameover.gameend<=9
				stageflag=1
			end
		elsif Input.key_push?(K_RETURN)	#ENTERを押して進む
			page+=1
		end
		if (page==13||page==20||page==25||page==29||page==39||page==47||page==54||page==64)&&flag==1	#mapの呼び出し
			map+=1
			flag=0
			stageflag=1
		end
	end
end
