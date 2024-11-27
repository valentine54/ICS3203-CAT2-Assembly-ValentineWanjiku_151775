section .data
    prompt          db 'Enter a number (0-12): ', 0
    result_msg      db 'Factorial is: ', 0
    newline         db 10, 0
    input_buffer    db 10 dup(0)         
    result_buffer   db 20 dup(0)         

section .bss

section .text
global _start

_start:
    mov     rax, 1                 
    mov     rdi, 1                 
    mov     rsi, prompt
    mov     rdx, 22                
    syscall

    mov     rax, 0                  
    mov     rdi, 0                  
    mov     rsi, input_buffer
    mov     rdx, 10               
    syscall

    mov     rsi, input_buffer      
    call    atoi                    

    cmp     rax, 12
    ja      invalid_input
    cmp     rax, 0
    jl      invalid_input

    push    rax                     
    call    factorial
    add     rsp, 8                  

 
    mov     rsi, result_buffer      ; Buffer for the result
    call    itoa

    mov     rax, 1                 
    mov     rdi, 1                 
    mov     rsi, result_msg
    mov     rdx, 14                 
    syscall

    mov     rax, 1                
    mov     rdi, 1               
    mov     rsi, result_buffer
    mov     rdx, 20                 
    syscall

    mov     rax, 1                  
    mov     rdi, 1                 
    mov     rsi, newline
    mov     rdx, 1
    syscall

    mov     rax, 60                
    xor     rdi, rdi
    syscall

invalid_input:
    mov     rax, 1                  
    mov     rdi, 1                 
    mov     rsi, newline
    mov     rdx, 22                 
    syscall
    mov     rax, 60                 
    xor     rdi, rdi
    syscall

factorial:
    mov     rbx, 1                  
    cmp     rax, 0                  
    je      factorial_end
factorial_loop:
    imul    rbx, rax               
    dec     rax                     
    jnz     factorial_loop
factorial_end:
    mov     rax, rbx                
    ret

atoi:
    xor     rax, rax                
    xor     rcx, rcx                
    mov     rcx, 10

atoi_loop:
    movzx   rdx, byte [rsi]        
    cmp     rdx, 10                
    je      atoi_done
    sub     rdx, '0'               
    imul    rax, rcx              
    add     rax, rdx                
    inc     rsi
    jmp     atoi_loop

atoi_done:
    ret


itoa:
    xor     rcx, rcx               
itoa_loop:
    xor     rdx, rdx               
    mov     rbx, 10
    div     rbx                   
    add     dl, '0'                
    push    rdx                    
    inc     rcx
    test    rax, rax                
    jnz     itoa_loop

itoa_pop:
    pop     rdx                     
    mov     [rsi], dl               
    inc     rsi
    loop    itoa_pop

    mov     byte [rsi], 0           
    ret