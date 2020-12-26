;gaser ashraf
;this program ping pong game
    .MODEL SMALL
    .STACK 64
.DATA
	;your data(varables)
	SCREEN_WIDTH          DW 140H	;320 PIXELS
	SCREEN_HEIGHT         DW 0C8h	;200 PIXELS
	BALL_X_ORIGIN         DW 0a0h	;(160,100)
	BALL_Y_ORIGIN         DW 64h 	;
	BALL_X                dW 0a0h	; x postion of the ball
	BALL_Y                dW 64h 	; y postion of the ball
	BALL_SPEED_X          dw 4   	; speed x
	BALL_SPEED_Y          dw 4   	; speed y
	Original_BALL_SPEED_X dw 4   	; speed x
	Original_BALL_SPEED_Y dw 4   	; speed y
	BALL_SIZE             DW 4   	;4*4=16 PIXELS

	PADDLE_LEFT_X         DW 1h  	;paddle left postion x
	PADDLE_LEFT_Y         DW 4fh 	;paddle left postion y
	PADDLE_LEFT_WIDTH     DW 6h  	;paddle left width
	PADDLE_LEFT_HEIGHT    DW 30h 	;paddle left hight

	PADDLE_RIGHT_X        DW 139h	;paddle right postion x
	PADDLE_RIGHT_Y        DW 4fh 	;paddle right postion y
	PADDLE_RIGHT_WIDTH    DW 6h  	;paddle right width
	PADDLE_RIGHT_HEIGHT   DW 30h 	;paddle right height

	L_PADDLE_SPEED        DW 8h  	;paddle right height
	R_PADDLE_SPEED        DW 0bh 	;paddle right height

    TIME_FRAME db 0; time used to make 1 fps
.code
MAIN PROC FAR
	;your code
	                              MOV  AX, @DATA
	                              MOV  DS,AX



	                              mov  ah,0
	                              mov  al,13h
	                              int  10h                          	;set graphics mode(320x200)

	MIAN_LOOP:                    
	                              mov  ah,2Ch
	                              int  21h                          	;get the time dl->seconds
	                              cmp  dl,TIME_FRAME                	; if the same check again
	                              je   MIAN_LOOP
	                              mov  TIME_FRAME,dl                	;update the time
	                              CALL CLEAR_SCREEN                 	;1-clear screen
	                              CALL MOVE_BALL_PROC               	;2-move ball
	                              CALL DRAW_BALL_PROC               	;3-draw ball
       

	                              CALL MOVE_PADDLE_PROC             	;4-move paddle
	                              CALL DRAW_PADDLE_LEFT_PROC        	;5-draw paddle left
	                              CALL DRAW_PADDLE_RIGHT_PROC       	;6-draw paddle right
	                              CALL DRAW_CENTER                  	;7-draw center line
	                              jmp  MIAN_LOOP

    



MAIN ENDP
DRAW_BALL_PROC PROC near

	                              mov  cx,BALL_X                    	;Column
	                              mov  dx,BALL_Y                    	;Row

	;this loop is draw the ball(size*size time o(n^2))
	draw_Ball:                    
	                              mov  ah,0ch                       	;Draw Pixel Command
	                              mov  al,1                         	;Pixel color
	                              mov  bh,0                         	; page number
	                              int  10h                          	; draw an pixel
	                              inc  cx                           	;cx++
	                              mov  ax,cx
	                              sub  ax,BALL_X
	                              cmp  ax,BALL_SIZE
	                              jne  draw_Ball                    	;if(cx-xpos==size) then go endl else go new col
	                              mov  cx,BALL_X
	                              inc  dx
	                              mov  ax,dx
	                              sub  ax,BALL_Y
	                              cmp  ax,BALL_SIZE                 	;if(finsh all rows then ret else go up with new row)
	                              jne  draw_Ball
	                              ret
