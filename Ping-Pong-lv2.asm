;gaser ashraf
;this program ping pong game
	.286
    .MODEL MEDIUM
    .STACK 64
.DATA
	;your data(varables)

	;screen varibles
	SCREEN_WIDTH                DW                   140H       	;320 PIXELS
	SCREEN_HEIGHT               DW                   0C8h       	;200 PIXELS

	;ball varibles
	BALL_X_ORIGIN               DW                   0a0h       	;(160,100)
	BALL_Y_ORIGIN               DW                   64h        	;
	BALL_X                      dW                   0a0h       	; x postion of the ball
	BALL_Y                      dW                   64h        	; y postion of the ball
	BALL_SPEED_X                dw                   4          	; speed x
	BALL_SPEED_Y                dw                   4          	; speed y
	Original_BALL_SPEED_X       dw                   4          	; speed x
	Original_BALL_SPEED_Y       dw                   4          	; speed y
	BALL_SIZE                   DW                   4          	;4*4=16 PIXELS
	BALL_COLOR                  DB                   1          	;the intial color of the ball

	;paddle varibles
	PADDLE_LEFT_X               DW                   1h         	;paddle left postion x
	PADDLE_LEFT_Y               DW                   4fh        	;paddle left postion y
	PADDLE_LEFT_WIDTH           DW                   6h         	;paddle left width
	PADDLE_LEFT_HEIGHT          DW                   30h        	;paddle left hight
	PADDLE_LEFT_COLOR           DB                   1          	;intial color

	PADDLE_RIGHT_X              DW                   139h       	;paddle right postion x
	PADDLE_RIGHT_Y              DW                   4fh        	;paddle right postion y
	PADDLE_RIGHT_WIDTH          DW                   6h         	;paddle right width
	PADDLE_RIGHT_HEIGHT         DW                   30h        	;paddle right height
	PADDLE_RIGHT_COLOR          DB                   1          	;intial color

	L_PADDLE_SPEED              DW                   8h         	;paddle right height
	R_PADDLE_SPEED              DW                   0ah        	;paddle right height
	ORIGINAL_L_PADDLE_SPEED     DW                   8h         	;paddle right height
	ORIGINAL_R_PADDLE_SPEED     DW                   0ah        	;paddle right height


	;powers varibles
	IS_POWER_FIRE_DRAW_P1       DB                   0h         	;varible determined if there are a fire power in player1 Playground to draw it if 1 draw it if 0 don't draw, it will be (1) after M seconds
	IS_POWER_FIRE_HAVE_P1       DB                   0h         	;varible determined if player 1 have a fire power(one if the player1(Right) pick the fire power) will make the ball مش بتتصد
	IS_POWER_FIRE_HAVE_P1_RIGHT DB                   0h         	;if the player1 pick the fire power then we draw his paddel with red it will make him a red paddle

	IS_POWER_FIRE_DRAW_P2       DB                   0h         	;varible determined if there are a fire power in player2 Playground to draw it if 1 draw it if 0 don't draw, it will be (1) after M seconds
	IS_POWER_FIRE_HAVE_P2       DB                   0h         	;varible determined if player 2 have a fire power(one if the player2(left) pick the fire power) will make the ball مش بتتصد
	IS_POWER_FIRE_HAVE_P2_LEFT  DB                   0h         	;if the player2 pick the fire power then we draw his paddel with red it will make him a red paddle

	POWER_FIRE_X_LEFT_ORIGIN    DW                   0a0h       	;(160,100)
	POWER_FIRE_Y_LEFT_ORIGIN    DW                   64h        	;center for intial
	POWER_FIRE_X_RIGHT_ORIGIN   DW                   0a0h       	;(160,100)
	POWER_FIRE_Y_RIGHT_ORIGIN   DW                   64h        	;center for intial

	POWER_FIRE_X_RIGHT          dW                   0a0h       	; x postion of the fire power
	POWER_FIRE_Y_RIGHT          dW                   64h        	; y postion of the fire power
	POWER_FIRE_SPEED_Y_RIGHT    dw                   0          	; speed y

	POWER_FIRE_X_LEFT           dW                   0a0h       	; x postion of the fire power
	POWER_FIRE_Y_LEFT           dW                   64h        	; y postion of the fire power
	POWER_FIRE_SPEED_X_LEFT     dw                   -5

    
	POWER_FIRE_SPEED_X_RIGHT    dw                   5          	; speed x

	POWER_FIRE_SIZE             DW                   3          	;3*3=9 PIXELS
	POWER_FREEZE_SIZE           DW                   3          	;3*3=9 PIXELS

	IS_POWER_Freeze_DRAW_P1     DB                   0h         	;varible determined if there are a Freeze power in player1 Playground to draw it if 1 draw it if 0 don't draw, it will be (1) after M seconds
	IS_POWER_Freeze_DRAW_P2     DB                   0h         	;varible determined if there are a fire power in player2 Playground to draw it if 1 draw it if 0 don't draw, it will be (1) after M seconds
	ISFROZENP1                  db                   0h         	;detect if player 1 is frozen or not
	ISFROZENP2                  db                   0h         	;detect if player 2 is frozen or not
	FREEZETimep1                dw                   0          	;determine the time that player 1 will be frozen while it
	FREEZETimep2                dw                   0          	;determine the time that player 2 will be frozen while it
	POWER_FREEZE_X_LEFT_ORIGIN  DW                   0a0h       	;(160,100)
	POWER_FREEZE_Y_LEFT_ORIGIN  DW                   64h        	;center for intial
	POWER_FREEZE_X_RIGHT_ORIGIN DW                   0a0h       	;(160,100)
	POWER_FREEZE_Y_RIGHT_ORIGIN DW                   64h        	;center for intial
	POWER_Freeze_X_RIGHT        dW                   0a0h       	; x postion of the Freeze power
	POWER_Freeze_Y_RIGHT        dW                   64h        	; y postion of the Freeze power
	POWER_Freeze_X_LEFT         dW                   0a0h       	; x postion of the Freeze power
	POWER_Freeze_Y_LEFT         dW                   64h        	; y postion of the Freeze power
	POWER_Freeze_SPEED_X_LEFT   dw                   -5
	POWER_Freeze_SPEED_X_RIGHT  dw                   5          	; speed x
	POWER_Freeze_SPEED_Y_RIGHT  dw                   0          	; speed y

	RESPAWNFIRESTATUS           db                   0          	;this determin if we are respawning fire power-up to draw it, while it 2 or 1 the power-up is respawned if it 0 there's no power-up to respawn
	RESPAWNFREEZESTATUS         db                   0          	;this determin if we are respawning Freeze power-up to draw it, while it 2 or 1 the power-up is respawned if it 0 there's no power-up to respawn

	;The game is up to 5 rounds each round consist of 5 points to win the game you need to win 3 rounds
	                            LEFT_SCORE_DER_GAME  DB, 00H    	;number of points in the game
	                            LEFT_SCORE_GAMES     DB, 00H    	;number of games

	                            RIGHT_SCORE_DER_GAME DB, 00H    	;number of points in the game
	                            RIGHT_SCORE_GAMES    DB, 00H    	;number of games
	score                       db                   "Score : $"


	;time varibles
	TIME_FRAME                  db                   0          	; time used to make 1 fps
	Respawn_Time 				dw 0	; it's the time between a cumlative power-ups generation (Respawning) Process
