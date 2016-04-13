
include 'emu8086.inc'

.model small

.stack 100h

 

.data

msg1    db      10, 13, 10, 13, "Please select an item:",0Dh,0Ah,0Dh,0Ah,09h

        db      "1- Graphics",0Dh,0Ah,09h

        db      "2- About",0Dh,0Ah,09h     

        db      "3- Something",0Dh,0Ah,09h    

        db      "4- Exit",0dh,0ah,09h

        db      "Enter item number: "

        db      '$'  

         

About   db      10, 13, 10, 13, "This program shows us some graphics in emu8086!! :)$"

    









 
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

    je     Quit         

    
    
    
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


