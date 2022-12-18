#encoding: Shift_JIS
class Line <Sprite		#モード選択

	def initialize
		self.image=Image.load("image/line.png")
		self.x=160
		self.y=225
	end
	def idou
		if Input.key_push?(K_UP)
			if self.y!=225
				self.y-=50
			end
		end
		if Input.key_push?(K_DOWN)
			if self.y!=375
				self.y+=50
			end
		end
	end
end

class Count < Sprite		#タイム
	attr_accessor :limit,:timeover,:moonflag,:gameset,:h,:lm,:rm,:ls,:rs
	def initialize
		@c=0
		@rs=0
		@ls=0
		@rm=0
		@lm=0
		@h=0
		#鬼ごっこ
		@limitcount=0
		@gamesetcount=0
	end

	def countup(gamemode)		#カウントアップ
		@gamemode=gamemode
		if @gamemode==2
			@c+=1
			if @c==60
				@rs+=1
				@c=0
			end
			if @rs==10
				@ls+=1
				@rs=0
			end
			if @ls==6
				@rm+=1
				@ls=0
			end
			if @rm==10
				@lm+=1
				@rm=0
			end
			if @lm==6
				@h+=1
				@lm=0
			end
		end
	end

	def countdown(gamemode,limit,gameset)		#カウントダウン
		@limit=limit
		@gamemode=gamemode
		@gameset=gameset
		@timeover=0
		@moonflag=0
		@c+=1
		if @gamemode==3		#リミットモード
			if @c==60
				@limit-=1
				@c=0
			end
			@limitcount=@limit	#リミットを時間に残り時間に変える
			if @limitcount>=3600
				@h=@limitcount/3600
				@limitcount=@limitcount-@h*3600
			else
				@h=0
			end
			if @limitcount>=600
				@lm=@limitcount/600
				@limitcount=@limitcount-@lm*600
			else
				@lm=0
			end
			if @limitcount>=60
				@rm=@limitcount/60
				@limitcount=@limitcount-@rm*60
			else
				@rm=0
			end
			if @limitcount>=10
				@ls=@limitcount/10
				@limitcount=@limitcount-@ls*10
			else
				@ls=0
			end
			@rs=@limitcount
			if @h<=0&&@lm<=0&&@rm<=0&&@ls<=0&&@rs<=0		#リミットが0以下になったらゲームオーバー
				@timeover=1
			end
		elsif @gamemode==4			#鬼ごっこ
			if @gameset==1			#試合終了時の画面表示の時間
				@gamesetcount+=1
				if @gamesetcount==180
					@gameset=2
				end
			else
				#月の欠片が出現させるまでの時間
				if @c==60
					@rs-=1
					@c=0
				end
				if @rs<0&&@ls>=0
					@rs=9
					@ls-=1
				end
				if @ls<0&&@rm>=0
					@ls=5
					@rm-=1
				end
				if @rm<0&&@lm>=0
					@rm=9
					@rm=0
				end
				if @lm<0&&@h>=0
					@lm=5
					@h-=1
				end
				if @h<=0&&@lm<=0&&@rm<=0&&@ls<=0&&@rs<=0 #カウントが0になったらフラグを立てる
					@moonflag=1
					@ls=Random.rand(1)+1+@ls
					@rs=Random.rand(10)
				end
			end
		end
	end
	def reset	#変数をリセット
		@c=0
		@rs=0
		@ls=0
		@rm=0
		@lm=0
		@h=0
		#鬼ごっこ
		@limitcount=0
		@gamesetcount=0
	end
end