.code
MAIN PROC FAR
	;your code
	                                    MOV   AX, @DATA
	                                    MOV   DS,AX



	                                    mov   ah,0
	                                    mov   al,13h
	                                    int   10h                                	;set graphics mode(320x200)

	MIAN_LOOP:                          
	                                    mov   ah,2Ch
	                                    int   21h                                	;get the time dl->seconds
	                                    cmp   dl,TIME_FRAME                      	; if the same check again
	                                    je    MIAN_LOOP
	                                    mov   TIME_FRAME,dl                      	;update the time
	                                    cmp   Respawn_Time,0                     	;if Respawn_Time is zero we generate a random Power-ups
	                                    jne   KeepGaming
	                                    mov   ax,0                               	;this section to randomize which power-up to respawn
	                                    mov   al,dl
	                                    mov   bl,2
	                                    div   bl
	                                    cmp   ah,0                               	;if 0=> Respawn Fire, if 1=> Respawn Freeze
	                                    je    Fire
	                                    mov   cl,2
	                                    mov   RESPAWNFREEZESTATUS,cl
	                                    call  Respawn_PowerUp_FREEZE
	                                    jmp   KeepGaming
	Fire:                               
	                                    mov   cl,2
	                                    mov   RESPAWNFIRESTATUS,cl
	                                    call  Respawn_PowerUp_FIRE
	                                    jmp   KeepGaming


	KeepGaming:                         
	                                    CALL  CLEAR_SCREEN                       	;1-clear screen
	                                    CALL  MOVE_BALL_PROC                     	;2-move ball
	                                    CALL  DRAW_BALL_PROC                     	;3-draw ball
       

	                                    CALL  MOVE_PADDLE_PROC                   	;4-move paddle
	                                    CALL  DRAW_PADDLE_LEFT_PROC              	;5-draw paddle left
	                                    CALL  DRAW_PADDLE_RIGHT_PROC             	;6-draw paddle right
	                                    CALL  DRAW_CENTER                        	;7-draw center line
	                                    CALL  DRAW_SCORE                         	;8-drawing the score
	                                    dec   Respawn_Time                       	;9-Spend the cooldown respawning time


	;powers procs
	                                    cmp   RESPAWNFREEZESTATUS,0              	;if RESPAWNFREEZESTATUS == 0 we don't respawn Freeze
	                                    je    CHECKFIRESTATUS
	                                    CALL  MOVE_FREEZE_POWER_RIGHT_PROC
	                                    CALL  DRAW_FREEZE_POWER_RIGHT_PROC
	                                    CALL  MOVE_FREEZE_POWER_LEFT_PROC
	                                    CALL  DRAW_FREEZE_POWER_LEFT_PROC
	                                    CALL  COUNTFREEZEP1                      	;if the palyer 1 is frozen we here spend the freeze time of that player
	                                    CALL  COUNTFREEZEP2                      	;if the palyer 2 is frozen we here spend the freeze time of that player
	                                    jmp   MIAN_LOOP


	CHECKFIRESTATUS:                    
	                                    cmp   RESPAWNFIRESTATUS,0                	;if RESPAWNFIRESTATUS == 0 we don't respawn Fire
	                                    je    MIAN_LOOP
	                                    CALL  MOVE_FIRE_POWER_RIGHT_PROC
	                                    CALL  DRAW_FIRE_POWER_RIGHT_PROC
	                                    CALL  MOVE_FIRE_POWER_LEFT_PROC
	                                    CALL  DRAW_FIRE_POWER_LEFT_PROC

	                                    jmp   MIAN_LOOP



MAIN ENDP
DRAW_BALL_PROC PROC near

	                                    mov   cx,BALL_X                          	;Column
	                                    mov   dx,BALL_Y                          	;Row

	;this loop is draw the ball(size*size time o(n^2))
	draw_Ball:                          
	                                    mov   ah,0ch                             	;Draw Pixel Command
	                                    mov   al,BALL_COLOR                      	;Pixel color
	                                    mov   bh,0                               	; page number
	                                    int   10h                                	; draw an pixel
	                                    inc   cx                                 	;cx++
	                                    mov   ax,cx
	                                    sub   ax,BALL_X
	                                    cmp   ax,BALL_SIZE
	                                    jne   draw_Ball                          	;if(cx-xpos==size) then go endl else go new col
	                                    mov   cx,BALL_X
	                                    inc   dx
	                                    mov   ax,dx
	                                    sub   ax,BALL_Y
	                                    cmp   ax,BALL_SIZE                       	;if(finsh all rows then ret else go up with new row)
	                                    jne   draw_Ball
	                                    ret
DRAW_BALL_PROC ENDP
RESTART_BALL_PROC PROC near

	;0-set the point to the player
	                                    cmp   BALL_X,0a0h                        	;if the ball fall in LEFT side then player Right get 1 point
	                                    jl    POINT_TO_RIGHT
	                                    mov   al,LEFT_SCORE_DER_GAME
	                                    inc   al
	                                    cmp   al,6                               	;if he reached point number 6 then he need to add 1 game and start a new شوط
	                                    je    INCREASE_ONE_GAME_LEFT
	                                    jmp   INCREASE_ONE_POINT_LEFT

	INCREASE_ONE_GAME_LEFT:             
	                                    mov   al,LEFT_SCORE_GAMES
	                                    inc   al
	                                    mov   LEFT_SCORE_GAMES,al                	;add new game to player l
	                                    mov   al,0
	                                    mov   LEFT_SCORE_DER_GAME,al             	;reset the score
	                                    mov   RIGHT_SCORE_DER_GAME,al            	;reset the score
	                                    jmp   RESTART_BALL_PROC_REST

	INCREASE_ONE_POINT_LEFT:            
	                                    mov   LEFT_SCORE_DER_GAME,al
	                                    jmp   RESTART_BALL_PROC_REST

	POINT_TO_RIGHT:                     
	                                    mov   al,RIGHT_SCORE_DER_GAME
	                                    inc   al
	                                    cmp   al,6
	                                    je    INCREASE_ONE_GAME_RIGHT
	                                    jmp   INCREASE_ONE_POINT_RIGHT

	INCREASE_ONE_GAME_RIGHT:            
	                                    mov   al,RIGHT_SCORE_GAMES
	                                    inc   al
	                                    mov   RIGHT_SCORE_GAMES,al
	                                    mov   al,0
	                                    mov   RIGHT_SCORE_DER_GAME,al
	                                    mov   LEFT_SCORE_DER_GAME,al
	                                    jmp   RESTART_BALL_PROC_REST

	INCREASE_ONE_POINT_RIGHT:           
	                                    mov   RIGHT_SCORE_DER_GAME,al



	RESTART_BALL_PROC_REST:             


	;1-rest all powers
	                                    CALL  REST_FIRE_POWER_ALL
	;this proc draw the ball at the center
	                                    mov   ax,BALL_X_ORIGIN
	                                    mov   BALL_X,ax
	                                    mov   ax,BALL_Y_ORIGIN
	                                    mov   BALL_Y,ax
	                                    mov   ax,Original_BALL_SPEED_X
	                                    mov   BALL_SPEED_X,ax
	                                    mov   ax,Original_BALL_SPEED_Y
	                                    mov   BALL_SPEED_Y,ax
	                                    mov   ax,0
	                                    mov   RESPAWNFIRESTATUS,al
	                                    mov   RESPAWNFREEZESTATUS,al

	;we will detect if a ball velocity is in the -ve direction if so we will switch it to +ve direction
	CheckBallXDirection:                
	                                    mov   ax,BALL_SPEED_X
	                                    cmp   ax,0
	                                    jl    NegBallSpeedX
	CheckBallYDirection:                
	                                    mov   ax,BALL_SPEED_Y
	                                    cmp   ax,0
	                                    jl    NegBallSpeedY
	;we devide the current second on no of modes (4) to get the mode
	RandomizeBallDirection:             
	                                    mov   ax,0
	                                    mov   al,TIME_FRAME
	                                    mov   bl,4
	                                    div   bl
	;if reminder == 0
	                                    cmp   ah,0
	                                    je    Random315degree
	;if reminder == 1
	                                    cmp   ah,1
	                                    je    Random45degree
	;if reminder == 2
	                                    cmp   ah,2
	                                    je    Random135degree
	;if reminder == 3
	                                    cmp   ah,3
	                                    je    Random225degree
	                                    ret

	NegBallSpeedX:                      neg   BALL_SPEED_X
	                                    jmp   CheckBallXDirection

	NegBallSpeedY:                      neg   BALL_SPEED_Y
	                                    jmp   RandomizeBallDirection

	;x is +ve , Y is +ve
	Random315degree:                    
	                                    ret
	;x is +ve , Y is -ve
	Random45degree:                     
	                                    neg   BALL_SPEED_Y
	                                    ret
	;x is -ve , Y is -ve
	Random135degree:                    
	                                    neg   BALL_SPEED_Y
	                                    neg   BALL_SPEED_X
	                                    ret
	;x is -ve , Y is +ve
	Random225degree:                    
	                                    neg   BALL_SPEED_X
	                                    ret

RESTART_BALL_PROC ENDP
CLEAR_SCREEN PROC near
	;clear screen by draw an black one
	                                    mov   cx,BALL_X                          	;Column
	                                    mov   dx,BALL_Y                          	;Row

	                                    mov   ax,0600h
	                                    mov   bh,0
	                                    mov   cx,0
	                                    mov   dx,184FH
	                                    int   10h

	                                    ret
CLEAR_SCREEN ENDP