DRAW_BALL_PROC ENDP
RESTART_BALL_PROC PROC near
	;this proc draw the ball at the center
	                              mov  ax,BALL_X_ORIGIN
	                              mov  BALL_X,ax
	                              mov  ax,BALL_Y_ORIGIN
	                              mov  BALL_Y,ax
	                              mov  ax,Original_BALL_SPEED_X
	                              mov  BALL_SPEED_X,ax
	                              mov  ax,Original_BALL_SPEED_Y
	                              mov  BALL_SPEED_Y,ax

	;we will detect if a ball velocity is in the -ve direction if so we will switch it to +ve direction
	CheckBallXDirection:          
	                              mov  ax,BALL_SPEED_X
	                              cmp  ax,0
	                              jl   NegBallSpeedX
	CheckBallYDirection:          
	                              mov  ax,BALL_SPEED_Y
	                              cmp  ax,0
	                              jl   NegBallSpeedY
	;we devide the current second on no of modes (4) to get the mode
	RandomizeBallDirection:       
	                              mov  ax,0
	                              mov  al,TIME_FRAME
	                              mov  bl,4
	                              div  bl
	;if reminder == 0
	                              cmp  ah,0
	                              je   Random315degree
	;if reminder == 1
	                              cmp  ah,1
	                              je   Random45degree
	;if reminder == 2
	                              cmp  ah,2
	                              je   Random135degree
	;if reminder == 3
	                              cmp  ah,3
	                              je   Random225degree
	                              ret

	NegBallSpeedX:                neg  BALL_SPEED_X
	                              jmp  CheckBallXDirection

	NegBallSpeedY:                neg  BALL_SPEED_Y
	                              jmp  RandomizeBallDirection

	;x is +ve , Y is +ve
	Random315degree:              
	                              ret
	;x is +ve , Y is -ve
	Random45degree:               
	                              neg  BALL_SPEED_Y
	                              ret
	;x is -ve , Y is -ve
	Random135degree:              
	                              neg  BALL_SPEED_Y
	                              neg  BALL_SPEED_X
	                              ret
	;x is -ve , Y is +ve
	Random225degree:              
	                              neg  BALL_SPEED_X
	                              ret

RESTART_BALL_PROC ENDP
CLEAR_SCREEN PROC near
	;clear screen by draw an black one
	                              mov  cx,BALL_X                    	;Column
	                              mov  dx,BALL_Y                    	;Row

	                              mov  ax,0600h
	                              mov  bh,0
	                              mov  cx,0
	                              mov  dx,184FH
	                              int  10h

	                              ret
CLEAR_SCREEN ENDP

