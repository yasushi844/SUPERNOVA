#encoding: Shift_JIS
class Line <Sprite		#���[�h�I��

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

class Count < Sprite		#�^�C��
	attr_accessor :limit,:timeover,:moonflag,:gameset,:h,:lm,:rm,:ls,:rs
	def initialize
		@c=0
		@rs=0
		@ls=0
		@rm=0
		@lm=0
		@h=0
		#�S������
		@limitcount=0
		@gamesetcount=0
	end

	def countup(gamemode)		#�J�E���g�A�b�v
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

	def countdown(gamemode,limit,gameset)		#�J�E���g�_�E��
		@limit=limit
		@gamemode=gamemode
		@gameset=gameset
		@timeover=0
		@moonflag=0
		@c+=1
		if @gamemode==3		#���~�b�g���[�h
			if @c==60
				@limit-=1
				@c=0
			end
			@limitcount=@limit	#���~�b�g�����ԂɎc�莞�Ԃɕς���
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
			if @h<=0&&@lm<=0&&@rm<=0&&@ls<=0&&@rs<=0		#���~�b�g��0�ȉ��ɂȂ�����Q�[���I�[�o�[
				@timeover=1
			end
		elsif @gamemode==4			#�S������
			if @gameset==1			#�����I�����̉�ʕ\���̎���
				@gamesetcount+=1
				if @gamesetcount==180
					@gameset=2
				end
			else
				#���̌��Ђ��o��������܂ł̎���
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
				if @h<=0&&@lm<=0&&@rm<=0&&@ls<=0&&@rs<=0 #�J�E���g��0�ɂȂ�����t���O�𗧂Ă�
					@moonflag=1
					@ls=Random.rand(1)+1+@ls
					@rs=Random.rand(10)
				end
			end
		end
	end
	def reset	#�ϐ������Z�b�g
		@c=0
		@rs=0
		@ls=0
		@rm=0
		@lm=0
		@h=0
		#�S������
		@limitcount=0
		@gamesetcount=0
	end
end