MOVE_BALL_PROC PROC near
        
	                                    mov   cx,BALL_X                          	;get the current xpos
	                                    add   cx,BALL_SPEED_X                    	;add the current xpos to speed
	                                    cmp   cx,0                               	; the ball is out the grid
	                                    jg    neg_horz_z                         	;if x>0 it's safe (not out the grid)
	                                    jmp   REST_POS                           	;if(x<0 then the player lose so rest the pos to the center)
	neg_horz_z:                         
	                                    add   cx,BALL_SIZE                       	;if(xpos+size>width then need to rest pos because the player los)
	                                    cmp   cx,SCREEN_WIDTH                    	;
	                                    jl    neg_horz_w                         	;if(xpos+size<width) then safe move
	                                    jmp   REST_POS
	neg_horz_w:                         

	;then y boundires if the ball hit them need to negtive the speed
	                                    mov   dx,BALL_Y
	                                    add   dx,BALL_SPEED_Y
	                                    cmp   dx,0
	                                    jg    neg_vir_z
	                                    neg   BALL_SPEED_Y                       	;if(y<0 then sy*=-1)

	neg_vir_z:                          
	                                    add   dx,BALL_SIZE
	                                    cmp   dx,SCREEN_HEIGHT
	                                    jl    neg_vir_w
	                                    neg   BALL_SPEED_Y                       	;if(y>H then sy*=-1)

	neg_vir_w:                          


	                                    mov   cx,BALL_X                          	;mov ball(x+=sx,y+=sp)
	                                    add   cx,BALL_SPEED_X
	                                    mov   dx,BALL_Y
	                                    add   dx,BALL_SPEED_Y
	                                    mov   BALL_X,cx
	                                    mov   BALL_Y,dx
        
	;check if the ball collusion with left paddel
	; maxx1 > minx2 && minx1 < maxx2 && maxy1 > miny2 && miny1 < maxy2
	; BALL_X + BALL_SIZE > PADDLE_LEFT_X && BALL_X < PADDLE_LEFT_X + PADDLE_WIDTH
	; && BALL_Y + BALL_SIZE > PADDLE_LEFT_Y && BALL_Y < PADDLE_LEFT_Y + PADDLE_HEIGHT
        
	                                    mov   ax,BALL_X
	                                    add   ax,BALL_SIZE
	                                    cmp   ax,PADDLE_LEFT_X
	                                    jng   CHECK_RIGHT_PADDEL
	                                    mov   ax,PADDLE_LEFT_X
	                                    add   ax,PADDLE_LEFT_WIDTH
	                                    cmp   ax,BALL_X
	                                    jng   CHECK_RIGHT_PADDEL
	                                    mov   ax ,BALL_Y
	                                    add   ax,BALL_SIZE
	                                    cmp   ax,PADDLE_LEFT_Y
	                                    jng   CHECK_RIGHT_PADDEL
	                                    mov   ax,PADDLE_LEFT_Y
	                                    add   ax,PADDLE_LEFT_HEIGHT
	                                    cmp   ax,BALL_Y
	                                    jng   CHECK_RIGHT_PADDEL
	; if all this true then
	;check if is a red ball ( the other player played an fire ball if true so you can't تصده الا لو معاك paddle red)
	                                    cmp   BALL_COLOR,4
	                                    jne   NO_RED_BALL_RIGHT_HAVE
                                             
	; if you reached here then and red ball come on your paddle
	                                    cmp   PADDLE_LEFT_COLOR,4
	                                    je    RED_BALL_RED_PADDLE_LEFT           	; if u reached have and red paddle then you can تصدخ

	                                    mov   al,1                               	;else you cant تصدها so rest the ball
	                                    mov   BALL_COLOR,al                      	;set the ball color with the normal
	                                    jmp   REST_POS

	NO_RED_BALL_RIGHT_HAVE:             
	                                    neg   BALL_SPEED_X
	                                    CALL  DirectTheBallLeft
	; if he have an red paddle
	                                    cmp   PADDLE_LEFT_COLOR,4
	                                    jne   CHECK_RIGHT_PADDEL
	                                    mov   al,4                               	;1-make the ball red
	                                    mov   BALL_COLOR,al
	                                    mov   al,1                               	;2-return paddle left color
	                                    mov   PADDLE_LEFT_COLOR,al
	                                    jmp   CHECK_RIGHT_PADDEL

	RED_BALL_RED_PADDLE_LEFT:                                                    	; you reached here if you have red paddle and the ball was red so you can تصدها عادي
	                                    neg   BALL_SPEED_X
	                                    CALL  DirectTheBallLeft
	                                    mov   al,1                               	;1-make the ball red
	                                    mov   BALL_COLOR,al
	                                    mov   al,1                               	;2-return paddle left color
	                                    mov   PADDLE_LEFT_COLOR,al
	;check if the ball collusion with right paddel
        
	CHECK_RIGHT_PADDEL:                 

	                                    mov   ax,BALL_X
	                                    add   ax,BALL_SIZE
	                                    cmp   ax,PADDLE_RIGHT_X
	                                    jng   NOT_RIGHT_PADDLE
	                                    mov   ax,PADDLE_RIGHT_X
	                                    add   ax,PADDLE_RIGHT_WIDTH
	                                    cmp   ax,BALL_X
	                                    jng   NOT_RIGHT_PADDLE
	                                    mov   ax ,BALL_Y
	                                    add   ax,BALL_SIZE
	                                    cmp   ax,PADDLE_RIGHT_Y
	                                    jng   NOT_RIGHT_PADDLE
	                                    mov   ax,PADDLE_RIGHT_Y
	                                    add   ax,PADDLE_RIGHT_HEIGHT
	                                    cmp   ax,BALL_Y
	                                    jng   NOT_RIGHT_PADDLE
	; if all this true(the ball hit the right paddle) then
                                  
	                                    cmp   BALL_COLOR,4                       	;check if is a red ball ( the other player played an fire ball if true so you can't تصده ورستر )
	                                    jne   NO_RED_BALL_LEFT_HAVE              	; if not red
	; if you reached here then and red ball come on your paddle
	                                    cmp   PADDLE_RIGHT_COLOR,4               	;if ur paddle is red نقدر تصد
	                                    je    RED_BALL_RED_PADDLE_RIGHT          	; if u reached have and red paddle then you can تصدخ


	                                    mov   al,1
	                                    mov   BALL_COLOR,al                      	;set the ball color with the normal
	                                    jmp   REST_POS
	NO_RED_BALL_LEFT_HAVE:              
	                                    neg   BALL_SPEED_X
	                                    CALL  DirectTheBallLeft
                                  
	; if he have an red paddle
	                                    cmp   PADDLE_RIGHT_COLOR,4
	                                    jne   NOT_RIGHT_PADDLE
	                                    mov   al,4                               	;1-make the ball red
	                                    mov   BALL_COLOR,al
	                                    mov   al,1                               	;2-return paddle left color
	                                    mov   PADDLE_RIGHT_COLOR,al
	                                    jmp   NOT_RIGHT_PADDLE

	RED_BALL_RED_PADDLE_RIGHT:                                                   	; you reached here if you have red paddle and the ball was red so you can تصدها عادي
	                                    neg   BALL_SPEED_X
	                                    CALL  DirectTheBallLeft
	                                    mov   al,1                               	;1-make the ball red
	                                    mov   BALL_COLOR,al
	                                    mov   al,1                               	;2-return paddle left color
	                                    mov   PADDLE_RIGHT_COLOR,al

                                  

	NOT_RIGHT_PADDLE:                   
	                                    ret
	REST_POS:                           
	                                    CALL  RESTART_BALL_PROC
	                                    ret
MOVE_BALL_PROC ENDP

DirectTheBallLeft proc near
	;if ballY > paddleY + paddle_height/3 && => if this condition is false then the ball hits the upper part
	;ballY < paddleY + 2*paddle_height/3 => if this condition is false then the ball hits the lower part
	;then the ball hits the middle part of paddle
	;so the speed in Y axis is 0 to get 0 degree in direction
	                                    mov   ax,PADDLE_LEFT_HEIGHT
	                                    mov   bl,3
	                                    div   bl
	                                    add   ax,PADDLE_LEFT_Y
	                                    cmp   BALL_Y,ax
	                                    jl    HitTheUpperPartLeft
	                                    mov   ax,PADDLE_LEFT_HEIGHT
	                                    mov   bl,3
	                                    div   bl
	                                    mov   bl,2
	                                    mul   bl
	                                    add   ax,PADDLE_LEFT_Y
	                                    cmp   BALL_Y,ax
	                                    jg    HitTheLowerPartLeft
	                                    mov   ax,0
	                                    mov   BALL_SPEED_Y,ax
	                                    ret

	HitTheUpperPartLeft:                
	                                    cmp   BALL_SPEED_Y,0
	                                    je    SwitchspeedToneg45degreeLeft

	                                    mov   ax,Original_BALL_SPEED_X
	                                    cmp   BALL_SPEED_Y,ax
	                                    je    SwitchspeedToneg30degreeLeft

	                                    mov   ax,Original_BALL_SPEED_X
	                                    neg   ax
	                                    cmp   BALL_SPEED_Y,ax
	                                    je    SwitchspeedTo30degreeLeft

	                                    mov   ax,0
	                                    mov   BALL_SPEED_Y,ax
	                                    ret

	HitTheLowerPartLeft:                
	                                    cmp   BALL_SPEED_Y,0
	                                    je    SwitchspeedTo45degreeLeft

	                                    mov   ax,Original_BALL_SPEED_X
	                                    cmp   BALL_SPEED_Y,ax
	                                    je    SwitchspeedToneg30degreeLeft

	                                    mov   ax,Original_BALL_SPEED_X
	                                    neg   ax
	                                    cmp   BALL_SPEED_Y,ax
	                                    je    SwitchspeedTo30degreeLeft

	                                    mov   ax,0
	                                    mov   BALL_SPEED_Y,ax
	                                    ret

	SwitchspeedToneg45degreeLeft:       
	                                    mov   ax,Original_BALL_SPEED_X
	                                    mov   BALL_SPEED_Y,ax
	                                    ret
	SwitchspeedTo45degreeLeft:          
	                                    mov   ax,Original_BALL_SPEED_X
	                                    mov   BALL_SPEED_Y,ax
	                                    neg   BALL_SPEED_Y
	                                    ret
	SwitchspeedToneg30degreeLeft:       
	                                    mov   ax,Original_BALL_SPEED_X
	                                    mov   bl,2
	                                    div   bl
	                                    mov   BALL_SPEED_Y,ax
	                                    ret
	SwitchspeedTo30degreeLeft:          
	                                    mov   ax,Original_BALL_SPEED_X
	                                    mov   bl,2
	                                    div   bl
	                                    mov   BALL_SPEED_Y,ax
	                                    neg   BALL_SPEED_Y
	                                    ret

	                                    ret
DirectTheBallLeft ENDP

DirectTheBallRight proc near

	;if ballY > paddleY + paddle_height/3 && => if this condition is false then the ball hits the upper part
	;ballY < paddleY + 2*paddle_height/3 => if this condition is false then the ball hits the lower part
	;then the ball hits the middle part of paddle
	;so the speed in Y axis is 0 to get 0 degree in direction
	                                    mov   ax,PADDLE_RIGHT_HEIGHT
	                                    mov   bl,3
	                                    div   bl
	                                    add   ax,PADDLE_RIGHT_Y
	                                    cmp   BALL_Y,ax
	                                    jl    HitTheUpperPartRight
	                                    mov   ax,PADDLE_Right_HEIGHT
	                                    mov   bl,3
	                                    div   bl
	                                    mov   bl,2
	                                    mul   bl
	                                    add   ax,PADDLE_Right_Y
	                                    cmp   BALL_Y,ax
	                                    jg    HitTheLowerPartRight
	                                    mov   ax,0
	                                    mov   BALL_SPEED_Y,ax
	                                    ret

	HitTheUpperPartRight:               
	                                    cmp   BALL_SPEED_Y,0
	                                    je    SwitchspeedToneg45degreeRight

	                                    mov   ax,Original_BALL_SPEED_X
	                                    cmp   BALL_SPEED_Y,ax
	                                    je    SwitchspeedToneg30degreeRight

	                                    mov   ax,Original_BALL_SPEED_X
	                                    neg   ax
	                                    cmp   BALL_SPEED_Y,ax
	                                    je    SwitchspeedTo30degreeRight

	                                    mov   ax,0
	                                    mov   BALL_SPEED_Y,ax
	                                    ret

	HitTheLowerPartRight:               
	                                    cmp   BALL_SPEED_Y,0
	                                    je    SwitchspeedTo45degreeRight

	                                    mov   ax,Original_BALL_SPEED_X
	                                    cmp   BALL_SPEED_Y,ax
	                                    je    SwitchspeedToneg30degreeRight

	                                    mov   ax,Original_BALL_SPEED_X
	                                    neg   ax
	                                    cmp   BALL_SPEED_Y,ax
	                                    je    SwitchspeedTo30degreeRight

	                                    mov   ax,0
	                                    mov   BALL_SPEED_Y,ax
	                                    ret

	SwitchspeedToneg45degreeRight:      
	                                    mov   ax,Original_BALL_SPEED_X
	                                    mov   BALL_SPEED_Y,ax
	                                    neg   BALL_SPEED_Y
	                                    ret
	SwitchspeedTo45degreeRight:         
	                                    mov   ax,Original_BALL_SPEED_X
	                                    mov   BALL_SPEED_Y,ax
	                                    ret
	SwitchspeedToneg30degreeRight:      
	                                    mov   ax,Original_BALL_SPEED_X
	                                    mov   bl,2
	                                    div   bl
	                                    mov   BALL_SPEED_Y,ax
	                                    neg   BALL_SPEED_Y
	                                    ret
	SwitchspeedTo30degreeRight:         
	                                    mov   ax,Original_BALL_SPEED_X
	                                    mov   bl,2
	                                    div   bl
	                                    mov   BALL_SPEED_Y,ax
	                                    ret

	                                    ret
DirectTheBallRight ENDP


DRAW_PADDLE_LEFT_PROC PROC near
	                                    mov   cx,PADDLE_LEFT_X                   	;Column
	                                    mov   dx,PADDLE_LEFT_Y                   	;Row

	draw_paddle_left:                   
	                                    mov   ah,0ch                             	;Draw Pixel Command
	                                    mov   al,PADDLE_LEFT_COLOR               	;Pixel color
	                                    mov   bh,0                               	; page number
	                                    int   10h                                	; draw an pixel
	                                    inc   cx                                 	;cx++
	                                    mov   ax,cx
	                                    sub   ax,PADDLE_LEFT_X                   	;if(cx-xpos==size) then go endl
	                                    cmp   ax,PADDLE_LEFT_WIDTH
	                                    jne   draw_paddle_left
	                                    mov   cx,PADDLE_LEFT_X
	                                    inc   dx
	                                    mov   ax,dx
	                                    sub   ax,PADDLE_LEFT_Y
	                                    cmp   ax,PADDLE_LEFT_HEIGHT
	                                    jne   draw_paddle_left
	                                    ret
DRAW_PADDLE_LEFT_PROC ENDP
DRAW_PADDLE_RIGHT_PROC PROC near
	                                    mov   cx,PADDLE_RIGHT_X                  	;Column
	                                    mov   dx,PADDLE_RIGHT_Y                  	;Row

	draw_paddle_right:                  
	                                    mov   ah,0ch                             	;Draw Pixel Command
                        
	                                    mov   al,PADDLE_RIGHT_COLOR              	;Pixel color
	                                    mov   bh,0                               	; page number
	                                    int   10h                                	; draw an pixel
	                                    inc   cx                                 	;cx++
	                                    mov   ax,cx
	                                    sub   ax,PADDLE_RIGHT_X                  	;if(cx-xpos==size) then go endl
	                                    cmp   ax,PADDLE_RIGHT_WIDTH
	                                    jne   draw_paddle_right
	                                    mov   cx,PADDLE_RIGHT_X
	                                    inc   dx
	                                    mov   ax,dx
	                                    sub   ax,PADDLE_RIGHT_Y
	                                    cmp   ax,PADDLE_RIGHT_HEIGHT
	                                    jne   draw_paddle_right
	                                    ret
DRAW_PADDLE_RIGHT_PROC ENDP

MOVE_PADDLE_PROC PROC near

	;check wheater key pressed if not exit
	                                    mov   ah,01h
	                                    int   16h
	                                    jnz   EXIT                               	;if not exit
	                                    ret
	EXIT:                               
	                                    mov   ah,00h
	                                    int   16h                                	; get the current key pressed
	                                    cmp   ah,11h                             	;up arrow
	                                    jne   NO_UP_LEFT_PADDEL                  	; if not up arrow go check other

	                                    mov   dx,PADDLE_LEFT_Y
	                                    sub   dx,L_PADDLE_SPEED
	                                    cmp   dx,0                               	;if pos-sy<0
	                                    jg    SAFE_MOVE_UP                       	; if > then safe move
	                                    mov   PADDLE_LEFT_Y,1                    	;if < set it at 0
	                                    jmp   NO_UP_LEFT_PADDEL
	SAFE_MOVE_UP:                       
	                                    mov   PADDLE_LEFT_Y,dx


	NO_UP_LEFT_PADDEL:                  
	                                    cmp   ah,1fh                             	; down arrow
	                                    jnz   NO_DOWN_LEFT_PADDEL
	                                    mov   dx,PADDLE_LEFT_Y
	                                    add   dx,L_PADDLE_SPEED
	                                    add   dx,PADDLE_LEFT_HEIGHT
	                                    cmp   dx,SCREEN_HEIGHT
    
	                                    jl    SAFE_MOVE_DOWN
	                                    mov   dx,SCREEN_HEIGHT
	                                    sub   dx,PADDLE_LEFT_HEIGHT              	;if > height set it at top down
	                                    dec   dx
	                                    mov   PADDLE_LEFT_Y,dx
	                                    jmp   NO_DOWN_LEFT_PADDEL
	SAFE_MOVE_DOWN:                     
	                                    sub   dx,PADDLE_LEFT_HEIGHT
	                                    mov   PADDLE_LEFT_Y,dx
	NO_DOWN_LEFT_PADDEL:                



	                                    cmp   ah,48h                             	;up arrow
	                                    jne   NO_UP_RIGHT_PADDEL                 	; if not up arrow go check other

	                                    mov   dx,PADDLE_RIGHT_Y
	                                    sub   dx,R_PADDLE_SPEED
	                                    cmp   dx,0                               	;if pos-sy<0
	                                    jg    SAFE_MOVE_UP_RIGHT                 	; if > then safe move
	                                    mov   PADDLE_RIGHT_Y,1                   	;if < set it at 0
	                                    jmp   NO_UP_RIGHT_PADDEL
	SAFE_MOVE_UP_RIGHT:                 
	                                    mov   PADDLE_RIGHT_Y,dx


	NO_UP_RIGHT_PADDEL:                 
	                                    cmp   ah,50h
	                                    jnz   NO_DOWN_RIGHT_PADDEL
	                                    mov   dx,PADDLE_RIGHT_Y
	                                    add   dx,R_PADDLE_SPEED
	                                    add   dx,PADDLE_RIGHT_HEIGHT
	                                    cmp   dx,SCREEN_HEIGHT
    
	                                    jl    SAFE_MOVE_DOWN_RIGHT
	                                    mov   dx,SCREEN_HEIGHT
	                                    sub   dx,PADDLE_RIGHT_HEIGHT             	;if > height set it at top down
	                                    dec   dx
	                                    mov   PADDLE_RIGHT_Y,dx
	                                    jmp   NO_DOWN_RIGHT_PADDEL
	SAFE_MOVE_DOWN_RIGHT:               
	                                    sub   dx,PADDLE_RIGHT_HEIGHT
	                                    mov   PADDLE_RIGHT_Y,dx
	NO_DOWN_RIGHT_PADDEL:               

    
	                                    ret
MOVE_PADDLE_PROC ENDP

DRAW_CENTER PROC near
	                                    mov   cx,0a0h                            	;Column
	                                    mov   bx,0                               	; rows
	increase_WITH_NO_DRAW:              
	                                    inc   bx
	draw_center_oa:                     
	                                    mov   ax,bx
	                                    mov   cx,20
	                                    mov   dx,0
	                                    DIV   cx                                 	;ax/20 = ax=ax/20 dx=ax%20
	                                    cmp   dx,0                               	;if(dx%20==0) then inc with no draw
	                                    je    increase_WITH_NO_DRAW
	                                    mov   dx,bx
	                                    mov   cx,0a0h
	                                    mov   ah,0ch                             	;Draw Pixel Command
	                                    mov   al,1                               	;Pixel color
	                                    mov   bh,0                               	; page number
	                                    int   10h                                	; draw an pixel
	                                    inc   bx
	                                    cmp   bx,SCREEN_HEIGHT
	                                    jg    END_DRAW_CENTER
	                                    jmp   draw_center_oa
	END_DRAW_CENTER:                    
	                                    ret
DRAW_CENTER ENDP


DRAW_FIRE_POWER_RIGHT_PROC PROC near

    
	                                    cmp   IS_POWER_FIRE_DRAW_P1,1
	                                    jne   EXIT_WITH_NO_DRAW_FIRE
	                                    mov   cx,POWER_FIRE_X_RIGHT
	                                    mov   dx,POWER_FIRE_Y_RIGHT
	draw_fire:                          
	                                    mov   ah,0ch                             	;Draw Pixel Command
	                                    mov   al,4                               	;Pixel color
	                                    mov   bh,0                               	; page number
	                                    int   10h                                	; draw an pixel
	                                    inc   cx                                 	;cx++
	                                    mov   ax,cx
	                                    sub   ax,POWER_FIRE_X_RIGHT
	                                    cmp   ax,POWER_FIRE_SIZE
	                                    jne   draw_fire                          	;if(cx-xpos==size) then go endl else go new col
	                                    mov   cx,POWER_FIRE_X_RIGHT
	                                    inc   dx
	                                    mov   ax,dx
	                                    sub   ax,POWER_FIRE_Y_RIGHT
	                                    cmp   ax,POWER_FIRE_SIZE                 	;if(finsh all rows then ret else go up with new row)
	                                    jne   draw_fire

	EXIT_WITH_NO_DRAW_FIRE:             
	                                    ret
DRAW_FIRE_POWER_RIGHT_PROC ENDP

MOVE_FIRE_POWER_RIGHT_PROC PROC near
	                                    cmp   IS_POWER_FIRE_DRAW_P1,1
	                                    jne   CROSSEXIT_MOVE_FIRE_POWER_PROC
	                                    mov   cx,POWER_FIRE_X_RIGHT              	;get the current xpos of the power
	                                    add   cx,POWER_FIRE_SPEED_X_RIGHT        	;add the current xpos to speed of the power
	                                    add   cx,POWER_FIRE_SIZE
	                                    cmp   cx,SCREEN_WIDTH                    	; the power is out the grid
	                                    jl    SAFE_MOVE_FIRE                     	;if x>w it's out the grid
	                                    mov   al,0                               	;if reach here then the power out of the gird so remove it
	                                    mov   IS_POWER_FIRE_DRAW_P1,al           	;by set the bool IS_POWER_FIRE_DRAW_P1 =0 then exit
	                                    mov   al,RESPAWNFIRESTATUS
	                                    dec   al
	                                    mov   RESPAWNFIRESTATUS,al               	;we decrease the status by 1 expressing that one of the power-ups is out the window
	                                    jmp   EXIT_MOVE_FIRE_POWER_PROC          	;if(x<w then safe mov)
	SAFE_MOVE_FIRE:                     
	                                    mov   cx,POWER_FIRE_X_RIGHT              	;mov ball(x+=sx,y+=sp)
	                                    add   cx,POWER_FIRE_SPEED_X_RIGHT
	                                    mov   dx,POWER_FIRE_Y_RIGHT
	                                    add   dx,POWER_FIRE_SPEED_Y_RIGHT
	                                    mov   POWER_FIRE_X_RIGHT,cx
	                                    mov   POWER_FIRE_Y_RIGHT,dx
	CROSSEXIT_MOVE_FIRE_POWER_PROC:     
	                                    cmp   IS_POWER_FIRE_DRAW_P1,1
	                                    jne   EXIT_MOVE_FIRE_POWER_PROC
	;check if the fire collusion with left paddel
	; maxx1 > minx2 && minx1 < maxx2 && maxy1 > miny2 && miny1 < maxy2
	; BALL_X + BALL_SIZE > PADDLE_LEFT_X && BALL_X < PADDLE_LEFT_X + PADDLE_WIDTH
	; && BALL_Y + BALL_SIZE > PADDLE_LEFT_Y && BALL_Y < PADDLE_LEFT_Y + PADDLE_HEIGHT
        
	                                    mov   ax,POWER_FIRE_X_RIGHT
	                                    add   ax,POWER_FIRE_SIZE
	                                    cmp   ax,PADDLE_RIGHT_X
	                                    jng   EXIT_MOVE_FIRE_POWER_PROC
	                                    mov   ax,PADDLE_RIGHT_X
	                                    add   ax,PADDLE_RIGHT_WIDTH
	                                    cmp   ax,POWER_FIRE_X_RIGHT
	                                    jng   EXIT_MOVE_FIRE_POWER_PROC
	                                    mov   ax ,POWER_FIRE_Y_RIGHT
	                                    add   ax,POWER_FIRE_SIZE
	                                    cmp   ax,PADDLE_RIGHT_Y
	                                    jng   EXIT_MOVE_FIRE_POWER_PROC
	                                    mov   ax,PADDLE_RIGHT_Y
	                                    add   ax,PADDLE_RIGHT_HEIGHT
	                                    cmp   ax,POWER_FIRE_Y_RIGHT
	                                    jng   EXIT_MOVE_FIRE_POWER_PROC
	;if all this true(the power hit the paddle) then
	                                    mov   al,0                               	;first remove the power
	                                    mov   IS_POWER_FIRE_DRAW_P1,al
	                                    mov   al,RESPAWNFIRESTATUS
	                                    dec   al
	                                    mov   RESPAWNFIRESTATUS,al               	;we decrease the status by 1 expressing that one of the paddle got the power-up
	                                    mov   al,1
	                                    mov   IS_POWER_FIRE_HAVE_P1,al
	                                    mov   al,1
	                                    mov   IS_POWER_FIRE_HAVE_P1_RIGHT,al
	                                    mov   PADDLE_RIGHT_COLOR,4               	;set the paddle with red color
	                              
	;check if the ball collusion with right paddel
                  
	EXIT_MOVE_FIRE_POWER_PROC:          
	                                    ret
MOVE_FIRE_POWER_RIGHT_PROC ENDP

DRAW_FIRE_POWER_LEFT_PROC PROC near

    
	                                    cmp   IS_POWER_FIRE_DRAW_P2,1
	                                    jne   EXIT_WITH_NO_DRAW_FIRE_L
	                                    mov   cx,POWER_FIRE_X_LEFT
	                                    mov   dx,POWER_FIRE_Y_LEFT
	draw_fire_L:                        
	                                    mov   ah,0ch                             	;Draw Pixel Command
	                                    mov   al,4                               	;Pixel color
	                                    mov   bh,0                               	; page number
	                                    int   10h                                	; draw an pixel
	                                    inc   cx                                 	;cx++
	                                    mov   ax,cx
	                                    sub   ax,POWER_FIRE_X_LEFT
	                                    cmp   ax,POWER_FIRE_SIZE
	                                    jne   draw_fire_L                        	;if(cx-xpos==size) then go endl else go new col
	                                    mov   cx,POWER_FIRE_X_LEFT
	                                    inc   dx
	                                    mov   ax,dx
	                                    sub   ax,POWER_FIRE_Y_LEFT
	                                    cmp   ax,POWER_FIRE_SIZE                 	;if(finsh all rows then ret else go up with new row)
	                                    jne   draw_fire_L

	EXIT_WITH_NO_DRAW_FIRE_L:           
	                                    ret
DRAW_FIRE_POWER_LEFT_PROC ENDP

MOVE_FIRE_POWER_LEFT_PROC PROC near
	                                    cmp   IS_POWER_FIRE_DRAW_P2,1
	                                    jne   CROSSEXIT_MOVE_FIRE_POWER_LEFT_PROC
	                                    mov   cx,POWER_FIRE_X_LEFT               	;get the current xpos of the power
	                                    add   cx,POWER_FIRE_SPEED_X_RIGHT        	;add the current xpos to speed of the power
	                                    add   cx,POWER_FIRE_SIZE
	                                    cmp   cx,0                               	; the power is out the grid
	                                    jg    SAFE_MOVE_FIRE_L                   	;if x>w it's out the grid
	                                    mov   al,0                               	;if reach here then the power out of the gird so remove it
	                                    mov   IS_POWER_FIRE_DRAW_P2,al           	;by set the bool IS_POWER_FIRE_DRAW_P1 =0 then exit
	                                    mov   al,RESPAWNFIRESTATUS
	                                    dec   al
	                                    mov   RESPAWNFIRESTATUS,al               	;we decrease the status by 1 expressing that one of the power-ups is out the window
	                                    jmp   EXIT_MOVE_FIRE_POWER_LEFT_PROC     	;if(x<w then safe mov)
	SAFE_MOVE_FIRE_L:                   
	                                    mov   cx,POWER_FIRE_X_LEFT               	;mov ball(x+=sx,y+=sp)
	                                    add   cx,POWER_FIRE_SPEED_X_LEFT
	                                    mov   dx,POWER_FIRE_Y_LEFT
	                                    add   dx,POWER_FIRE_SPEED_Y_RIGHT
	                                    mov   POWER_FIRE_X_LEFT,cx
	                                    mov   POWER_FIRE_Y_LEFT,dx
	CROSSEXIT_MOVE_FIRE_POWER_LEFT_PROC:
	                                    cmp   IS_POWER_FIRE_DRAW_P2,1
	                                    jne   EXIT_MOVE_FIRE_POWER_LEFT_PROC
	;check if the fire collusion with left paddel
	; maxx1 > minx2 && minx1 < maxx2 && maxy1 > miny2 && miny1 < maxy2
	; BALL_X + BALL_SIZE > PADDLE_LEFT_X && BALL_X < PADDLE_LEFT_X + PADDLE_WIDTH
	; && BALL_Y + BALL_SIZE > PADDLE_LEFT_Y && BALL_Y < PADDLE_LEFT_Y + PADDLE_HEIGHT
        
	                                    mov   ax,POWER_FIRE_X_LEFT
	                                    add   ax,POWER_FIRE_SIZE
	                                    cmp   ax,PADDLE_LEFT_X
	                                    jng   EXIT_MOVE_FIRE_POWER_LEFT_PROC
	                                    mov   ax,PADDLE_LEFT_X
	                                    add   ax,PADDLE_LEFT_WIDTH
	                                    cmp   ax,POWER_FIRE_X_LEFT
	                                    jng   EXIT_MOVE_FIRE_POWER_LEFT_PROC
	                                    mov   ax ,POWER_FIRE_Y_LEFT
	                                    add   ax,POWER_FIRE_SIZE
	                                    cmp   ax,PADDLE_LEFT_Y
	                                    jng   EXIT_MOVE_FIRE_POWER_LEFT_PROC
	                                    mov   ax,PADDLE_LEFT_Y
	                                    add   ax,PADDLE_LEFT_HEIGHT
	                                    cmp   ax,POWER_FIRE_Y_LEFT
	                                    jng   EXIT_MOVE_FIRE_POWER_LEFT_PROC
	;if all this true(the power hit the paddle) then
	                                    mov   al,0                               	;first remove the power
	                                    mov   IS_POWER_FIRE_DRAW_P2,al
	                                    mov   al,RESPAWNFIRESTATUS
	                                    dec   al
	                                    mov   RESPAWNFIRESTATUS,al               	;we decrease the status by 1 expressing that one of the paddles got a power-up
	                                    mov   al,1
	                                    mov   IS_POWER_FIRE_HAVE_P2,al
	                                    mov   al,1
	                                    mov   IS_POWER_FIRE_HAVE_P2_LEFT,al
	                                    mov   PADDLE_LEFT_COLOR,4                	;set the paddle with red color
	                              
	;check if the ball collusion with right paddel
                  
	EXIT_MOVE_FIRE_POWER_LEFT_PROC:     
	                                    ret
MOVE_FIRE_POWER_LEFT_PROC ENDP

MOVE_Freeze_POWER_RIGHT_PROC PROC near
	                                    cmp   IS_POWER_Freeze_DRAW_P1,1
	                                    jne   CrossFREEZERIGHTJUMP
	                                    mov   cx,POWER_FREEZE_X_RIGHT            	;get the current xpos of the power
	                                    add   cx,POWER_FREEZE_SPEED_X_RIGHT      	;add the current xpos to speed of the power
	                                    add   cx,POWER_FREEZE_SIZE
	                                    cmp   cx,SCREEN_WIDTH                    	; the power is out the grid
	                                    jl    SAFE_MOVE_FREEZE                   	;if x>w it's out the grid
	                                    mov   al,0                               	;if reach here then the power out of the gird so remove it
	                                    mov   IS_POWER_FREEZE_DRAW_P1,al         	;by set the bool IS_POWER_FREEZE_DRAW_P1 =0 then exit
	                                    mov   al,RESPAWNFREEZESTATUS
	                                    dec   al
	                                    mov   RESPAWNFREEZESTATUS,al             	;we decrease the status by 1 expressing that one of the power-ups is out the window
	                                    jmp   EXIT_MOVE_FREEZE_POWER_PROC        	;if(x<w then safe mov)
	SAFE_MOVE_FREEZE:                   
	                                    mov   cx,POWER_FREEZE_X_RIGHT            	;mov ball(x+=sx,y+=sp)
	                                    add   cx,POWER_FREEZE_SPEED_X_RIGHT
	                                    mov   dx,POWER_FREEZE_Y_RIGHT
	                                    add   dx,POWER_FREEZE_SPEED_Y_RIGHT
	                                    mov   POWER_FREEZE_X_RIGHT,cx
	                                    mov   POWER_FREEZE_Y_RIGHT,dx

	CrossFREEZERIGHTJUMP:               cmp   IS_POWER_Freeze_DRAW_P1,1
	                                    jne   EXIT_MOVE_FREEZE_POWER_PROC
	;check if the FREEZE collusion with left paddel
	; maxx1 > minx2 && minx1 < maxx2 && maxy1 > miny2 && miny1 < maxy2
	; BALL_X + BALL_SIZE > PADDLE_LEFT_X && BALL_X < PADDLE_LEFT_X + PADDLE_WIDTH
	; && BALL_Y + BALL_SIZE > PADDLE_LEFT_Y && BALL_Y < PADDLE_LEFT_Y + PADDLE_HEIGHT
        
	                                    mov   ax,POWER_FREEZE_X_RIGHT
	                                    add   ax,POWER_FREEZE_SIZE
	                                    cmp   ax,PADDLE_RIGHT_X
	                                    jng   EXIT_MOVE_FREEZE_POWER_PROC
	                                    mov   ax,PADDLE_RIGHT_X
	                                    add   ax,PADDLE_RIGHT_WIDTH
	                                    cmp   ax,POWER_FREEZE_X_RIGHT
	                                    jng   EXIT_MOVE_FREEZE_POWER_PROC
	                                    mov   ax ,POWER_FREEZE_Y_RIGHT
	                                    add   ax,POWER_FREEZE_SIZE
	                                    cmp   ax,PADDLE_RIGHT_Y
	                                    jng   EXIT_MOVE_FREEZE_POWER_PROC
	                                    mov   ax,PADDLE_RIGHT_Y
	                                    add   ax,PADDLE_RIGHT_HEIGHT
	                                    cmp   ax,POWER_FREEZE_Y_RIGHT
	                                    jng   EXIT_MOVE_FREEZE_POWER_PROC
	;if all this true(the power hit the paddle) then
	                                    mov   al,0                               	;first remove the power
	                                    mov   IS_POWER_FREEZE_DRAW_P1,al
	                                    mov   al,RESPAWNFREEZESTATUS
	                                    dec   al
	                                    mov   RESPAWNFREEZESTATUS,al             	;we decrease the status by 1 expressing that one of the paddles got a power-up
	                                    mov   FREEZETimep2,0ffh                  	;set the freeze time
	;Freeze the other player by changing his color and dividing his speed by 2
	                                    mov   al,1
	                                    mov   ISFROZENP2,al
	                                    mov   ax,L_PADDLE_SPEED
	                                    mov   bl,2
	                                    div   bl
	                                    mov   ah,0
	                                    mov   L_PADDLE_SPEED,ax
	                                    mov   PADDLE_LEFT_COLOR,0bh              	;set the paddle with Light Blue color
	                              
	;check if the ball collusion with right paddel
	EXIT_MOVE_FREEZE_POWER_PROC:        
	                                    ret
MOVE_FREEZE_POWER_RIGHT_PROC ENDP

DRAW_FREEZE_POWER_RIGHT_PROC PROC near

    
	                                    cmp   IS_POWER_FREEZE_DRAW_P1,1
	                                    jne   EXIT_WITH_NO_DRAW_FREEZE
	                                    mov   cx,POWER_FREEZE_X_RIGHT
	                                    mov   dx,POWER_FREEZE_Y_RIGHT
	draw_FREEZE:                        
	                                    mov   ah,0ch                             	;Draw Pixel Command
	                                    mov   al,0bh                             	;Pixel color
	                                    mov   bh,0                               	; page number
	                                    int   10h                                	; draw an pixel
	                                    inc   cx                                 	;cx++
	                                    mov   ax,cx
	                                    sub   ax,POWER_FREEZE_X_RIGHT
	                                    cmp   ax,POWER_FREEZE_SIZE
	                                    jne   draw_FREEZE                        	;if(cx-xpos==size) then go endl else go new col
	                                    mov   cx,POWER_FREEZE_X_RIGHT
	                                    inc   dx
	                                    mov   ax,dx
	                                    sub   ax,POWER_FREEZE_Y_RIGHT
	                                    cmp   ax,POWER_FREEZE_SIZE               	;if(finsh all rows then ret else go up with new row)
	                                    jne   draw_FREEZE

	EXIT_WITH_NO_DRAW_FREEZE:           
	                                    ret
DRAW_FREEZE_POWER_RIGHT_PROC ENDP

MOVE_FREEZE_POWER_LEFT_PROC PROC near
	                                    cmp   IS_POWER_FREEZE_DRAW_P2,1
	                                    jne   CrossFREEZELEFTJUMP
	                                    mov   cx,POWER_FREEZE_X_LEFT             	;get the current xpos of the power
	                                    add   cx,POWER_FREEZE_SPEED_X_RIGHT      	;add the current xpos to speed of the power
	                                    add   cx,POWER_FREEZE_SIZE
	                                    cmp   cx,0                               	; the power is out the grid
	                                    jg    SAFE_MOVE_FREEZE_L                 	;if x>w it's out the grid
	                                    mov   al,0                               	;if reach here then the power out of the gird so remove it
	                                    mov   IS_POWER_FREEZE_DRAW_P2,al         	;by set the bool IS_POWER_FREEZE_DRAW_P1 =0 then exit
	                                    mov   al,RESPAWNFREEZESTATUS
	                                    dec   al
	                                    mov   RESPAWNFREEZESTATUS,al             	;we decrease the status by 1 expressing that one of the power-ups is out the window
	                                    jmp   EXIT_MOVE_FREEZE_POWER_LEFT_PROC   	;if(x<w then safe mov)
	SAFE_MOVE_FREEZE_L:                 
	                                    mov   cx,POWER_FREEZE_X_LEFT             	;mov ball(x+=sx,y+=sp)
	                                    add   cx,POWER_FREEZE_SPEED_X_LEFT
	                                    mov   dx,POWER_FREEZE_Y_LEFT
	                                    add   dx,POWER_FREEZE_SPEED_Y_RIGHT
	                                    mov   POWER_FREEZE_X_LEFT,cx
	                                    mov   POWER_FREEZE_Y_LEFT,dx

	CrossFREEZELEFTJUMP:                cmp   IS_POWER_FREEZE_DRAW_P2,1
	                                    jne   EXIT_MOVE_FREEZE_POWER_LEFT_PROC
	;check if the FREEZE collusion with left paddel
	; maxx1 > minx2 && minx1 < maxx2 && maxy1 > miny2 && miny1 < maxy2
	; BALL_X + BALL_SIZE > PADDLE_LEFT_X && BALL_X < PADDLE_LEFT_X + PADDLE_WIDTH
	; && BALL_Y + BALL_SIZE > PADDLE_LEFT_Y && BALL_Y < PADDLE_LEFT_Y + PADDLE_HEIGHT
        
	                                    mov   ax,POWER_FREEZE_X_LEFT
	                                    add   ax,POWER_FREEZE_SIZE
	                                    cmp   ax,PADDLE_LEFT_X
	                                    jng   EXIT_MOVE_FREEZE_POWER_LEFT_PROC
	                                    mov   ax,PADDLE_LEFT_X
	                                    add   ax,PADDLE_LEFT_WIDTH
	                                    cmp   ax,POWER_FREEZE_X_LEFT
	                                    jng   EXIT_MOVE_FREEZE_POWER_LEFT_PROC
	                                    mov   ax ,POWER_FREEZE_Y_LEFT
	                                    add   ax,POWER_FREEZE_SIZE
	                                    cmp   ax,PADDLE_LEFT_Y
	                                    jng   EXIT_MOVE_FREEZE_POWER_LEFT_PROC
	                                    mov   ax,PADDLE_LEFT_Y
	                                    add   ax,PADDLE_LEFT_HEIGHT
	                                    cmp   ax,POWER_FREEZE_Y_LEFT
	                                    jng   EXIT_MOVE_FREEZE_POWER_LEFT_PROC
	;if all this true(the power hit the paddle) then
	                                    mov   al,0                               	;first remove the power
	                                    mov   IS_POWER_FREEZE_DRAW_P2,al
	                                    mov   al,RESPAWNFREEZESTATUS
	                                    dec   al
	                                    mov   RESPAWNFREEZESTATUS,al             	;we decrease the status by 1 expressing that one of the paddles got a power-up
	                                    mov   FREEZETimep1,0ffh                  	;set the freeze time
	;Freeze the other player by changing his color and dividing his speed by 2
	                                    mov   al,1
	                                    mov   ISFROZENP1,al
	                                    mov   ax,R_PADDLE_SPEED
	                                    mov   bl,2
	                                    div   bl
	                                    mov   ah,0
	                                    mov   R_PADDLE_SPEED,ax
	                                    mov   PADDLE_RIGHT_COLOR,0bh             	;set the paddle with red color
	                              
	;check if the ball collusion with right paddel
                  
	EXIT_MOVE_FREEZE_POWER_LEFT_PROC:   
	                                    ret
MOVE_FREEZE_POWER_LEFT_PROC ENDP

DRAW_FREEZE_POWER_LEFT_PROC PROC near

    
	                                    cmp   IS_POWER_FREEZE_DRAW_P2,1
	                                    jne   EXIT_WITH_NO_DRAW_FREEZE_L
	                                    mov   cx,POWER_FREEZE_X_LEFT
	                                    mov   dx,POWER_FREEZE_Y_LEFT
	draw_FREEZE_L:                      
	                                    mov   ah,0ch                             	;Draw Pixel Command
	                                    mov   al,0bh                             	;Pixel color
	                                    mov   bh,0                               	; page number
	                                    int   10h                                	; draw an pixel
	                                    inc   cx                                 	;cx++
	                                    mov   ax,cx
	                                    sub   ax,POWER_FREEZE_X_LEFT
	                                    cmp   ax,POWER_FREEZE_SIZE
	                                    jne   draw_FREEZE_L                      	;if(cx-xpos==size) then go endl else go new col
	                                    mov   cx,POWER_FREEZE_X_LEFT
	                                    inc   dx
	                                    mov   ax,dx
	                                    sub   ax,POWER_FREEZE_Y_LEFT
	                                    cmp   ax,POWER_FREEZE_SIZE               	;if(finsh all rows then ret else go up with new row)
	                                    jne   draw_FREEZE_L

	EXIT_WITH_NO_DRAW_FREEZE_L:         
	                                    ret
DRAW_FREEZE_POWER_LEFT_PROC ENDP

COUNTFREEZEP1 proc near
	                                    cmp   ISFROZENP1,0                       	;we check if player 1 is frozen, if 0=> we exit
	                                    je    RETURNFREEZEP1
	                                    cmp   FREEZETimep1,0                     	;we check if the freeze time is spent, if !0=> we decrease the time if 0=> we restore the paddle speed and color
	                                    jne   FINISHFREEZEP1

	                                    mov   ax,R_PADDLE_SPEED
	                                    mov   bl,2
	                                    mul   bl
	                                    mov   R_PADDLE_SPEED,ax
	                                    mov   ISFROZENP1,ah
	                                    mov   al,1
	                                    mov   PADDLE_RIGHT_COLOR,al
	                                    ret

	FINISHFREEZEP1:                     
	                                    dec   FREEZETimep1
	                                    ret

	RETURNFREEZEP1:                     
	                                    ret
COUNTFREEZEP1 ENDP

COUNTFREEZEP2 proc near
	                                    cmp   ISFROZENP2,0                       	;we check if player 2 is frozen, if 0=> we exit
	                                    je    RETURNFREEZEP2
	                                    cmp   FREEZETimep2,0                     	;we check if the freeze time is spent, if !0=> we decrease the time if 0=> we restore the paddle speed and color
	                                    jne   FINISHFREEZEP2

	                                    mov   ax,L_PADDLE_SPEED
	                                    mov   bl,2
	                                    mul   bl
	                                    mov   L_PADDLE_SPEED,ax
	                                    mov   ISFROZENP2,ah
	                                    mov   al,1
	                                    mov   PADDLE_LEFT_COLOR,al
	                                    ret

	FINISHFREEZEP2:                     
	                                    dec   FREEZETimep2
	                                    ret

	RETURNFREEZEP2:                     
	                                    ret
COUNTFREEZEP2 ENDP

REST_FIRE_POWER_ALL PROC near
	;rest colors of paddels and ball
	                                    mov   al,1                               	;normal color
	                                    MOV   PADDLE_RIGHT_COLOR,al
	                                    mov   PADDLE_LEFT_COLOR,al
	                                    mov   BALL_COLOR,al
	                                    mov   al,0
	                                    mov   IS_POWER_FIRE_DRAW_P1,al
	                                    mov   IS_POWER_FIRE_DRAW_P2,al
	                                    mov   IS_POWER_FIRE_HAVE_P1,al
	                                    mov   IS_POWER_FIRE_HAVE_P2,al
	                                    mov   IS_POWER_FIRE_HAVE_P2_LEFT,al
	                                    mov   IS_POWER_FIRE_HAVE_P1_RIGHT,al
	                                    mov   ax,ORIGINAL_L_PADDLE_SPEED
	                                    mov   L_PADDLE_SPEED,ax
	                                    mov   ax,ORIGINAL_R_PADDLE_SPEED
	                                    mov   R_PADDLE_SPEED,ax
	                                    ret
REST_FIRE_POWER_ALL ENDP

Respawn_PowerUp_FIRE PROC near
	                                    pusha

	                                    mov   dh,01h
	                                    mov   cl,dl
	                                    mov   Respawn_Time,dx                    	;Here we reset Respawn_Time with a random value
	                                    cmp   IS_POWER_FIRE_DRAW_P2,1            	;if power-up for player 2 we keep gaming and generate no more power up
	                                    je    DontRespawn
	                                    cmp   IS_POWER_FIRE_DRAW_P1,1            	;if power-up for player  we keep gaming and generate no more power up
	                                    je    DontRespawn
	                                    mov   al,1h                              	;unless we reset them to 1 for drawing a new power-up
	                                    mov   IS_POWER_FIRE_DRAW_P1,al
	                                    mov   IS_POWER_FIRE_DRAW_P2,al

	;in this section we reset the power-up position
	                                    mov   ax,POWER_FIRE_X_RIGHT_ORIGIN
	                                    mov   POWER_FIRE_X_RIGHT,ax
	                                    mov   ax,POWER_FIRE_X_LEFT_ORIGIN
	                                    mov   POWER_FIRE_X_Left,ax
	                                    mov   ax,cx
	                                    mov   cl,2
	                                    mul   cl
	                                    cmp   al,0c8h
	                                    jl    SetCenter
	                                    mov   ah,0
	                                    mov   POWER_FIRE_Y_RIGHT,ax
	                                    mov   POWER_FIRE_Y_LEFT,ax
	                                    jmp   DontRespawn

	SetCenter:                          
	                                    mov   ax ,POWER_FIRE_X_RIGHT_ORIGIN
	                                    mov   POWER_FIRE_Y_RIGHT,ax
	                                    mov   ax,POWER_FIRE_Y_LEFT_ORIGIN
	                                    mov   POWER_FIRE_Y_LEFT,ax
	DontRespawn:                        
	                                    popa
	                                    ret
Respawn_PowerUp_FIRE ENDP


Respawn_PowerUp_FREEZE PROC near
	                                    pusha

	                                    mov   dh,01h
	                                    mov   cl,dl
	                                    mov   Respawn_Time,dx                    	;Here we reset Respawn_Time with a random value
	                                    cmp   IS_POWER_FREEZE_DRAW_P2,1          	;if power-up for player 2 we keep gaming and generate no more power up
	                                    je    DontRespawnFREEZE
	                                    cmp   IS_POWER_FREEZE_DRAW_P1,1          	;if power-up for player  we keep gaming and generate no more power up
	                                    je    DontRespawnFREEZE
	                                    mov   al,1h                              	;unless we reset them to 1 for drawing a new power-up
	                                    mov   IS_POWER_FREEZE_DRAW_P1,al
	                                    mov   IS_POWER_FREEZE_DRAW_P2,al

	;in this section we reset the power-up position
	                                    mov   ax,POWER_FREEZE_X_RIGHT_ORIGIN
	                                    mov   POWER_FREEZE_X_RIGHT,ax
	                                    mov   ax,POWER_FREEZE_X_LEFT_ORIGIN
	                                    mov   POWER_FREEZE_X_Left,ax
	                                    mov   ax,cx
	                                    mov   cl,2
	                                    mul   cl
	                                    cmp   al,0c8h
	                                    jl    SetCenterFREEZE
	                                    mov   ah,0
	                                    mov   POWER_FREEZE_Y_RIGHT,ax
	                                    mov   POWER_FREEZE_Y_LEFT,ax
	                                    jmp   DontRespawnFREEZE

	SetCenterFREEZE:                    
	                                    mov   ax ,POWER_FREEZE_X_RIGHT_ORIGIN
	                                    mov   POWER_FREEZE_Y_RIGHT,ax
	                                    mov   ax,POWER_FREEZE_Y_LEFT_ORIGIN
	                                    mov   POWER_FREEZE_Y_LEFT,ax
	DontRespawnFREEZE:                  
	                                    popa
	                                    ret
Respawn_PowerUp_FREEZE ENDP


DRAW_SCORE PROC NEAR
	                                    MOV   AH,02H                             	;move cursor to X,Y position
	                                    MOV   DL,0                               	;X-position of the message
	                                    MOV   DH,1                               	;move the cursor to the new line
	                                    INT   10H

	                                    MOV   AH,09H
	                                    MOV   DX,offset score                    	;print the first line
	                                    INT   21H
                                

	                                    mov   dl,LEFT_SCORE_GAMES
	                                    add   dl,30h                             	;
	                                    mov   ah,2
	                                    int   21h

								
	                                    mov   dl," "
	                                    mov   ah,2
	                                    int   21h

	                                    mov   dl,LEFT_SCORE_DER_GAME
	                                    add   dl,30h                             	;
	                                    mov   ah,2
	                                    int   21h



	                                    MOV   AH,02H                             	;move cursor to X,Y position
	                                    MOV   DL,28                              	;X-position of the message
	                                    MOV   DH,1                               	;move the cursor to the new line
	                                    INT   10H

	                                    MOV   AH,09H
	                                    MOV   DX,offset score                    	;print the first line
	                                    INT   21H
                                

	                                    mov   dl,RIGHT_SCORE_GAMES
	                                    add   dl,30h                             	;
	                                    mov   ah,2
	                                    int   21h

								
	                                    mov   dl," "
	                                    mov   ah,2
	                                    int   21h

	                                    mov   dl,RIGHT_SCORE_DER_GAME
	                                    add   dl,30h                             	;
	                                    mov   ah,2
	                                    int   21h
	                                    ret
DRAW_SCORE ENDP

    END MAIN
