#encoding: Shift_JIS

require"dxruby"
require"yaml"			#�}�b�v�̐ݒ�
#���ꂼ���class���v���O�����ɂ܂Ƃ߂�����
require_relative"program/charcter.rb"
require_relative"program/gameover.rb"
require_relative"program/tile.rb"
require_relative"program/item.rb"
require_relative"program/system.rb"
file_name="map/map1.yml"		#������map��錾
@map = YAML.load_file(file_name)	#map��ǂݍ��݂�
@map_tile = []				#�z��̐錾
@map_tile[0]=Image.new(40,40,C_DEFAULT)			#�����������
@map_tile[1]=Image.load("image/meteorite.png")		#覐΁i�������Ă͂����Ȃ��}�X�j
@map_tile[2]=Image.load("image/earthtile.png")		#�n���^�C���i�n�������ʂ�Ȃ��}�X�j
@map_tile[3]=Image.load("image/moontile.png")		#���^�C���i�������ʂ�Ȃ��}�X�j
@map_tile[4]=Image.load("image/solartile.png")		#���z�^�C���i���z�����ʂ�Ȃ��}�X�j
@map_tile[5]=Image.load("image/wall.png")		#��
@map_tile[6]=Image.load("image/planet.png")		#�f��(�X�C�b�`�ɂ���Ēʂꂽ��ʂ�Ȃ�������)
@map_tile[7]=Image.load("image/cometUP.png")		#�a��(���������}�X��)
@map_tile[8]=Image.load("image/cometDOWN.png")		#�a��(���������}�X��)
@map_tile[9]=Image.load("image/cometRIGHT.png")		#�a��(���������}�X��)
@map_tile[10]=Image.load("image/cometLEFT.png")		#�a��(���������}�X��)
@map_tile[11]=Image.load("image/planetkey.png")		#�f���X�C�b�`ON(�f���������X�C�b�`)
@map_tile[12]=Image.load("image/planetswich.png")	#�f���X�C�b�`OFF(�f�����o���X�C�b�`)
@map_tile[13]=Image.load("image/moonkey.png")		#���̓X�C�b�`ON(���𔽔�������X�C�b�`�j
@map_tile[14]=Image.load("image/moonswich.png")		#���̓X�C�b�`OFF(�������ɖ߂��X�C�b�`)
@map_tile[15]=Image.new(40,40,C_DEFAULT)		#�L�����N�^�[(�n��)
@map_tile[16]=Image.new(40,40,C_DEFAULT)		#�L�����N�^�[(��)
@map_tile[17]=Image.new(40,40,C_DEFAULT)		#�L�����N�^�[(���z)
@map_tile[18]=Image.load("image/planet.png")		#���Z�b�g(�f���̉摜�����ɖ߂�)
@map_tile[19]=Image.load("image/planetbreak.png")	#�f�����󂵂����̉摜

#�ϐ��錾
start=0
stageflag=0
result=1
flag=0
mapload=0
gamestart=0
pushflag=0
moonplace=0
solarplace=0
#�X�R�A�A�^�b�N
score=0
point=0
#�ΐ탂�[�h
mooncount=0
earthlife=10
damagecount=0
meteoriteflag=0
#�X�e�[�W�N���A�����Ƃ��̃t���O
clear=1
clearflag=0
#�X�e�[�W
stage=5
world=0
gameset=0
reset=0
#�n���̓������ʂɉf���̂𐧌�
mode=0
#�}�b�v
map=0
limit=0
count=0
#���[�h�I��
gamemode=0
#�`���[�g���A��
page=1
tutorial=0
#class�ϊ�
#�L�����N�^�[
earth=Earth.new
moon=Moon.new
solar=Solar.new
#�Q�[���I�[�o�[
gameover=Gameover.new
#�^�C��
tile=Tile.new
#�V�X�e��
line=Line.new
count=Count.new
#�S������
item=Item.new
moonpiece=Moonpiece.new
meteorite=Meteorite.new
words=Words.new

#�X�C�b�`
planetkey = Sprite.new(300,40,Image.load("image/planetkeymin.png"))
planetswich = Sprite.new(340,40,Image.load("image/planetswichmin.png"))
moonkey = Sprite.new(380,40,Image.load("image/moonkeymin.png"))
moonswich = Sprite.new(420,40,Image.load("image/moonswichmin.png"))

#�摜
cross = Image.load("image/cross.png")
#�w�i
background = Sprite.new(0,0,Image.load("image/Background.png"))
background2 = Sprite.new(0,0,Image.load("image/Background2.png"))

