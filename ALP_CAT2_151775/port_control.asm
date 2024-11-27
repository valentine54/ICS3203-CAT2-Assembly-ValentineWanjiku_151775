
global _start

section .data
    sensor_value    dd 0        
    motor_status    db 0        
    alarm_status    db 0       

    HIGH_LEVEL      equ 80
    MODERATE_LEVEL  equ 50

    prompt          db 'Enter sensor value: ', 0
    input_buffer    db 10 dup(0)
    motor_msg       db 'Motor Status: ', 0
    alarm_msg       db 'Alarm Status: ', 0
    on_msg          db 'ON', 10, 0
    off_msg         db 'OFF', 10, 0

section .text
_start:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, prompt
    mov     edx, 20             
    int     0x80

    mov     eax, 3
    mov     ebx, 0
    mov     ecx, input_buffer
    mov     edx, 10
    int     0x80

    mov     esi, input_buffer
    call    atoi                ; Result in EAX

    mov     [sensor_value], eax

    mov     eax, [sensor_value]

    cmp     eax, HIGH_LEVEL
    jg      high_level

    cmp     eax, MODERATE_LEVEL
    jg      moderate_level

low_level:
    mov     byte [motor_status], 1
    mov     byte [alarm_status], 0
    jmp     display_status

moderate_level:
    mov     byte [motor_status], 0
    mov     byte [alarm_status], 0
    jmp     display_status

high_level:
    mov     byte [motor_status], 1
    mov     byte [alarm_status], 1

display_status:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, motor_msg
    mov     edx, 14
    int     0x80

    mov     al, [motor_status]
    cmp     al, 1
    je      motor_on
    jmp     motor_off

motor_on:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, on_msg
    mov     edx, 3
    int     0x80
    jmp     display_alarm

motor_off:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, off_msg
    mov     edx, 4
    int     0x80

display_alarm:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, alarm_msg
    mov     edx, 13
    int     0x80

    mov     al, [alarm_status]
    cmp     al, 1
    je      alarm_on
    jmp     alarm_off

alarm_on:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, on_msg
    mov     edx, 3
    int     0x80
    jmp     exit_program

alarm_off:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, off_msg
    mov     edx, 4
    int     0x80

exit_program:
    
    mov     eax, 1
    xor     ebx, ebx
    int     0x80


atoi:
    xor     eax, eax                
    xor     ebx, ebx                
atoi_loop:
    mov     bl, byte [esi]          
    cmp     bl, 10                  
    je      atoi_done
    sub     bl, '0'                 
    imul    eax, eax, 10            
    add     eax, ebx                
    inc     esi                     
    jmp     atoi_loop
atoi_done:
    ret