MOVE_BALL_PROC PROC near
        
	                              mov  cx,BALL_X                    	;get the current xpos
	                              add  cx,BALL_SPEED_X              	;add the current xpos to speed
	                              cmp  cx,0                         	; the ball is out the grid
	                              jg   neg_horz_z                   	;if x>0 it's safe (not out the grid)
	                              jmp  REST_POS                     	;if(x<0 then the player lose so rest the pos to the center)
	neg_horz_z:                   
	                              add  cx,BALL_SIZE                 	;if(xpos+size>width then need to rest pos because the player los)
	                              cmp  cx,SCREEN_WIDTH              	;
	                              jl   neg_horz_w                   	;if(xpos+size<width) then safe move
	                              jmp  REST_POS
	neg_horz_w:                   

	;then y boundires if the ball hit them need to negtive the speed
	                              mov  dx,BALL_Y
	                              add  dx,BALL_SPEED_Y
	                              cmp  dx,0
	                              jg   neg_vir_z
	                              neg  BALL_SPEED_Y                 	;if(y<0 then sy*=-1)

	neg_vir_z:                    
	                              add  dx,BALL_SIZE
	                              cmp  dx,SCREEN_HEIGHT
	                              jl   neg_vir_w
	                              neg  BALL_SPEED_Y                 	;if(y>H then sy*=-1)

	neg_vir_w:                    


	                              mov  cx,BALL_X                    	;mov ball(x+=sx,y+=sp)
	                              add  cx,BALL_SPEED_X
	                              mov  dx,BALL_Y
	                              add  dx,BALL_SPEED_Y
	                              mov  BALL_X,cx
	                              mov  BALL_Y,dx
        
	;check if the ball collusion with left paddel
	; maxx1 > minx2 && minx1 < maxx2 && maxy1 > miny2 && miny1 < maxy2
	; BALL_X + BALL_SIZE > PADDLE_LEFT_X && BALL_X < PADDLE_LEFT_X + PADDLE_WIDTH
	; && BALL_Y + BALL_SIZE > PADDLE_LEFT_Y && BALL_Y < PADDLE_LEFT_Y + PADDLE_HEIGHT
        
	                              mov  ax,BALL_X
	                              add  ax,BALL_SIZE
	                              cmp  ax,PADDLE_LEFT_X
	                              jng  CHECK_RIGHT_PADDEL
	                              mov  ax,PADDLE_LEFT_X
	                              add  ax,PADDLE_LEFT_WIDTH
	                              cmp  ax,BALL_X
	                              jng  CHECK_RIGHT_PADDEL
	                              mov  ax ,BALL_Y
	                              add  ax,BALL_SIZE
	                              cmp  ax,PADDLE_LEFT_Y
	                              jng  CHECK_RIGHT_PADDEL
	                              mov  ax,PADDLE_LEFT_Y
	                              add  ax,PADDLE_LEFT_HEIGHT
	                              cmp  ax,BALL_Y
	                              jng  CHECK_RIGHT_PADDEL
	; if all this true then
	                              neg  BALL_SPEED_X
	                              CALL DirectTheBallLeft
	;check if the ball collusion with right paddel
        
	CHECK_RIGHT_PADDEL:           

	                              mov  ax,BALL_X
	                              add  ax,BALL_SIZE
	                              cmp  ax,PADDLE_RIGHT_X
	                              jng  NOT_RIGHT_PADDLE
	                              mov  ax,PADDLE_RIGHT_X
	                              add  ax,PADDLE_RIGHT_WIDTH
	                              cmp  ax,BALL_X
	                              jng  NOT_RIGHT_PADDLE
	                              mov  ax ,BALL_Y
	                              add  ax,BALL_SIZE
	                              cmp  ax,PADDLE_RIGHT_Y
	                              jng  NOT_RIGHT_PADDLE
	                              mov  ax,PADDLE_RIGHT_Y
	                              add  ax,PADDLE_RIGHT_HEIGHT
	                              cmp  ax,BALL_Y
	                              jng  NOT_RIGHT_PADDLE
	; if all this true then
	                              neg  BALL_SPEED_X
	                              CALL DirectTheBallRight

	NOT_RIGHT_PADDLE:             
	                              ret
	REST_POS:                     
	                              CALL RESTART_BALL_PROC
	                              ret
MOVE_BALL_PROC ENDP