class Words < Sprite		#文字を表示
	def initialize
		#文字の大きさ
		@hyaku=Font.new(100)
		@nanazyu=Font.new(70)
		@gozyu=Font.new(50)
		@yonzyu=Font.new(40)
		@sanzyu=Font.new(30)
		@nizyu=Font.new(20)
	end
	def gamestart(gamemode,line)		#スタート画面
		@gamemode=gamemode
		@line=line

		#タイトル
		Window.draw_font(140,20,"SUPER",@hyaku)
		Window.draw_font(250,100,"NOVA",@hyaku)
		Window.draw_font(200,220,"ゲームスタート",@yonzyu)
		Window.draw_font(265,320,"遊び方",@yonzyu)
		Window.draw_font(265,370,"おわる",@yonzyu)

		#システムを出力
		Window.draw_font(475,395,"↑,↓ セレクト変更",@nizyu)
		if @line.y!=275
			Window.draw_font(520,375,"SPACE 決定",@nizyu)
		else
			Window.draw_font(470,375,"SPACE モード変更",@nizyu)
		end

		#それぞれのモード名を出力
		if @gamemode==1
			Window.draw_font(215,270,"じっくりモード",@yonzyu)
		elsif @gamemode==2
			Window.draw_font(205,270,"スコアアタック",@yonzyu)
		elsif @gamemode==3
			Window.draw_font(215,270,"リミットモード",@yonzyu)
		elsif @gamemode==4
			Window.draw_font(255,270,"鬼ごっこ",@yonzyu)
		else
			Window.draw_font(230,270,"モード選択",@yonzyu)
		end

		if @line.y==225		#ゲームスタート
			if @gamemode==0
				Window.draw_font(180,415,"モード選択してください",@sanzyu)
				Window.draw_font(195,445,"↓,↑でセレクト変更",@sanzyu)
			else
				Window.draw_font(180,415,"SPACEでゲームスタート",@sanzyu)
				Window.draw_font(195,445,"↓,↑でセレクト変更",@sanzyu)
			end
		elsif @line.y==275 	#モード選択
			#モード説明
			if @gamemode==1
				Window.draw_font(227,415,"《1人用ゲーム》",@sanzyu)
				Window.draw_font(215,445,"難易度 【★☆☆】",@sanzyu)
			elsif @gamemode==2
				Window.draw_font(227,415,"《1人用ゲーム》",@sanzyu)
				Window.draw_font(215,445,"難易度 【★★☆】",@sanzyu)
			elsif @gamemode==3
				Window.draw_font(227,415,"《1人用ゲーム》",@sanzyu)
				Window.draw_font(215,445,"難易度 【★★★】",@sanzyu)
			elsif @gamemode==4
				Window.draw_font(227,415,"《2人用ゲーム》",@sanzyu)
				Window.draw_font(215,445,"難易度 【★★☆】",@sanzyu)
			else
				Window.draw_font(135,415,"SPACEでモード変更ができるよ",@sanzyu)
				Window.draw_font(155,445,"モードは全部で4種類あるよ",@sanzyu)
			end
		elsif @line.y==325	#遊び方
			Window.draw_font(175,415,"基本ルールが学べます",@sanzyu)
			Window.draw_font(115,445,"(各モードの説明ではありません)",@sanzyu)
		elsif line.y==375	#ゲーム終了
			Window.draw_font(205,415,"ゲームを終了します",@sanzyu)
			Window.draw_font(145,445,"本当にゲームを終了しますか",@sanzyu)
		end
	end

	def play(gamemode,gameset,world,stage,clear,score,earthlife,mooncount,h,lm,rm,ls,rs)		#ゲームをプレイ時
		@gamemode=gamemode
		@gameset=gameset
		@world=world
		@stage=stage
		@clear=clear
		@score=score
		@earthlife=earthlife
		@mooncount=mooncount
		@h=h
		@lm=lm
		@rm=rm
		@ls=ls
		@rs=rs
		if @gamemode==1||@gamemode==2||@gamemode==3
			Window.draw_font(460,10,"リトライ　ESCキー",@nizyu)
			Window.draw_font(460,40,"タイトル　ENTERキー",@nizyu)
			if @gamemode==1 	#じっくりモード
				Window.draw_font(30,0,"world#{@world} - stage#{@stage}",@sanzyu)
				Window.draw_font(30,30,"次のステージへ　Zキー\n前のステージへ　Xキー",@nizyu)
			elsif @gamemode==2	#スコアアタック
				Window.draw_font(30,0,"stage#{@clear}/10",@sanzyu)
				Window.draw_font(30,35,"SCORE #{@score}",@yonzyu)
			elsif @gamemode==3	#リミットモード
				Window.draw_font(30,0,"stage#{@clear}/10",@sanzyu)
				Window.draw_font(30,35,"LIMIT #{@h}:#{@lm}#{@rm}:#{@ls}#{@rs}",@yonzyu)
			end
		elsif @gamemode==4		#対戦モード
			Window.draw_font(20,0,"地球ライフ #{@earthlife}/10",@sanzyu)
			Window.draw_font(20,35,"月完成まで #{@mooncount}/10",@sanzyu)
			if @gameset==0
				Window.draw_font(350,0,"月のかけら発生まで",@sanzyu)
				Window.draw_font(430,35,"#{@h}:#{@lm}#{@rm}:#{@ls}#{@rs}",@yonzyu)
			end
		end
	end

	def menu	#メニュー時
		Window.draw_font(50,10,"タイトルに戻りますか？",@sanzyu)	
		Window.draw_font(70,40,"記録は残りません",@sanzyu)
		Window.draw_font(460,10,"はい　ESCキー",@nizyu)
		Window.draw_font(460,40,"いいえ　ENTERキー",@nizyu)
	end

	def clear(gamemode,score,reset,h,lm,rm,ls,rs)		#ゲームクリア時
		@gamemode=gamemode
		@score=score
		@reset=reset
		@h=h
		@lm=lm
		@rm=rm
		@ls=ls
		@rs=rs
		Window.draw_font(20,60,"GAME CLEAR",@hyaku)
		if @gamemode==2		#スコアモード
			Window.draw_font(160,160,"CLEAR SCORE",@gozyu)
			Window.draw_font(280,215,"#{@score}",@yonzyu)
		elsif @gamemode==3	#リミットモード
			Window.draw_font(180,160,"CLEAR LIMIT",@gozyu)
			Window.draw_font(260,215,"#{@h}:#{@lm}#{@rm}:#{@ls}#{@rs}",@yonzyu)
		end
		Window.draw_font(195,260,"リセット回数",@gozyu)
		Window.draw_font(245,315,sprintf("%5d回",@reset),@yonzyu)