class Words < Sprite		#������\��
	def initialize
		#�����̑傫��
		@hyaku=Font.new(100)
		@nanazyu=Font.new(70)
		@gozyu=Font.new(50)
		@yonzyu=Font.new(40)
		@sanzyu=Font.new(30)
		@nizyu=Font.new(20)
	end
	def gamestart(gamemode,line)		#�X�^�[�g���
		@gamemode=gamemode
		@line=line

		#�^�C�g��
		Window.draw_font(140,20,"SUPER",@hyaku)
		Window.draw_font(250,100,"NOVA",@hyaku)
		Window.draw_font(200,220,"�Q�[���X�^�[�g",@yonzyu)
		Window.draw_font(265,320,"�V�ѕ�",@yonzyu)
		Window.draw_font(265,370,"�����",@yonzyu)

		#�V�X�e�����o��
		Window.draw_font(475,395,"��,�� �Z���N�g�ύX",@nizyu)
		if @line.y!=275
			Window.draw_font(520,375,"SPACE ����",@nizyu)
		else
			Window.draw_font(470,375,"SPACE ���[�h�ύX",@nizyu)
		end

		#���ꂼ��̃��[�h�����o��
		if @gamemode==1
			Window.draw_font(215,270,"�������胂�[�h",@yonzyu)
		elsif @gamemode==2
			Window.draw_font(205,270,"�X�R�A�A�^�b�N",@yonzyu)
		elsif @gamemode==3
			Window.draw_font(215,270,"���~�b�g���[�h",@yonzyu)
		elsif @gamemode==4
			Window.draw_font(255,270,"�S������",@yonzyu)
		else
			Window.draw_font(230,270,"���[�h�I��",@yonzyu)
		end

		if @line.y==225		#�Q�[���X�^�[�g
			if @gamemode==0
				Window.draw_font(180,415,"���[�h�I�����Ă�������",@sanzyu)
				Window.draw_font(195,445,"��,���ŃZ���N�g�ύX",@sanzyu)
			else
				Window.draw_font(180,415,"SPACE�ŃQ�[���X�^�[�g",@sanzyu)
				Window.draw_font(195,445,"��,���ŃZ���N�g�ύX",@sanzyu)
			end
		elsif @line.y==275 	#���[�h�I��
			#���[�h����
			if @gamemode==1
				Window.draw_font(227,415,"�s1�l�p�Q�[���t",@sanzyu)
				Window.draw_font(215,445,"��Փx �y�������z",@sanzyu)
			elsif @gamemode==2
				Window.draw_font(227,415,"�s1�l�p�Q�[���t",@sanzyu)
				Window.draw_font(215,445,"��Փx �y�������z",@sanzyu)
			elsif @gamemode==3
				Window.draw_font(227,415,"�s1�l�p�Q�[���t",@sanzyu)
				Window.draw_font(215,445,"��Փx �y�������z",@sanzyu)
			elsif @gamemode==4
				Window.draw_font(227,415,"�s2�l�p�Q�[���t",@sanzyu)
				Window.draw_font(215,445,"��Փx �y�������z",@sanzyu)
			else
				Window.draw_font(135,415,"SPACE�Ń��[�h�ύX���ł����",@sanzyu)
				Window.draw_font(155,445,"���[�h�͑S����4��ނ����",@sanzyu)
			end
		elsif @line.y==325	#�V�ѕ�
			Window.draw_font(175,415,"��{���[�����w�ׂ܂�",@sanzyu)
			Window.draw_font(115,445,"(�e���[�h�̐����ł͂���܂���)",@sanzyu)
		elsif line.y==375	#�Q�[���I��
			Window.draw_font(205,415,"�Q�[�����I�����܂�",@sanzyu)
			Window.draw_font(145,445,"�{���ɃQ�[�����I�����܂���",@sanzyu)
		end
	end

	def play(gamemode,gameset,world,stage,clear,score,earthlife,mooncount,h,lm,rm,ls,rs)		#�Q�[�����v���C��
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
			Window.draw_font(460,10,"���g���C�@ESC�L�[",@nizyu)
			Window.draw_font(460,40,"�^�C�g���@ENTER�L�[",@nizyu)
			if @gamemode==1 	#�������胂�[�h
				Window.draw_font(30,0,"world#{@world} - stage#{@stage}",@sanzyu)
				Window.draw_font(30,30,"���̃X�e�[�W�ց@Z�L�[\n�O�̃X�e�[�W�ց@X�L�[",@nizyu)
			elsif @gamemode==2	#�X�R�A�A�^�b�N
				Window.draw_font(30,0,"stage#{@clear}/10",@sanzyu)
				Window.draw_font(30,35,"SCORE #{@score}",@yonzyu)
			elsif @gamemode==3	#���~�b�g���[�h
				Window.draw_font(30,0,"stage#{@clear}/10",@sanzyu)
				Window.draw_font(30,35,"LIMIT #{@h}:#{@lm}#{@rm}:#{@ls}#{@rs}",@yonzyu)
			end
		elsif @gamemode==4		#�ΐ탂�[�h
			Window.draw_font(20,0,"�n�����C�t #{@earthlife}/10",@sanzyu)
			Window.draw_font(20,35,"�������܂� #{@mooncount}/10",@sanzyu)
			if @gameset==0
				Window.draw_font(350,0,"���̂����甭���܂�",@sanzyu)
				Window.draw_font(430,35,"#{@h}:#{@lm}#{@rm}:#{@ls}#{@rs}",@yonzyu)
			end
		end
	end

	def menu	#���j���[��
		Window.draw_font(50,10,"�^�C�g���ɖ߂�܂����H",@sanzyu)	
		Window.draw_font(70,40,"�L�^�͎c��܂���",@sanzyu)
		Window.draw_font(460,10,"�͂��@ESC�L�[",@nizyu)
		Window.draw_font(460,40,"�������@ENTER�L�[",@nizyu)
	end

	def clear(gamemode,score,reset,h,lm,rm,ls,rs)		#�Q�[���N���A��
		@gamemode=gamemode
		@score=score
		@reset=reset
		@h=h
		@lm=lm
		@rm=rm
		@ls=ls
		@rs=rs
		Window.draw_font(20,60,"GAME CLEAR",@hyaku)
		if @gamemode==2		#�X�R�A���[�h
			Window.draw_font(160,160,"CLEAR SCORE",@gozyu)
			Window.draw_font(280,215,"#{@score}",@yonzyu)
		elsif @gamemode==3	#���~�b�g���[�h
			Window.draw_font(180,160,"CLEAR LIMIT",@gozyu)
			Window.draw_font(260,215,"#{@h}:#{@lm}#{@rm}:#{@ls}#{@rs}",@yonzyu)
		end
		Window.draw_font(195,260,"���Z�b�g��",@gozyu)
		Window.draw_font(245,315,sprintf("%5d��",@reset),@yonzyu)
