
include 'emu8086.inc'

.model small

.stack 100h

 

.data

msg1    db      10, 13, 10, 13, "Please select an item:",0Dh,0Ah,0Dh,0Ah,09h

        db      "1- Water Installation ",0Dh,0Ah,09h

        db      "2- About",0Dh,0Ah,09h     

        db      "3- Draw with Mouse",0Dh,0Ah,09h    

        db      "4- Exit",0dh,0ah,09h

        db      "Enter item number: "

        db      '$'  

         

About   db      10, 13, 10, 13, "Acest program utilizeaza gradica in mediul emu8086.La primul punct este o instalatie de apa.Puctul 3 ne permite sa realizam desene utilizand mouse-ul.Sursa proiectului poate fi gasita la https://github.com/mariansurdu/temaSMP $"

    









 
.code

main proc

    mov   ax,@data

    mov   ds,ax

 

ShowMenu:      

    lea     dx, msg1 

    mov     ah, 09h

    int     21h    

         

getnum:       

    mov     ah, 1

    int     21h       

     

    cmp     al, '1'

    jl      ShowMenu  

    cmp     al, '3'

    jg      ShowMenu 
    
    

    cmp     al, "1"

    je      DrawRectangle

      
      
      
    cmp     al, "2"   
    je      ShowAbout
    
                   
                   
                   

    cmp     al, "3"

    je     Draw         

    
    
    
    cmp     al, "4"

    je     Quit

         
 
 
Quit:

   mov   ah,4ch

   int   21h  

 

Showabout:      

    lea     dx, About 

    mov     ah, 09h

    int     21h   

    jmp     ShowMenu    
    
    
    
Draw:

jmp start
oldX dw -1
oldY dw 0
start:
mov ah, 00
mov al, 13h ; intrare in mod grafic rezolutia 320x200
int 10h

mov ax, 0 ; are loc initializarea mouse-ului
int 33h
cmp ax, 0
mov ax, 1 ; afisare cursor mouse
int 33h 

        check_mouse_button:
        mov ax, 3
        int 33h 
        shr cx, 1 
        cmp bx, 1
        jne xor_cursor:
        mov al, 100b ; culoare punct
        jmp draw_pixel  ;desenare pixel
        
        xor_cursor:
        cmp oldX, -1
        je not_required
        push cx
        push dx
        mov cx, oldX
        mov dx, oldY
        mov ah, 0dh
        int 10h
        xor al, 1111b
        mov ah, 0ch
        int 10h
        pop dx
        pop cx  
        
        
        not_required:
        mov ah, 0dh
        int 10h
        xor al, 1111b
        mov oldX, cx
        mov oldY, dx

        draw_pixel:
        mov ah, 0ch
        int 10h   
        
        check_esc_key:
        mov dl, 255
        mov ah, 6
        int 21h
        cmp al, 27 ; 
        jne check_mouse_button

        stop:
        mov ax, 3 ; BACK IN NORMAL
        int 10h
        mov ah, 1
        mov ch, 0
        mov cl, 8
        int 10h
        mov dx, offset msg
        mov ah, 9
        int 21h
        mov ah, 0
        int 16h

msg db " press any key.... $"
    
 


DrawRectangle:

w equ 20 ; dimensiune dreptunghi
h equ 6
new: mov ah, 0
 mov al, 13h ; trecere in mod grafic 320x200
 int 10h 
 
 ; afisare latura inferioare
 mov cx, 200+w
 mov dx, 150+h
 mov al, 35
u2: mov ah, 0ch
 int 10h
 dec cx
 cmp cx, 100
 ja u2      
 
 
 ; latura din stanga
 mov cx, 100
 mov dx, 150+h
 mov al, 30
u3: mov ah, 0ch
 int 10h
 dec dx
 cmp dx, 100
 ja u3                     
 
 
 
 ; latura din dreapta
 mov cx, 200+w
 mov dx, 150+h
 mov al, 25  
 u4: mov ah, 0ch
 int 10h
 dec dx
 cmp dx, 100
 ja u4
 
; afisare latura superioara
 mov cx, 200+w ; coloana
 mov dx, 100 ; rand
 mov al, 40 ; culoare
u1: mov ah, 0ch ; afisare pixel
 int 10h
 dec cx
 cmp cx, 100
 jae u1
 
 
 
 
 ; asteptare apasare tasta
 mov ah,00
 int 16h  
 jmp   ShowMenu




ret

main endp

end main