=begin		if @gamemode>=3&&@gamemode<=4
		Window.draw_font(155,370,"ランキングへ　SPACEキー",@sanzyu)
=end		end
		Window.draw_font(140,400,"タイトルに戻る　ENTERキー",@sanzyu)
		Window.draw_font(235,430,"終わる　ESCキー",@sanzyu)
	end

	def tutorial(page)			#チュートリアル時
		@page=page
		# システム表示
		if @page!=11&&@page!=18&&@page!=23&&@page!=27&&@page!=34&&@page!=37&&@page!=45&&@page!=52&&@page!=62&&@page!=73
			Window.draw_font(460,10,"次へ　ENTERキー",@nizyu)
		else
			Window.draw_font(460,10,"次へ　ミッションクリア",@nizyu)
		end
		Window.draw_font(460,40,"タイトルへ　ESCキー",@nizyu)
		case @page	#ストーリー
		when 1
			Window.draw_font(20,10,"今日から君は星を操ることができる\nそんな君にやってほしいことがある",@sanzyu)
		when 2
			Window.draw_font(20,10,"その内容は星と星をぶつけて\n「新しい星」を作り出すこと",@sanzyu)
		when 3
			Window.draw_font(20,10,"まず,周りにある紫の銀河\nこのゲームでいう「壁」だ",@sanzyu)
		when 4
			Window.draw_font(20,10,"左の星は人々が\n住んでいる「地球」",@sanzyu)
			Window.draw_font(180,240,"↓",@yonzyu)
			Window.draw_font(180,315,"↑",@yonzyu)
		when 5
			Window.draw_font(20,10,"右の星はウサギたちが\n住んでいる「月」",@sanzyu)
			Window.draw_font(420,240,"↓",@yonzyu)
			Window.draw_font(420,315,"↑",@yonzyu)
		when 6
			Window.draw_font(20,10,"地球と月の関係は\n2つほどある",@sanzyu)
		when 7
			Window.draw_font(20,10,"１つ目は「引力関係」\n月は地球に引っ張られる",@sanzyu)
		when 8
			Window.draw_font(20,10,"２つ目は「新星関係」\n地球と月をぶつけたら「ゴール」",@sanzyu)
		when 9
			Window.draw_font(20,10,"それでは地球たちを動かして\n「新しい星」（ゴール）を生み出そう!!",@sanzyu)
		when 10
			Window.draw_font(20,10,"《操作説明》\n(矢印キーで地球を動かそう)",@sanzyu)
		when 11
			Window.draw_font(20,10,"《ルール１》\n(地球と月をぶつけよう)",@sanzyu)
		when 12
			Window.draw_font(20,10,"これでゲームクリア!\nここまでのルールは簡単だろ",@sanzyu)
		when 13
			Window.draw_font(20,10,"しかし、地球や月以外に\n太陽が存在する",@sanzyu)
			Window.draw_font(300,160,"↓",@yonzyu)
			Window.draw_font(300,230,"↑",@yonzyu)
		when 14
			Window.draw_font(20,10,"太陽のことについて……\n悪いニュースが２つある",@sanzyu)
		when 15
			Window.draw_font(20,10,"１つ目は星を動かす力の副作用で\n地球と太陽が一緒に動いてしまう",@sanzyu)
		when 16
			Window.draw_font(20,10,"２つ目は太陽のエネルギーが強く\n触れた星を粉々にしてしまう",@sanzyu)
		when 17
			Window.draw_font(20,10,"太陽から逃げながら\n地球と月をぶつけてほしい",@sanzyu)
		when 18
			Window.draw_font(20,10,"《ルール２》\n(太陽に触れてはいけない)",@sanzyu)
		when 19
			Window.draw_font(20,10,"これが地球と月と太陽の\n基本的なルールだ!",@sanzyu)
		#タイル
		when 20
			Window.draw_font(20,10,"次は「タイル」について\n説明をする",@sanzyu)
		when 21
			Window.draw_font(20,10,"真ん中にあるのは\n「地球タイル」だ",@sanzyu)
			Window.draw_font(260,235,"→",@yonzyu)
			Window.draw_font(260,275,"→",@yonzyu)
			Window.draw_font(340,235,"←",@yonzyu)
			Window.draw_font(340,275,"←",@yonzyu)
		when 22
			Window.draw_font(20,10,"想像がつくかもしれないが\n地球しか通れないようになっている",@sanzyu)
		when 23
			Window.draw_font(20,10,"《ルール３》\n(タイルと星が同じ模様なら通れる)",@sanzyu)
		when 24
			Window.draw_font(20,10,"同じ模様の星が通れる\nこのルールも簡単だろ",@sanzyu)
		when 25
			Window.draw_font(20,10,"もちろん「地球タイル」のほかに\n「月タイル」と「太陽タイル」もある",@sanzyu)
		when 26
			Window.draw_font(20,10,"それぞれ同じ模様しか通れない\nそれではやってみよう",@sanzyu)
		when 27
			Window.draw_font(20,10,"《ルール３》\n(タイルと星が同じ模様なら通れる)",@sanzyu)
		when 28
			Window.draw_font(20,10,"このステージを突破したなら\n君はタイルマスターだ!!",@sanzyu)
		#惑星スイッチ
		when 29
			Window.draw_font(20,10,"次に「惑星スイッチ」について\n説明をしていこう",@sanzyu)
		when 30
			Window.draw_font(20,10,"周りの茶色いやつ\nそいつが「惑星」だ",@sanzyu)
			Window.draw_font(220,115,"→",@yonzyu)
			Window.draw_font(380,115,"←",@yonzyu)
			Window.draw_font(260,195,"↑",@yonzyu)
			Window.draw_font(300,195,"↑",@yonzyu)
			Window.draw_font(340,195,"↑",@yonzyu)
		when 31
			Window.draw_font(20,10,"「惑星」は「壁」と同様に\n通ることができない",@sanzyu)
		when 32
			Window.draw_font(20,10,"これじゃゴールできないって？\nそう早まることはない",@sanzyu)
		when 33
			Window.draw_font(20,10,"星形の惑星スイッチがあるだろ\nそこまで地球を連れてきてくれ",@sanzyu)
			Window.draw_font(300,315,"↑",@yonzyu)
		when 34
			Window.draw_font(20,10,"《ルール４》\n（？？？？？？？）",@sanzyu)
			Window.draw_font(300,315,"↑",@yonzyu)
		when 35
			Window.draw_font(20,10,"惑星が消えただろ\nこれが惑星スイッチの力だ",@sanzyu)
		when 36
			Window.draw_font(20,10,"後は地球と月をぶつけて\nゴールしよう",@sanzyu)
		when 37
			Window.draw_font(20,10,"《ルール４》\n（惑星スイッチで惑星を操る）",@sanzyu)
		when 38
			Window.draw_font(20,10,"実は惑星スイッチは２種類ある\n今回は惑星を消すスイッチだが",@sanzyu)
		when 39
			Window.draw_font(20,10,"逆に惑星を呼び出すスイッチもある\nひし形の惑星スイッチだ",@sanzyu)
			Window.draw_font(100,155,"↓",@yonzyu)
			Window.draw_font(100,235,"↑",@yonzyu)
		when 40
			Window.draw_font(20,10,"惑星スイッチはとても便利だが\n誤った操作でGAMEOVERになる",@sanzyu)
		when 41
			Window.draw_font(20,10,"それは惑星を呼び出す際に\n地球、月、太陽のいずれかが",@sanzyu)
		when 42
			Window.draw_font(20,10,"惑星の出現場所にいると\n惑星につぶされてしまう",@sanzyu)
		when 43
			Window.draw_font(20,10,"太陽はつぶれてもよさそうだが\nつぶれた衝撃で銀河が崩壊する",@sanzyu)
		when 44
			Window.draw_font(20,10,"２種類の惑星スイッチを利用して\nこのステージもゴールしよう",@sanzyu)
		when 45
			Window.draw_font(20,10,"《ルール５》\n（惑星につぶされるな）",@sanzyu)
		when 46
			Window.draw_font(20,10,"これで惑星を使いこなせるな\nおめでとう!!",@sanzyu)
		#彗星
		when 47
			Window.draw_font(20,10,"次は「彗星」について説明をしよう\nこれが「彗星」だ!",@sanzyu)
			Window.draw_font(260,115,"↓",@yonzyu)
			Window.draw_font(260,195,"↑",@yonzyu)
			Window.draw_font(340,195,"↑",@yonzyu)
			Window.draw_font(340,115,"↓",@yonzyu)
		when 48
			Window.draw_font(20,10,"見た瞬間わかるかもしれないが\n矢印の方向へしか動けない\n",@sanzyu)
		when 49
			Window.draw_font(20,10,"さらに、地球はもろいため\n矢印関係なく通れない",@sanzyu)
		when 50
			Window.draw_font(20,10,"地球は人間の環境破壊活動により\n生命力が削られてもろくなった",@sanzyu)
		when 51
			Window.draw_font(20,10,"まあ、彗星を利用して\nこのステージをゴールしてくれ",@sanzyu)
		when 52
			Window.draw_font(20,10,"《ルール６》\n（彗星は矢印の方向しか動けない）",@sanzyu)
		when 53
			Window.draw_font(20,10,"このステージもクリアするとは!!\nもう彗星は怖くないぞ!!",@sanzyu)
		#引力スイッチ
		when 54
			Window.draw_font(20,10,"次に「引力スイッチ」\nについて説明する",@sanzyu)
		when 55
			Window.draw_font(20,10,"地球と月には\n引力関係があると言ったが",@sanzyu)
		when 56
			Window.draw_font(20,10,"その関係を意図的に変えることが\n可能なスイッチである",@sanzyu)
		when 57
			Window.draw_font(20,10,"そのスイッチがこれだ!\n今回もスイッチは２種類ある",@sanzyu)
		when 58
			Window.draw_font(20,10,"三角形をしたスイッチは\n地球と月を反発させる",@sanzyu)
			Window.draw_font(340,355,"→",@yonzyu)
		when 59
			Window.draw_font(20,10,"丸の形をしたスイッチは\n引力関係を元に戻すスイッチだ",@sanzyu)
			Window.draw_font(260,355,"←",@yonzyu)
		when 60
			Window.draw_font(20,10,"スイッチの内容は簡単だが\n反発時の操作は難しいぞ!",@sanzyu)
		when 61
			Window.draw_font(20,10,"百聞は一見にしかずだ!\nこのステージをクリアしよう",@sanzyu)
		when 62
			Window.draw_font(20,10,"《ルール７》\n（引力スイッチで月を動かそう）",@sanzyu)
		when 63
			Window.draw_font(20,10,"このギミックを超えたなら\n残るギミックはあと１つだ!!",@sanzyu)
		#隕石
		when 64
			Window.draw_font(20,10,"最後に「隕石」について\n説明する",@sanzyu)
		when 65
			Window.draw_font(20,10,"これが隕石だ!!\n（目玉焼きじゃないよ～）",@sanzyu)
			Window.draw_font(140,195,"↑",@yonzyu)
			Window.draw_font(180,195,"↑",@yonzyu)
			Window.draw_font(420,195,"↑",@yonzyu)
			Window.draw_font(460,195,"↑",@yonzyu)
		when 66
			Window.draw_font(20,10,"隕石は太陽と同様に\nエネルギーがとても強い",@sanzyu)
		when 67
			Window.draw_font(20,10,"隕石と地球、月をぶつけたら\n粉々になってしまう",@sanzyu)
		when 68
			Window.draw_font(20,10,"しかし太陽だけは例外だ\nお互いのエネルギーが強い影響か",@sanzyu)
		when 69
			Window.draw_font(20,10,"次元が乱れてしまい\nあたらないようになる",@sanzyu)
		when 70
			Window.draw_font(20,10,"つまり、太陽と隕石をぶつけても\n無害ということだ",@sanzyu)
		when 71
			Window.draw_font(20,10,"このステージはチュートリアルの\n最後のステージだ!",@sanzyu)
		when 72
			Window.draw_font(20,10,"隕石に触れないように\nこのステージをクリアしよう",@sanzyu)
		when 73
			Window.draw_font(20,10,"《ルール8》\n（地球、月は隕石とあたるな）",@sanzyu)
		when 74
			Window.draw_font(20,10,"チュートリアルクリアおめでとう!!\nプレイしてくれてありがとう!!",@sanzyu)
		when 75
			Window.draw_font(20,10,"本番はここからだけど\nがんばってね!!",@sanzyu)
		end
	end
end
		