=begin		if @gamemode>=3&&@gamemode<=4
		Window.draw_font(155,370,"�����L���O�ց@SPACE�L�[",@sanzyu)
=end		end
		Window.draw_font(140,400,"�^�C�g���ɖ߂�@ENTER�L�[",@sanzyu)
		Window.draw_font(235,430,"�I���@ESC�L�[",@sanzyu)
	end

	def tutorial(page)			#�`���[�g���A����
		@page=page
		# �V�X�e���\��
		if @page!=11&&@page!=18&&@page!=23&&@page!=27&&@page!=34&&@page!=37&&@page!=45&&@page!=52&&@page!=62&&@page!=73
			Window.draw_font(460,10,"���ց@ENTER�L�[",@nizyu)
		else
			Window.draw_font(460,10,"���ց@�~�b�V�����N���A",@nizyu)
		end
		Window.draw_font(460,40,"�^�C�g���ց@ESC�L�[",@nizyu)
		case @page	#�X�g�[���[
		when 1
			Window.draw_font(20,10,"��������N�͐��𑀂邱�Ƃ��ł���\n����ȌN�ɂ���Ăق������Ƃ�����",@sanzyu)
		when 2
			Window.draw_font(20,10,"���̓��e�͐��Ɛ����Ԃ���\n�u�V�������v�����o������",@sanzyu)
		when 3
			Window.draw_font(20,10,"�܂�,����ɂ��鎇�̋��\n���̃Q�[���ł����u�ǁv��",@sanzyu)
		when 4
			Window.draw_font(20,10,"���̐��͐l�X��\n�Z��ł���u�n���v",@sanzyu)
			Window.draw_font(180,240,"��",@yonzyu)
			Window.draw_font(180,315,"��",@yonzyu)
		when 5
			Window.draw_font(20,10,"�E�̐��̓E�T�M������\n�Z��ł���u���v",@sanzyu)
			Window.draw_font(420,240,"��",@yonzyu)
			Window.draw_font(420,315,"��",@yonzyu)
		when 6
			Window.draw_font(20,10,"�n���ƌ��̊֌W��\n2�قǂ���",@sanzyu)
		when 7
			Window.draw_font(20,10,"�P�ڂ́u���͊֌W�v\n���͒n���Ɉ���������",@sanzyu)
		when 8
			Window.draw_font(20,10,"�Q�ڂ́u�V���֌W�v\n�n���ƌ����Ԃ�����u�S�[���v",@sanzyu)
		when 9
			Window.draw_font(20,10,"����ł͒n�������𓮂�����\n�u�V�������v�i�S�[���j�𐶂ݏo����!!",@sanzyu)
		when 10
			Window.draw_font(20,10,"�s��������t\n(���L�[�Œn���𓮂�����)",@sanzyu)
		when 11
			Window.draw_font(20,10,"�s���[���P�t\n(�n���ƌ����Ԃ��悤)",@sanzyu)
		when 12
			Window.draw_font(20,10,"����ŃQ�[���N���A!\n�����܂ł̃��[���͊ȒP����",@sanzyu)
		when 13
			Window.draw_font(20,10,"�������A�n���⌎�ȊO��\n���z�����݂���",@sanzyu)
			Window.draw_font(300,160,"��",@yonzyu)
			Window.draw_font(300,230,"��",@yonzyu)
		when 14
			Window.draw_font(20,10,"���z�̂��Ƃɂ��āc�c\n�����j���[�X���Q����",@sanzyu)
		when 15
			Window.draw_font(20,10,"�P�ڂ͐��𓮂����͂̕���p��\n�n���Ƒ��z���ꏏ�ɓ����Ă��܂�",@sanzyu)
		when 16
			Window.draw_font(20,10,"�Q�ڂ͑��z�̃G�l���M�[������\n�G�ꂽ���𕲁X�ɂ��Ă��܂�",@sanzyu)
		when 17
			Window.draw_font(20,10,"���z���瓦���Ȃ���\n�n���ƌ����Ԃ��Ăق���",@sanzyu)
		when 18
			Window.draw_font(20,10,"�s���[���Q�t\n(���z�ɐG��Ă͂����Ȃ�)",@sanzyu)
		when 19
			Window.draw_font(20,10,"���ꂪ�n���ƌ��Ƒ��z��\n��{�I�ȃ��[����!",@sanzyu)
		#�^�C��
		when 20
			Window.draw_font(20,10,"���́u�^�C���v�ɂ���\n����������",@sanzyu)
		when 21
			Window.draw_font(20,10,"�^�񒆂ɂ���̂�\n�u�n���^�C���v��",@sanzyu)
			Window.draw_font(260,235,"��",@yonzyu)
			Window.draw_font(260,275,"��",@yonzyu)
			Window.draw_font(340,235,"��",@yonzyu)
			Window.draw_font(340,275,"��",@yonzyu)
		when 22
			Window.draw_font(20,10,"�z��������������Ȃ���\n�n�������ʂ�Ȃ��悤�ɂȂ��Ă���",@sanzyu)
		when 23
			Window.draw_font(20,10,"�s���[���R�t\n(�^�C���Ɛ��������͗l�Ȃ�ʂ��)",@sanzyu)
		when 24
			Window.draw_font(20,10,"�����͗l�̐����ʂ��\n���̃��[�����ȒP����",@sanzyu)
		when 25
			Window.draw_font(20,10,"�������u�n���^�C���v�̂ق���\n�u���^�C���v�Ɓu���z�^�C���v������",@sanzyu)
		when 26
			Window.draw_font(20,10,"���ꂼ�ꓯ���͗l�����ʂ�Ȃ�\n����ł͂���Ă݂悤",@sanzyu)
		when 27
			Window.draw_font(20,10,"�s���[���R�t\n(�^�C���Ɛ��������͗l�Ȃ�ʂ��)",@sanzyu)
		when 28
			Window.draw_font(20,10,"���̃X�e�[�W��˔j�����Ȃ�\n�N�̓^�C���}�X�^�[��!!",@sanzyu)
		#�f���X�C�b�`
		when 29
			Window.draw_font(20,10,"���Ɂu�f���X�C�b�`�v�ɂ���\n���������Ă�����",@sanzyu)
		when 30
			Window.draw_font(20,10,"����̒��F�����\n�������u�f���v��",@sanzyu)
			Window.draw_font(220,115,"��",@yonzyu)
			Window.draw_font(380,115,"��",@yonzyu)
			Window.draw_font(260,195,"��",@yonzyu)
			Window.draw_font(300,195,"��",@yonzyu)
			Window.draw_font(340,195,"��",@yonzyu)
		when 31
			Window.draw_font(20,10,"�u�f���v�́u�ǁv�Ɠ��l��\n�ʂ邱�Ƃ��ł��Ȃ�",@sanzyu)
		when 32
			Window.draw_font(20,10,"���ꂶ��S�[���ł��Ȃ����āH\n�������܂邱�Ƃ͂Ȃ�",@sanzyu)
		when 33
			Window.draw_font(20,10,"���`�̘f���X�C�b�`�����邾��\n�����܂Œn����A��Ă��Ă���",@sanzyu)
			Window.draw_font(300,315,"��",@yonzyu)
		when 34
			Window.draw_font(20,10,"�s���[���S�t\n�i�H�H�H�H�H�H�H�j",@sanzyu)
			Window.draw_font(300,315,"��",@yonzyu)
		when 35
			Window.draw_font(20,10,"�f��������������\n���ꂪ�f���X�C�b�`�̗͂�",@sanzyu)
		when 36
			Window.draw_font(20,10,"��͒n���ƌ����Ԃ���\n�S�[�����悤",@sanzyu)
		when 37
			Window.draw_font(20,10,"�s���[���S�t\n�i�f���X�C�b�`�Řf���𑀂�j",@sanzyu)
		when 38
			Window.draw_font(20,10,"���͘f���X�C�b�`�͂Q��ނ���\n����͘f���������X�C�b�`����",@sanzyu)
		when 39
			Window.draw_font(20,10,"�t�ɘf�����Ăяo���X�C�b�`������\n�Ђ��`�̘f���X�C�b�`��",@sanzyu)
			Window.draw_font(100,155,"��",@yonzyu)
			Window.draw_font(100,235,"��",@yonzyu)
		when 40
			Window.draw_font(20,10,"�f���X�C�b�`�͂ƂĂ��֗�����\n����������GAMEOVER�ɂȂ�",@sanzyu)
		when 41
			Window.draw_font(20,10,"����͘f�����Ăяo���ۂ�\n�n���A���A���z�̂����ꂩ��",@sanzyu)
		when 42
			Window.draw_font(20,10,"�f���̏o���ꏊ�ɂ����\n�f���ɂԂ���Ă��܂�",@sanzyu)
		when 43
			Window.draw_font(20,10,"���z�͂Ԃ�Ă��悳��������\n�Ԃꂽ�Ռ��ŋ�͂����󂷂�",@sanzyu)
		when 44
			Window.draw_font(20,10,"�Q��ނ̘f���X�C�b�`�𗘗p����\n���̃X�e�[�W���S�[�����悤",@sanzyu)
		when 45
			Window.draw_font(20,10,"�s���[���T�t\n�i�f���ɂԂ����ȁj",@sanzyu)
		when 46
			Window.draw_font(20,10,"����Řf�����g�����Ȃ����\n���߂łƂ�!!",@sanzyu)
		#�a��
		when 47
			Window.draw_font(20,10,"���́u�a���v�ɂ��Đ��������悤\n���ꂪ�u�a���v��!",@sanzyu)
			Window.draw_font(260,115,"��",@yonzyu)
			Window.draw_font(260,195,"��",@yonzyu)
			Window.draw_font(340,195,"��",@yonzyu)
			Window.draw_font(340,115,"��",@yonzyu)
		when 48
			Window.draw_font(20,10,"�����u�Ԃ킩�邩������Ȃ���\n���̕����ւ��������Ȃ�\n",@sanzyu)
		when 49
			Window.draw_font(20,10,"����ɁA�n���͂��낢����\n���֌W�Ȃ��ʂ�Ȃ�",@sanzyu)
		when 50
			Window.draw_font(20,10,"�n���͐l�Ԃ̊��j�󊈓��ɂ��\n�����͂�����Ă��낭�Ȃ���",@sanzyu)
		when 51
			Window.draw_font(20,10,"�܂��A�a���𗘗p����\n���̃X�e�[�W���S�[�����Ă���",@sanzyu)
		when 52
			Window.draw_font(20,10,"�s���[���U�t\n�i�a���͖��̕������������Ȃ��j",@sanzyu)
		when 53
			Window.draw_font(20,10,"���̃X�e�[�W���N���A����Ƃ�!!\n�����a���͕|���Ȃ���!!",@sanzyu)
		#���̓X�C�b�`
		when 54
			Window.draw_font(20,10,"���Ɂu���̓X�C�b�`�v\n�ɂ��Đ�������",@sanzyu)
		when 55
			Window.draw_font(20,10,"�n���ƌ��ɂ�\n���͊֌W������ƌ�������",@sanzyu)
		when 56
			Window.draw_font(20,10,"���̊֌W���Ӑ}�I�ɕς��邱�Ƃ�\n�\�ȃX�C�b�`�ł���",@sanzyu)
		when 57
			Window.draw_font(20,10,"���̃X�C�b�`�����ꂾ!\n������X�C�b�`�͂Q��ނ���",@sanzyu)
		when 58
			Window.draw_font(20,10,"�O�p�`�������X�C�b�`��\n�n���ƌ��𔽔�������",@sanzyu)
			Window.draw_font(340,355,"��",@yonzyu)
		when 59
			Window.draw_font(20,10,"�ۂ̌`�������X�C�b�`��\n���͊֌W�����ɖ߂��X�C�b�`��",@sanzyu)
			Window.draw_font(260,355,"��",@yonzyu)
		when 60
			Window.draw_font(20,10,"�X�C�b�`�̓��e�͊ȒP����\n�������̑���͓����!",@sanzyu)
		when 61
			Window.draw_font(20,10,"�S���͈ꌩ�ɂ�������!\n���̃X�e�[�W���N���A���悤",@sanzyu)
		when 62
			Window.draw_font(20,10,"�s���[���V�t\n�i���̓X�C�b�`�Ō��𓮂������j",@sanzyu)
		when 63
			Window.draw_font(20,10,"���̃M�~�b�N�𒴂����Ȃ�\n�c��M�~�b�N�͂��ƂP��!!",@sanzyu)
		#覐�
		when 64
			Window.draw_font(20,10,"�Ō�Ɂu覐΁v�ɂ���\n��������",@sanzyu)
		when 65
			Window.draw_font(20,10,"���ꂪ覐΂�!!\n�i�ڋʏĂ�����Ȃ���`�j",@sanzyu)
			Window.draw_font(140,195,"��",@yonzyu)
			Window.draw_font(180,195,"��",@yonzyu)
			Window.draw_font(420,195,"��",@yonzyu)
			Window.draw_font(460,195,"��",@yonzyu)
		when 66
			Window.draw_font(20,10,"覐΂͑��z�Ɠ��l��\n�G�l���M�[���ƂĂ�����",@sanzyu)
		when 67
			Window.draw_font(20,10,"覐΂ƒn���A�����Ԃ�����\n���X�ɂȂ��Ă��܂�",@sanzyu)
		when 68
			Window.draw_font(20,10,"���������z�����͗�O��\n���݂��̃G�l���M�[�������e����",@sanzyu)
		when 69
			Window.draw_font(20,10,"����������Ă��܂�\n������Ȃ��悤�ɂȂ�",@sanzyu)
		when 70
			Window.draw_font(20,10,"�܂�A���z��覐΂��Ԃ��Ă�\n���Q�Ƃ������Ƃ�",@sanzyu)
		when 71
			Window.draw_font(20,10,"���̃X�e�[�W�̓`���[�g���A����\n�Ō�̃X�e�[�W��!",@sanzyu)
		when 72
			Window.draw_font(20,10,"覐΂ɐG��Ȃ��悤��\n���̃X�e�[�W���N���A���悤",@sanzyu)
		when 73
			Window.draw_font(20,10,"�s���[��8�t\n�i�n���A����覐΂Ƃ�����ȁj",@sanzyu)
		when 74
			Window.draw_font(20,10,"�`���[�g���A���N���A���߂łƂ�!!\n�v���C���Ă���Ă��肪�Ƃ�!!",@sanzyu)
		when 75
			Window.draw_font(20,10,"�{�Ԃ͂������炾����\n����΂��Ă�!!",@sanzyu)
		end
	end
end
		