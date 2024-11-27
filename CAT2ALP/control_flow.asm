section .bss
    num resb 16             

section .data
    prompt db "Enter a number: ", 0      
    zero_msg db "ZERO", 0                
    positive_msg db "POSITIVE", 0         
    negative_msg db "NEGATIVE", 0         
    invalid_msg db "INVALID INPUT", 0     

section .text
    global _start

_start:
    mov eax, 4                
    mov ebx, 1                 
    mov ecx, prompt            
    mov edx, 17                
    int 0x80                  

    mov eax, 3                 
    mov ebx, 0                 
    mov ecx, num              
    mov edx, 16               
    int 0x80                   

    mov al, byte [num]        

    cmp al, 10                 
    je invalid_input           

    cmp al, '-'                
    je check_negative_digit    

    cmp al, '0'                
    je is_zero                

    cmp al, '1'               
    jl invalid_input          
    cmp al, '9'
    jg invalid_input           

    jmp is_positive

check_negative_digit:
    mov al, byte [num + 1]    
    cmp al, '0'               
    jl invalid_input           
    cmp al, '9'
    jg invalid_input         
    jmp is_negative            

is_zero:
    mov eax, 4                
    mov ebx, 1                
    mov ecx, zero_msg         
    mov edx, 4                 
    int 0x80                   
    jmp end_program            

is_positive:
    mov eax, 4                 
    mov ebx, 1                 
    mov ecx, positive_msg      
    mov edx, 8                 
    int 0x80                   
    jmp end_program            

is_negative:
    mov eax, 4                 
    mov ebx, 1                 
    mov ecx, negative_msg      
    mov edx, 8                 
    int 0x80                   
    jmp end_program            

invalid_input:
    mov eax, 4                 
    mov ebx, 1                 
    mov ecx, invalid_msg       
    mov edx, 14                
    int 0x80                   

end_program:
    mov eax, 1                 
    xor ebx, ebx               
    int 0x80                   