DirectTheBallLeft proc near
	;if ballY > paddleY + paddle_height/3 && => if this condition is false then the ball hits the upper part
	;ballY < paddleY + 2*paddle_height/3 => if this condition is false then the ball hits the lower part
	;then the ball hits the middle part of paddle
	;so the speed in Y axis is 0 to get 0 degree in direction
	                              mov  ax,PADDLE_LEFT_HEIGHT
	                              mov  bl,3
	                              div  bl
	                              add  ax,PADDLE_LEFT_Y
	                              cmp  BALL_Y,ax
	                              jl   HitTheUpperPartLeft
	                              mov  ax,PADDLE_LEFT_HEIGHT
	                              mov  bl,3
	                              div  bl
	                              mov  bl,2
	                              mul  bl
	                              add  ax,PADDLE_LEFT_Y
	                              cmp  BALL_Y,ax
	                              jg   HitTheLowerPartLeft
	                              mov  ax,0
	                              mov  BALL_SPEED_Y,ax
	                              ret

	HitTheUpperPartLeft:          
	                              cmp  BALL_SPEED_Y,0
	                              je   SwitchspeedToneg45degreeLeft

	                              mov  ax,Original_BALL_SPEED_X
	                              cmp  BALL_SPEED_Y,ax
	                              je   SwitchspeedToneg30degreeLeft

	                              mov  ax,Original_BALL_SPEED_X
	                              neg  ax
	                              cmp  BALL_SPEED_Y,ax
	                              je   SwitchspeedTo30degreeLeft

	                              mov  ax,0
	                              mov  BALL_SPEED_Y,ax
	                              ret

	HitTheLowerPartLeft:          
	                              cmp  BALL_SPEED_Y,0
	                              je   SwitchspeedTo45degreeLeft

	                              mov  ax,Original_BALL_SPEED_X
	                              cmp  BALL_SPEED_Y,ax
	                              je   SwitchspeedToneg30degreeLeft

	                              mov  ax,Original_BALL_SPEED_X
	                              neg  ax
	                              cmp  BALL_SPEED_Y,ax
	                              je   SwitchspeedTo30degreeLeft

	                              mov  ax,0
	                              mov  BALL_SPEED_Y,ax
	                              ret

	SwitchspeedToneg45degreeLeft: 
	                              mov  ax,Original_BALL_SPEED_X
	                              mov  BALL_SPEED_Y,ax
	                              ret
	SwitchspeedTo45degreeLeft:    
	                              mov  ax,Original_BALL_SPEED_X
	                              mov  BALL_SPEED_Y,ax
	                              neg  BALL_SPEED_Y
	                              ret
	SwitchspeedToneg30degreeLeft: 
	                              mov  ax,Original_BALL_SPEED_X
	                              mov  bl,2
	                              div  bl
	                              mov  BALL_SPEED_Y,ax
	                              ret
	SwitchspeedTo30degreeLeft:    
	                              mov  ax,Original_BALL_SPEED_X
	                              mov  bl,2
	                              div  bl
	                              mov  BALL_SPEED_Y,ax
	                              neg  BALL_SPEED_Y
	                              ret

	                              ret
DirectTheBallLeft ENDP

DirectTheBallRight proc near

	;if ballY > paddleY + paddle_height/3 && => if this condition is false then the ball hits the upper part
	;ballY < paddleY + 2*paddle_height/3 => if this condition is false then the ball hits the lower part
	;then the ball hits the middle part of paddle
	;so the speed in Y axis is 0 to get 0 degree in direction
	                              mov  ax,PADDLE_RIGHT_HEIGHT
	                              mov  bl,3
	                              div  bl
	                              add  ax,PADDLE_RIGHT_Y
	                              cmp  BALL_Y,ax
	                              jl   HitTheUpperPartRight
	                              mov  ax,PADDLE_Right_HEIGHT
	                              mov  bl,3
	                              div  bl
	                              mov  bl,2
	                              mul  bl
	                              add  ax,PADDLE_Right_Y
	                              cmp  BALL_Y,ax
	                              jg   HitTheLowerPartRight
	                              mov  ax,0
	                              mov  BALL_SPEED_Y,ax
	                              ret

	HitTheUpperPartRight:         
	                              cmp  BALL_SPEED_Y,0
	                              je   SwitchspeedToneg45degreeRight

	                              mov  ax,Original_BALL_SPEED_X
	                              cmp  BALL_SPEED_Y,ax
	                              je   SwitchspeedToneg30degreeRight

	                              mov  ax,Original_BALL_SPEED_X
	                              neg  ax
	                              cmp  BALL_SPEED_Y,ax
	                              je   SwitchspeedTo30degreeRight

	                              mov  ax,0
	                              mov  BALL_SPEED_Y,ax
	                              ret

	HitTheLowerPartRight:         
	                              cmp  BALL_SPEED_Y,0
	                              je   SwitchspeedTo45degreeRight

	                              mov  ax,Original_BALL_SPEED_X
	                              cmp  BALL_SPEED_Y,ax
	                              je   SwitchspeedToneg30degreeRight

	                              mov  ax,Original_BALL_SPEED_X
	                              neg  ax
	                              cmp  BALL_SPEED_Y,ax
	                              je   SwitchspeedTo30degreeRight

	                              mov  ax,0
	                              mov  BALL_SPEED_Y,ax
	                              ret

	SwitchspeedToneg45degreeRight:
	                              mov  ax,Original_BALL_SPEED_X
	                              mov  BALL_SPEED_Y,ax
	                              neg  BALL_SPEED_Y
	                              ret
	SwitchspeedTo45degreeRight:   
	                              mov  ax,Original_BALL_SPEED_X
	                              mov  BALL_SPEED_Y,ax
	                              ret
	SwitchspeedToneg30degreeRight:
	                              mov  ax,Original_BALL_SPEED_X
	                              mov  bl,2
	                              div  bl
	                              mov  BALL_SPEED_Y,ax
	                              neg  BALL_SPEED_Y
	                              ret
	SwitchspeedTo30degreeRight:   
	                              mov  ax,Original_BALL_SPEED_X
	                              mov  bl,2
	                              div  bl
	                              mov  BALL_SPEED_Y,ax
	                              ret

	                              ret
