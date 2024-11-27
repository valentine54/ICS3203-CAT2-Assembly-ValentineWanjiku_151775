section .data
    prompt db "Enter five single digits separated by spaces (e.g., 1 2 3 4 5): ", 0
    prompt_len equ $ - prompt
    newline db 10                                   
    invalid_input_msg db "Invalid input! Please try again.", 0
    invalid_input_len equ $ - invalid_input_msg

section .bss
    input resb 16      
    array resb 5       

section .text
    global _start

_start:
    
input_loop:
    mov rax, 1             
    mov rdi, 1              
    mov rsi, prompt         
    mov rdx, prompt_len     
    syscall

    
    mov rax, 0             
    mov rdi, 0             
    mov rsi, input          
    mov rdx, 16             
    syscall

    
    xor r12, r12            
    mov rdi, input          

parse_input:
   
    cmp r12, 5
    je reverse_array

    
    mov al, [rdi]
    cmp al, 0              
    je invalid_input        

    
    cmp al, '0'
    jl skip_char            
    cmp al, '9'
    jg skip_char            
    
    mov [array + r12], al
    inc r12                 

skip_char:
    inc rdi                 
    jmp parse_input        

reverse_array:
    
    mov r12, 0              
    mov r13, 4              
reverse_loop:
    cmp r12, r13           
    jge print_array

    
    mov al, [array + r12]
    mov bl, [array + r13]
    mov [array + r12], bl
    mov [array + r13], al

   
    inc r12
    dec r13
    jmp reverse_loop

print_array:
    mov r12, 0             
print_loop:
    
    mov al, [array + r12]
    mov [input], al        

   
    mov rax, 1             
    mov rdi, 1              
    mov rsi, input
    mov rdx, 1
    syscall

    
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    
    inc r12
    cmp r12, 5
    jl print_loop

    
    mov rax, 60             
    xor rdi, rdi            
    syscall

invalid_input:
   
    mov rax, 1
    mov rdi, 1
    mov rsi, invalid_input_msg
    mov rdx, invalid_input_len
    syscall

    
    jmp input_loop