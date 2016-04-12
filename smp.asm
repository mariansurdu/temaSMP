
.model small

.stack 100h

 

.data

msg1    db      10, 13, 10, 13, "Please select an item:",0Dh,0Ah,0Dh,0Ah,09h

        db      "1- Create File",0Dh,0Ah,09h

        db      "2- About",0Dh,0Ah,09h     

        db      "3- Exit",0Dh,0Ah,09h    

        db      "4- Open File",0dh,0ah,09h

        db      "Enter item number: "

        db      '$'  

         

About   db      10, 13, 10, 13, "This program is used to create a file,read a file and to serve some details about the program!!$"

 

handle  dw  ?

file1   db  "c:\smp.txt", 0

text    db  "This Message Contains Absolutely Nothing!",0

text_size equ $ - text

   

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

    je      CreateFile

    cmp     al, "2"

    je      ShowAbout

    cmp     al, "3"

    jmp     Quit         

    cmp     al, "4"

    jmp     OpenFile

         

Quit:

   mov   ah,4ch

   int   21h  

 

Showabout:      

    lea     dx, About 

    mov     ah, 09h

    int     21h   

    jmp     ShowMenu

     

CreateFile:

jmp new

text_size = $ - offset text

new:

mov ah, 3ch

mov dx, offset file1

int 21h

mov handle, ax

mov ah, 40h

mov bx, handle

mov dx, offset text

mov cx, text_size

int 21h

int 21h          

ret

               

OpenFile:   

jmp print

mov dx, offset file

mov al,0

mov ah,3dh

int 21h

jc terminate

mov bx,ax

mov cx,1

print:

lea dx, BUF

mov ah,3fh

int 21h

CMP AX, 0

JZ terminate

mov al, BUF

mov ah,0eh

int 10h

jmp print

terminate:

mov ah, 0

int 16h

ret

file db "c:\smp.txt", 0

BUF db ?

END           

 

   jmp     ShowMenu               

main endp

end main


These were the new codes I put in