.686
.model flat

extern _MessageBoxW@16: PROC
extern _ExitProcess@4: PROC

public _main

.data
	tytul	dw	0
	tekst	dw	'a', '1', 'b', '2', 0
	kot		dw	0D83Dh, 0DC31h, 0
	bufor	dw	80 dup(0)	; w ten sposob nie trzeba sie martwic o znak konca ciagu znakow

.code
_main PROC

	; wskaznik tekstu -> edi
	; wskaznik buforu -> esi
	mov esi, 0
	mov edi, 0

petla:

	; pobrany znak
	mov ax, word ptr [tekst + esi]
	add esi, 2

	; jesli koniec wiersza -> koniec
	cmp ax, 0
	je koniec

	; przeslij znak do bufora
	mov word ptr [bufor + edi], ax
	add edi, 2
	
	; jesli to byla cyfra...
	cmp ax, '0'
	jl petla

	cmp ax, '9'
	ja petla

	; ...to w nastepnym razem zastapimy znak nastepnym
	sub edi, 2
	jmp petla
	

koniec:
	; ustawienie kota
	mov eax, dword ptr [kot]
	mov dword ptr [bufor + edi], eax

	push 21h
	push offset tytul
	push offset bufor
	push 0
	call _MessageBoxW@16

	push 0
	call _ExitProcess@4

_main ENDP
END