DirectTheBallRight ENDP


DRAW_PADDLE_LEFT_PROC PROC near
	                              mov  cx,PADDLE_LEFT_X             	;Column
	                              mov  dx,PADDLE_LEFT_Y             	;Row

	draw_paddle_left:             
	                              mov  ah,0ch                       	;Draw Pixel Command
	                              mov  al,1                         	;Pixel color
	                              mov  bh,0                         	; page number
	                              int  10h                          	; draw an pixel
	                              inc  cx                           	;cx++
	                              mov  ax,cx
	                              sub  ax,PADDLE_LEFT_X             	;if(cx-xpos==size) then go endl
	                              cmp  ax,PADDLE_LEFT_WIDTH
	                              jne  draw_paddle_left
	                              mov  cx,PADDLE_LEFT_X
	                              inc  dx
	                              mov  ax,dx
	                              sub  ax,PADDLE_LEFT_Y
	                              cmp  ax,PADDLE_LEFT_HEIGHT
	                              jne  draw_paddle_left
	                              ret
DRAW_PADDLE_LEFT_PROC ENDP
DRAW_PADDLE_RIGHT_PROC PROC near
	                              mov  cx,PADDLE_RIGHT_X            	;Column
	                              mov  dx,PADDLE_RIGHT_Y            	;Row

	draw_paddle_right:            
	                              mov  ah,0ch                       	;Draw Pixel Command
	                              mov  al,1                         	;Pixel color
	                              mov  bh,0                         	; page number
	                              int  10h                          	; draw an pixel
	                              inc  cx                           	;cx++
	                              mov  ax,cx
	                              sub  ax,PADDLE_RIGHT_X            	;if(cx-xpos==size) then go endl
	                              cmp  ax,PADDLE_RIGHT_WIDTH
	                              jne  draw_paddle_right
	                              mov  cx,PADDLE_RIGHT_X
	                              inc  dx
	                              mov  ax,dx
	                              sub  ax,PADDLE_RIGHT_Y
	                              cmp  ax,PADDLE_RIGHT_HEIGHT
	                              jne  draw_paddle_right
	                              ret
DRAW_PADDLE_RIGHT_PROC ENDP