Window.loop do	#�{��
	Sprite.draw(background)	#�w�i�̏o��

	if start==0	#�^�C�g�����
		#�ϐ������Z�b�g
		line.idou
		line.draw
		words.gamestart(gamemode,line)
		#�V�X�e���\��
		if line.y==225		#�Q�[���J�n
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
					#���[�h��
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
		elsif line.y==275	#���[�h�I��
			if Input.key_push?(K_SPACE)
				gamemode+=1
				#�Q�[�����[�h�̍s���߂����ꍇ
				if gamemode>4
					gamemode=1
				end
			end
		elsif line.y==325	#�V�ѕ�
			if Input.key_push?(K_SPACE)
				map=101
				start=2
				stageflag=1
			end
		elsif line.y==375	#�Q�[���I��
			if Input.key_push?(K_SPACE)
				break
			end
		end
	end
	if start==1		 #�Q�[���X�^�[�g
		#�Q�[�����[�h�ʂ̃}�b�v�̌Ăяo��
		if clearflag==1||gamestart==1
			if gamemode==1&&map!=50&&gamestart==0	#�������胂�[�h
				map+=1
			elsif (gamemode==2||gamemode==3)	#���~�b�g���[�h�ƃX�R�A�A�^�b�N
				map=clear*5+Random.rand(5)-4
				#�}�b�v���Ƃ̃��~�b�g�ƃ|�C���g
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
			#���̃��[�h�Ɠ������������Ȃ��悤�ɂ��邽��
			if gamemode==2
				limit=0
			elsif gamemode==3
				point=0
			end
			#�N���A�t���O��0�ɂ��ď������点�Ȃ�
			clearflag=0
			gamestart=0
		end
	end
	if stageflag==1	#�}�b�v�̃��Z�b�g��t���O�̃��Z�b�g
		if map>=1&&map<=100		#�ʏ�map
			file_name="map/map#{map}.yml"		#�}�b�v������
		elsif map>=101&&map<=109	#�`���[�g���A��map
			file_name="map/tutorial#{map-100}.yml"	#�}�b�v������
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
		#�L�����N�^�[�̍��W�w��
		for i in 0..14
			for j in 0..9
				if @map[j][i]==15	#�n���̍��W
					earth.x=i*40+20
					earth.y=j*40+80
				end
				if @map[j][i]==16	#���̍��W
					moonplace=1
					moon.x=i*40+20
					moon.y=j*40+80
				end
				if @map[j][i]==17	#���z�̍��W
					solarplace=1
					solar.x=i*40+20
					solar.y=j*40+80
				end
			end
		end
		if moonplace==0		#�S���������[�h��
			moon.x=0		#���̍��W��0�ɂ���
			moon.y=0
		elsif solarplace==0	#�`���[�g���A����
			solar.x=0		#���z�̍��W��0�ɂ���
			solar.y=0
		end
	end
	if start!=0&&mapload==1&&result!=3	#�Q�[���X�^�[�g���ɂ��ׂẴ��[�h�ɋ��ʂ��鏈��
		Window.draw_tile(20,75,@map,@map_tile ,0 ,0 ,15 ,10)		#�}�b�v�̏o��
		#�^�C��,���~�b�g���J�E���g����class
		if start==1&&((gameover.gameend!=9&&gamemode==3)||gamemode==4)
			count.countup(gamemode)
			count.countdown(gamemode,limit,gameset)
			#class���ŕς�����ϐ������̕ϐ��ɑ������
			limit=count.limit
		end

		#GAMECLEAR�܂���GAMEOVER�𔻒f����Class
		gameover.game(@map,earth,moon,solar,tile.planetoff,count.timeover,start,result,gamemode,earthlife,mooncount,gamestart)
		#class���ŕς�����ϐ������̕ϐ��ɑ������
		earthlife=gameover.earthlife

		if result==2||result==3||(gameover.gameend>=2&&gameover.gameend<=11)
			mode=0				#�L�����N�^�[�𓮂����Ȃ��悤�ɂ��鏈��
		end

		tile.game(@map,earth,moon,solar)	#�X�C�b�`�̏���

		if start==1&&gamemode==4		#�A�C�e����覐΂̕\��
			if item.earthitem!=-1&&item.solaritem!=-1
				item.draw		#�A�C�e����\��
			end
			if item.meteorite==1
				meteorite.draw		#覐΂�\��
			end
		end
		#�L�����N�^�[�o��
		if (result!=3&&gameover.damage==0&&meteorite.damage==0||earthlife==0)||start==2
			earth.draw	#�n�����o��

		else
			if damagecount>=5&&damagecount<=10
				earth.draw	#�n�����o��
			end
			damagecount+=1
			if damagecount==10
				damagecount=0
			end
		end
		if start==2||(result!=3&&gamemode!=4)
			moon.draw	#�����o��
		end
		if (result!=3&&start==1)||(start==2&&(page>=13&&page<=19)||(page>=25&&page<=28)||(page>=47&&page<=53)||(page>=64&&page<=75))
			solar.draw	#���z���o��
		end

		#�L�����N�^�[���ꂼ��̈ړ��錾
		if (start==1&&mode==1&&gameset==0)||(start==2&&(page==11||page==18||page==23||page==27||page==34||page==37||page==45||page==52||page==62||page==73))
			earth.mode(@map,tile.planeton,tile.planetoff,point)
			if (start==1&&gamemode!=4)||start==2	#�S���������[�h�̂Ƃ��ȊO�͓���
				moon.mode(earth,@map,tile.planeton,tile.planetoff,tile.moonon)
			end
			if (start==1&&gamemode!=4||item.solarmode!=1)||(start==2&&(page==18||page==27||page==52||page==73))	#�S���������[�h�Ƒ��z���������Ȃ��Ȃ�A�C�e�����g��ꂽ�Ƃ��ȊO�͓���
				solar.mode(@map,tile.planeton,tile.planetoff,gamemode,start)
			end
		end
		if gameover.gameend>=2&&gameover.gameend<=11&&start==1
			gameover.draw #�Q�[���I�[�o�[���̉��o
		end

		#���[���h,�}�b�v�̌v�Z
		if map%5==1
			world=map/5+1
		elsif map%5==0
			world=map/5
		end
		stage=map%5
		if stage==0
			stage=5
		end

		#�X�C�b�`�^�C���𓥂񂾌�̏���
		if tile.planeton==1&&result<=2&&tile.planetoff==0
			@map_tile[6]=@map_tile[19]
		end
		if tile.moonon==1&&tile.moonoff==1
			tile.moonoff=0
		end
		#�f���i���ז��^�C���j�̉摜�����ƕϐ�����
		if tile.planetoff==1&&result<=2
			@map_tile[6]=@map_tile[18]
			if tile.planeton==1
				tile.planeton=0
			end
		end
	end
	case start	 #�Q�[���̃v���C��
	when 1		 #�Q�[���X�^�[�g
		#�X�e�[�W�N���A�������Ƃ�
		if gameover.gameend==1
			stageflag=1
			clearflag=1
			#�N���A�Ƃ����ϐ��𑝂₷
			if gamemode==2||gamemode==3
				clear+=1
				#�X�R�A�̉��Z
				if gamemode==2
					score=score+point
				end
			end
		end
		if gamemode==1 #�������胂�[�h
			#�}�b�v���s�����肫����
			if (Input.key_down?(K_Z)&&map<50)||(Input.key_down?(K_X)&&map>1)
				stageflag=1
				pushflag+=1
				#�������ŃX�e�[�W�ړ������΂₭�ς܂���
				if pushflag==30&&Input.key_down?(K_Z)&&map<50
					map+=1
					pushflag=20
				elsif pushflag==30&&Input.key_down?(K_X)&&map>1
					map-=1
					pushflag=20
				#�{�^���������ƃX�e�[�W�ړ�����
				elsif Input.key_push?(K_Z)&&map<50
					map+=1
				elsif Input.key_push?(K_X)&&map>1
					map-=1
				end
			else 
				pushflag=0
			end
		elsif gamemode==2 #�X�R�A���[�h
			point=earth.point
			point-=1
		elsif gamemode==4 #�S������
			if gameover.gameend==6||gameover.gameend==8||gameover.gameend==10||gameover.gameend==11			#�Q�[���Z�b�g
				gameset=1
				#�\�����鎞��
				if count.gameset==2
					start=0
					mooncount=0
					meteoriteflag=0
					gameset=0
					item.reset
					count.reset
				end
			else		#�������̏���
				#���̌��Ђ�\��
				if moonpiece.x!=0&&moonpiece.y!=0
					moonpiece.draw
				end
				#�A�C�e���̏���������class
				item.hit(earth,solar)
				item.a(earthlife,mooncount)
				item.syutugen(@map,earth,solar,moonpiece)
				#class���ŕς�����ϐ������̕ϐ��ɑ������
				earthlife=item.earthlife
				mooncount=item.mooncount
				#�A�C�e����覐΂������ꍇ
				if item.meteorite==1
					meteorite.a(@map,earth,solar,moonpiece,item,meteoriteflag)
					meteorite.hit(earth,earthlife)
					meteoriteflag=0
					#class���ŕς�����ϐ������̕ϐ��ɑ������
					earthlife=meteorite.earthlife
					item.meteorite=meteorite.meteorite
				else
					meteoriteflag=1
				end
				if count.moonflag==1
					moonpiece.syutugen(@map,earth,solar,item)	#���ԂŌ��̌��Ђ����Z�b�g����class

				end
				if earth===moonpiece||solar===moonpiece			#���̌��Ђ���������Ƃ��̏���
					if earth===moonpiece
						mooncount+=1
					else
						count.ls+=2
					end
					moonpiece.x=0
					moonpiece.y=0
				end
			end
			#���̌��Ђ̌����s���߂����ꍇ
			if mooncount>10		#���̃��C�t��0�ȉ��̏ꍇ
				mooncount=10
			elsif mooncount<0	#���̃��C�t��10�ȏ�̏ꍇ
				mooncount=0
			end
			#�n���̃��C�t���s���߂����ꍇ
			if earthlife<0		#�n���̃��C�t��0�ȉ��̏ꍇ
				earthlife=0
			elsif earthlife>10	#�n���̃��C�t��10�ȏ�̏ꍇ
				earthlife=10
			end
		end
		case result		#�Q�[���̏��
		when 1 			#�ʏ펞
			if gameover.gameend==0||gameover.gameend==10||gameover.gameend==11
				mode=1			#�L�����N�^�[�̓����𐧌�
				words.play(gamemode,gameset,world,stage,clear,score,earthlife,mooncount,count.h,count.lm,count.rm,count.ls,count.rs) #���Z�b�g�̕\��
			end
			if gamemode!=4		#�S���������[�h����Ȃ��Ƃ�
				if Input.key_push?(K_ESCAPE)		#���Z�b�g���g�p��
					if gameover.gameend==9
						map=0
						clear=1
						limiT=0
						count.limit=0
						clearflag=1
						reset=0
					else
						if gamemode==2		#�X�R�A���[�h
							point-=500
						end
						reset+=1		#���Z�b�g�񐔂��v���X1
					end
					gameover.gameend=0		#�ϐ������Z�b�g
					stageflag=1
					result=1
					mode=1
				end
				if Input.key_push?(K_RETURN)		#���j���[��ʂ֖߂�
					result=2
				end
			end
		when 2			#���߂ă^�C�g���֖߂�ꍇ
			words.menu	#���j���[���̕����̏o�͂���class
			if Input.key_push?(K_ESCAPE)		#�^�C�g���ɖ߂�
				start=0
				count.reset
			end
			if Input.key_push?(K_RETURN)		#�Q�[���ɖ߂�
				result=1
			end
		when 3			#�S�[�������Ƃ�
			words.clear(gamemode,score,reset,count.h,count.lm,count.rm,count.ls,count.rs)	#�N���A�����Ƃ��̕������o�͂���class
			if Input.key_push?(K_RETURN)		#�^�C�g����ʂ�
				start=0
				result=1
			elsif Input.key_push?(K_ESCAPE)		#�Q�[���I��
				break
			end
		end
		if gamemode!=4		#�X�C�b�`�̏󋵂��o�͂���
			if tile.planeton==1&&result<=2
				Sprite.draw(planetkey)		#�摜(�f���X�C�b�`ON)
			elsif tile.planetoff==1&&result<=2
				Sprite.draw(planetswich)	#�摜(�f���X�C�b�`OFF)
			end
			if tile.moonoff==1&&result<=2
				Sprite.draw(moonswich)		#�摜(���̓X�C�b�`ON)
			elsif tile.moonon==1&&result<=2
				Sprite.draw(moonkey)		#�摜(���̓X�C�b�`OFF)
			end
		else
			if item.solarmode==1		#���z�������Ȃ��Ƃ��̏���
				Window.draw(solar.x,solar.y,cross)	#���z�̏�Ɂ~�������
			end
		end
		if clear==11		#���~�b�g���[�h,�^�C���A�^�b�N�̃N���A
			gameover.gameend=0
			result=3
			clear=1
		end
	when 2			#�`���[�g���A��	
		words.tutorial(page) 		#�`���[�g���A���ł̐������Ȃǂ��o�͂���class
		if Input.key_push?(K_ESCAPE)||page==76		#�^�C�g���֖߂�܂��̓X�e�[�W���Z�b�g�܂��̓`���[�g���A���������ɐi�߂���
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
		if tile.planeton==1&&tile.planetoff==0		#�X�C�b�`�^�C���𓥂񂾌�̏���
			@map_tile[6]=@map_tile[19]
		end
		if tile.moonon==1&&tile.moonoff==1
			tile.moonoff=0
		end
		#���֐i��
		if page==11||page==18||page==23||page==27||page==34||page==37||page==45||page==52||page==62||page==73	#�L�����𓮂����Ď��֐i��
			#GAMECLEAR��GAMEOVER�̏���
			if page==34&&earth.x>=300&&earth.x<=340&&earth.y>=310&&earth.y<=312
				page+=1
			elsif gameover.gameend==1
				page+=1
				flag=1
			elsif gameover.gameend>=2&&gameover.gameend<=9
				stageflag=1
			end
		elsif Input.key_push?(K_RETURN)	#ENTER�������Đi��
			page+=1
		end
		if (page==13||page==20||page==25||page==29||page==39||page==47||page==54||page==64)&&flag==1	#map�̌Ăяo��
			map+=1
			flag=0
			stageflag=1
		end
	end
end