MOVE_PADDLE_PROC PROC near

	;check wheater key pressed if not exit
	                              mov  ah,01h
	                              int  16h
	                              jnz  EXIT                         	;if not exit
	                              ret
	EXIT:                         
	                              mov  ah,00h
	                              int  16h                          	; get the current key pressed
	                              cmp  ah,11h                       	;up arrow
	                              jne  NO_UP_LEFT_PADDEL            	; if not up arrow go check other

	                              mov  dx,PADDLE_LEFT_Y
	                              sub  dx,L_PADDLE_SPEED
	                              cmp  dx,0                         	;if pos-sy<0
	                              jg   SAFE_MOVE_UP                 	; if > then safe move
	                              mov  PADDLE_LEFT_Y,1              	;if < set it at 0
	                              jmp  NO_UP_LEFT_PADDEL
	SAFE_MOVE_UP:                 
	                              mov  PADDLE_LEFT_Y,dx


	NO_UP_LEFT_PADDEL:            
	                              cmp  ah,1fh                       	; down arrow
	                              jnz  NO_DOWN_LEFT_PADDEL
	                              mov  dx,PADDLE_LEFT_Y
	                              add  dx,L_PADDLE_SPEED
	                              add  dx,PADDLE_LEFT_HEIGHT
	                              cmp  dx,SCREEN_HEIGHT
    
	                              jl   SAFE_MOVE_DOWN
	                              mov  dx,SCREEN_HEIGHT
	                              sub  dx,PADDLE_LEFT_HEIGHT        	;if > height set it at top down
	                              dec  dx
	                              mov  PADDLE_LEFT_Y,dx
	                              jmp  NO_DOWN_LEFT_PADDEL
	SAFE_MOVE_DOWN:               
	                              sub  dx,PADDLE_LEFT_HEIGHT
	                              mov  PADDLE_LEFT_Y,dx
	NO_DOWN_LEFT_PADDEL:          



	                              cmp  ah,48h                       	;up arrow
	                              jne  NO_UP_RIGHT_PADDEL           	; if not up arrow go check other

	                              mov  dx,PADDLE_RIGHT_Y
	                              sub  dx,R_PADDLE_SPEED
	                              cmp  dx,0                         	;if pos-sy<0
	                              jg   SAFE_MOVE_UP_RIGHT           	; if > then safe move
	                              mov  PADDLE_RIGHT_Y,1             	;if < set it at 0
	                              jmp  NO_UP_RIGHT_PADDEL
	SAFE_MOVE_UP_RIGHT:           
	                              mov  PADDLE_RIGHT_Y,dx


	NO_UP_RIGHT_PADDEL:           
	                              cmp  ah,50h
	                              jnz  NO_DOWN_RIGHT_PADDEL
	                              mov  dx,PADDLE_RIGHT_Y
	                              add  dx,R_PADDLE_SPEED
	                              add  dx,PADDLE_RIGHT_HEIGHT
	                              cmp  dx,SCREEN_HEIGHT
    
	                              jl   SAFE_MOVE_DOWN_RIGHT
	                              mov  dx,SCREEN_HEIGHT
	                              sub  dx,PADDLE_RIGHT_HEIGHT       	;if > height set it at top down
	                              dec  dx
	                              mov  PADDLE_RIGHT_Y,dx
	                              jmp  NO_DOWN_RIGHT_PADDEL
	SAFE_MOVE_DOWN_RIGHT:         
	                              sub  dx,PADDLE_RIGHT_HEIGHT
	                              mov  PADDLE_RIGHT_Y,dx
	NO_DOWN_RIGHT_PADDEL:         

    
	                              ret
MOVE_PADDLE_PROC ENDP

DRAW_CENTER PROC near
	                              mov  cx,0a0h                      	;Column
	                              mov  bx,0                         	; rows
	increase_WITH_NO_DRAW:        
	                              inc  bx
	draw_center_oa:               
	                              mov  ax,bx
	                              mov  cx,20
	                              mov  dx,0
	                              DIV  cx                           	;ax/20 = ax=ax/20 dx=ax%20
	                              cmp  dx,0                         	;if(dx%20==0) then inc with no draw
	                              je   increase_WITH_NO_DRAW
	                              mov  dx,bx
	                              mov  cx,0a0h
	                              mov  ah,0ch                       	;Draw Pixel Command
	                              mov  al,1                         	;Pixel color
	                              mov  bh,0                         	; page number
	                              int  10h                          	; draw an pixel
	                              inc  bx
	                              cmp  bx,SCREEN_HEIGHT
	                              jg   END_DRAW_CENTER
	                              jmp  draw_center_oa
	END_DRAW_CENTER:              
	                              ret
DRAW_CENTER ENDP
    END MAIN
