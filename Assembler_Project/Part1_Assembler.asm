section .note.GNU-stack noalloc noexec nowrite progbits
section .data               
;Cambiar Nombre y Apellido por vuestros datos.
developer db "_Name_ _Surname_",0

;Constante que también está definida en C.
ROWSMATRIX equ 6
COLSMATRIX equ 7
DISCSYMBOLPLAYER1 equ 'X'
DISCSYMBOLPLAYER2 equ 'O'

section .text            
;Variables definidas en ensamblador.
global developer                        

;Subrutinas de ensamblador que se llaman desde C.
global calcIndexP1, updateBoardP1, showDiscPosP1, moveCursorP1, insertDiscP1
global checkEndP1, playP1

;Variables globales definidas en C.
extern charac, rowScreen, colScreen, row, col, indexMat, discSymbol
extern colCursor, state, newState, mBoard, freeRowXcol, direction

;Funciones de C que se llaman desde ensamblador.
extern gotoxyP1_C, printchP1_C, getchP1_C
extern printBoardP1_C, printMessageP1_C

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ATENCIÓN: Recordad que en ensamblador las variables y los parámetros 
;;   de tipo 'char' deben asignarse a registros de tipo  
;;   BYTE (1 byte): al, ah, bl, bh, cl, ch, dl, dh, sil, dil, ..., r15b
;;   los de tipo 'short' deben asignarse a registros de tipo 
;;   WORD (2 bytes): ax, bx, cx, dx, si, di, ...., r15w
;;   los de tipo 'int' deben asignarse a registros de tipo 
;;   DWORD (4 bytes): eax, ebx, ecx, edx, esi, edi, ...., r15d
;;   los de tipo 'long' deben asignarse a registros de tipo 
;;   QWORD (8 bytes): rax, rbx, rcx, rdx, rsi, rdi, ...., r15
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Las subrutinas en ensamblador que debéis implementar son:
;;   calcIndexP1, updateBoardP1, showDiscPosP1
;;   moveCursorP1, insertDiscP1, checkEndP1
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Esta subrutina se proporciona ya hecha. NO LA PODÉIS MODIFICAR.
; Posicionar el cursor en la fila indicada por la variable (rowScreen) y 
; en la columna indicada por la variable (colScreen) de la pantalla,
; llamando a la función gotoxyP1_C.
; 
; Variables globales utilizadas:   
; (rowScreen): Fila de la pantalla donde posicionamos el cursor.
; (colScreen): Columna de la pantalla donde posicionamos el cursor.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gotoxyP1:
   push rbp
   mov  rbp, rsp
   ;guardamos el estado de los registros del procesador porque
   ;las funciones de C no mantienen el estado de los registros.
   push rax
   push rbx
   push rcx
   push rdx
   push rsi
   push rdi
   push r8
   push r9
   push r10
   push r11
   push r12
   push r13
   push r14
   push r15

   call gotoxyP1_C
 
   ;restaurar el estado de los registros que se han guardado en la pila.
   pop r15
   pop r14
   pop r13
   pop r12
   pop r11
   pop r10
   pop r9
   pop r8
   pop rdi
   pop rsi
   pop rdx
   pop rcx
   pop rbx
   pop rax

   mov rsp, rbp
   pop rbp
   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Esta subrutina se proporciona ya hecha. NO LA PODÉIS MODIFICAR.
; Mostrar un carácter guardado en la variable (charac) en la pantalla, 
; en la posición donde está el cursor, llamando a la función printchP1_C.
; 
; Variables globales utilizadas:   
; (charac): Carácter que queremos mostrar.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
printchP1:
   push rbp
   mov  rbp, rsp
   ;guardamos el estado de los registros del procesador porque
   ;las funciones de C no mantienen el estado de los registros.
   push rax
   push rbx
   push rcx
   push rdx
   push rsi
   push rdi
   push r8
   push r9
   push r10
   push r11
   push r12
   push r13
   push r14
   push r15

   call printchP1_C
 
   ;restaurar el estado de los registros que se han guardado en la pila.
   pop r15
   pop r14
   pop r13
   pop r12
   pop r11
   pop r10
   pop r9
   pop r8
   pop rdi
   pop rsi
   pop rdx
   pop rcx
   pop rbx
   pop rax

   mov rsp, rbp
   pop rbp
   ret
   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Esta subrutina se proporciona ya hecha. NO LA PODÉIS MODIFICAR.
; Leer una tecla y guardar el carácter asociado en la variable (charac)
; sin mostrarlo en pantalla, llamando a la función getchP1_C. 
; 
; Variables globales utilizadas:   
; (charac): Carácter que leemos del teclado.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
getchP1:
   push rbp
   mov  rbp, rsp
   ;guardamos el estado de los registros del procesador porque
   ;las funciones de C no mantienen el estado de los registros.
   push rax
   push rbx
   push rcx
   push rdx
   push rsi
   push rdi
   push r8
   push r9
   push r10
   push r11
   push r12
   push r13
   push r14
   push r15

   call getchP1_C
 
   ;restaurar el estado de los registros que se han guardado en la pila.
   pop r15
   pop r14
   pop r13
   pop r12
   pop r11
   pop r10
   pop r9
   pop r8
   pop rdi
   pop rsi
   pop rdx
   pop rcx
   pop rbx
   pop rax
   
   mov rsp, rbp
   pop rbp
   ret 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; **** Esta función no es necesaria en C, solo en ensamblador.****
; Calcular el índice para acceder a la matriz (mBoard) en ensamblador.
; (mBoard[row][col]) en C, es ([mBoard+indexMat]) en ensamblador.
; donde indexMat = row*COLSMATRIX+col.
; La matriz (mBoard) es de tipo char(BYTE)1byte.
; 
; Variables globales utilizadas:	
; (row)     : Fila de la matriz mBoard.
; (col)     : Columna de la matriz mBoard.
; (indexMat): Índice para acceder a la matriz mBoard en ensamblador.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
calcIndexP1:
   push rbp
   mov  rbp, rsp
   ;guardar el estado de los registros que se modifican en esta 
   ;subrutina y que no se utilizan para devolver valores.
   
   push rax                               ; Anhadir el registro a la pila (se usara para calculos)
   mov rax, COLSMATRIX                    ; Almacenar COLSMATRIX en rax. La funcion retornara "row*COLSMATRIX+col"

   imul eax, DWORD[row]                   ; Es necesario tener ambos operandos de misma longitud cuando se opera en ensamblador
                                          ; Hacemos primero "row*COLSMATRIX". Usamos "eax" porque representa los 4 bytes de menor peso en rax
                                          ; Se obtiene eax:=eax*DWORD[col]

   add eax, DWORD[col]                    ; Como "col" es integer (4 bytes) se define como DWORD[col]. Sin embargo, queremos anhadirle la suma.
                                          ; Misma situacion que antes, en las operaciones de ensamblador es necesario que los operandos sean de la misma longitud.
                                          ; Como "col" es de 4 bytes es compatible con "eax" de nuevo. Por lo tanto, se define:
                                          ; eax:=eax+DWORD[col]

   mov QWORD[indexMat], rax               ; "indexMat" es long (i.e., 8 bytes), por lo tanto se define con "QWORD(indexMat)".
                                          ; Usaremos "rax" porque son 8 bytes (registro completo, no como antes, eax, 4 bytes).
                                          ; Por lo tanto, se define: QWORD[indexMat]:=row*COLSMATRIX+col

   pop rax                                ; Colocar el registro en su valor inicial.
   
   
   calcIndexP1_end:  
   ;restaurar el estado de los registros que se han guardado en la pila.
   
   mov rsp, rbp
   pop rbp
   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Mostrar los valores de la matriz (mBoard)
; dentro del tablero, en las posiciones correspondientes. 
; Se debe recorrer toda la matriz (mBoard), de izquierda a derecha y 
; de arriba a abajo, desde la posición [0][0]=(0) hasta la posición [5][6]=(41),
; cada posición es de tipo char(BYTE)1byte, y para cada elemento hacer:
; Posicionar el cursor en el tablero en función de las variables 
; (rowScreen) fila y (colScreen) columna llamando a la subrutina gotoxyP1.
; Las variables (rowScreen) y (colScreen) se inicializarán en 7 y 8, 
; respectivamente, que es la posición en pantalla de la casilla [0][0].
; Las filas se incrementan de 2 en 2 y las columnas de 4 en 4.
; Mostrar los caracteres de cada posición de la matriz (mBoard) llamando
; a la subrutina printchP1.
;  
; Variables globales utilizadas:	
; (mBoard): Dirección de la matriz donde guardamos los discos introducidos.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
updateBoardP1:
   push rbp
   mov  rbp, rsp
   ;guardar el estado de los registros que se modifican en esta 
   ;subrutina y que no se utilizan para devolver valores.
   
   push rsi                                     ; almacenar registro en la pila
   push rax
   push rbx
   push rcx
   
   mov rsi, 0                                   ; usaremos "rsi" para los desplazamientos, set to 0
   mov rax, 0                                   ; Para prevenir desbordamiento o acarreo
                                                ; Inicializaremos la variable local i (integer, 4 bytes, "eax")
   mov rcx, 0                                   ; asignamos "rcx" a 0 para usarlo como registro auxiliar y almacenar
                                                ; datos durante el proceso
   mov DWORD[rowScreen], 7                      ; asignamos el valor 7 a "rowScreen" (entero, 4 bytes)
   beginning_for_i:  
                     cmp eax, ROWSMATRIX        ; for(i=0;i<ROWSMATRIX;i++), "i" integer (4 bytes), usamos "eax" para "i".
                                               
                     jge ending_for_i           ; En ensamblador la representacion de la condicion es opuesta a C
                                                ; Si "i" es >= "ROWSMATRIX" se finaliza la condicion del bucle (salta al final del loop)
                     mov DWORD[colScreen], 8    ; "colScreen" es integer (4 bytes), le asignamos el valor 8
                     mov rbx, 0                 ; Inicializamos "j=0" (integer, 4 bytes). Haciendo "mov rbx, 0" garantizamos
                                                ; que este vacio. Se usara "ebx" para "j"
   beginning_for_j: 
                     cmp ebx, COLSMATRIX        ; for (j=0;j<COLSMATRIX;j++). COLSMATRIX es una cte y por ende se referencia
                                                ; inmediatamente, "j" es integer (4 bytes) y se representa con "ebx". Comparamos.
                     jge ending_for_j           ; Si j>=COLSMATRIX, for termina. (Opuesto)
                     call gotoxyP1              ; Llamada subturina gotoxyP1
                     mov rsi, COLSMATRIX        ; Asignamos "rsi=COLSMATRIX" (inmediatamente, es cte)
                     imul esi, eax              ; Hacemos "COLSMATRIX*i". Ambos registros son del mismo tipo (4 bytes)
                                                ; "esi=esi*eax"
                     add esi, ebx               ; Sumamos: esi=esi+ebx (COLSMATRIX*i+j) para obtener el indice correcto en mBoard

                     mov cl, BYTE[mBoard+esi]   ; "mBoard" es una matriz de elementos "char" (1 byte), cargamos el valor en cl
                                                ; donde esi es el desplazamiento
                     mov BYTE[charac], cl       ; charac:=mBoard[i][j], almacenamos en 'charac'

                     call printchP1             ; Llamada subrutina printchP1
                     add DWORD[colScreen],4     ; Aplicamos "colScreen:=colScreen+4", colScreen es entero (4 bytes)

                     inc ebx                    ; Aumentamos "j++" con "ebx"
                     jmp beginning_for_j        ; Cerramos el bucle saltando al inicio del bucle

   ending_for_j:                                ; Final del loop "for j"
                     add DWORD[rowScreen],2     ; Sumamos 2, rowScreen:=rowScreen+2 (rowScreen es integer, 4 bytes)
                     inc eax                    ; incrementamos i "i++"
                     jmp beginning_for_i        ; Retorno al principio del loop "for i"
   ending_for_i:                                ; Final loop "for i"
                     pop rcx                    ; Colocar registro en valor inicial
                     pop rbx
                     pop rax
                     pop rsi

   
   updateBoardP1_end:  
   ;restaurar el estado de los registros que se han guardado en la pila.
   	
   mov rsp, rbp
   pop rbp
   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Muestra en la parte superior del tablero el símbolo del jugador (discSymbol)
; que está jugando en la columna donde está el cursor (colCursor)
; y posiciona el cursor en la posición del tablero
; donde caerá el disco en esa columna.
; El símbolo del jugador se muestra en la fila (rowScreen=5) y la columna
; (colScreen=8+colCursor*4).
; Después posicionar el cursor en la misma columna y 
; en la fila donde caerá el disco si se presiona espacio.
; (rowScreen = 7+freeRowXcol[colCursor]*2)
; La matriz freeRowXcol es de tipo int(DWORD)4bytes.
; Posicionar el cursor en el tablero en función de las variables 
; (rowScreen) fila y (colScreen) columna llamando a la subrutina gotoxyP1.
; Mostrar el símbolo (discSymbol) llamando a la subrutina printchP1.
;  
; Variables globales utilizadas:	
; (discSymbol) : Símbolo del jugador que está jugando.
; (colCursor)  : Columna donde está el cursor.
; (freeRowXcol): Dirección de la matriz que indica la primera fila libre de cada columna del tablero.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
showDiscPosP1:
   push rbp
   mov  rbp, rsp
   ;guardar el estado de los registros que se modifican en esta 
   ;subrutina y que no se utilizan para devolver valores.	
   
               push rsi                      ; almacenar registro en la pila
               push rax                      ; almacenar registro en la pila
               push rbx                      ; almacenar registro en la pila

               mov rbx, 0                    ; rbx a 0 para almacenar resultados durante el proceso
                                             ; vaciamos rbx de nuevo para evitar desbordamientos/acarreos

               mov DWORD[rowScreen], 5       ; Declaramos rowScreen=5, integer (4 bytes)

               mov rax, 0                    ; Usamos rax para representar colScreen=8+colCursor*4.
                                             ; Hacemos set rax=0 para evitar desbordamientos/acarreos
               mov eax, DWORD[colCursor]     ; eax=colCursor, colCursor es un entero (4 bytes)
               shl eax, 2                    ; Desplazamos el contenido de eax 2 posiciones a la izquierda
                                             ; eax:=eax*4
               add eax, 8                    ; eax:=eax+8=(colCursor*4)+8

               mov DWORD[colScreen], eax     ; Se almacena en colScreen:=8+colCursor*4
               
               call gotoxyP1                 ; Llamamos subrutina funcion gotoxyP1
               mov bl, BYTE[discSymbol]      ; Cargamos dicSymbol en registro bl, charac:= discSymbol
               mov BYTE[charac], bl          ; Asignamos 'discSymbol' al caracter 'charac'

               call printchP1                ; Llamamos subrutina funcion printchP1
               mov rax, 0                    ; Reinicializamos rax a 0

               mov rsi, 0                    ; Reinicializamos rsi a 0

               mov esi, DWORD[colCursor]     ; Carga el valor de colCursor en esi

               shl esi, 2                    ; Desplazamos esi 2 bits (*4)

               mov eax, DWORD[freeRowXcol+esi]  ; vector + desplazamiento. Apunta al punto de memoria
                                                ; a partir del cual se coge el dato y se guarda en eax
               
               shl eax, 1                    ; eax:=eax*2, se desplaza el registro eax una posicion a la izquierda.
               add eax, 7                    ; eax:=eax+7

               mov DWORD[rowScreen], eax     ; Almacenamos eax en roWscreen
                                             ; El objetivo es obtener rowScreen:=7+freeRowXcol[colCursor]*2

               call gotoxyP1                 ; Llamada a la subrutina gotoxyP1

               pop rsi                       ; Colocar registro en valor inicial
               pop rax
               pop rbx
  
   
   showDiscPosP1_end:  
   ;restaurar el estado de los registros que se han guardado en la pila.
   
   mov rsp, rbp
   pop rbp
   ret
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Actualizar la columna donde está el cursor (colCursor).
; Si se ha leído (charac=='k') izquierda o (charac=='l') derecha 
; actualizar la posición del cursor (colCursor +/- 1)
; controlando que no se salga del tablero [0..(COLSMATRIX-1)]. 
;  
; Variables globales utilizadas:	
; (charac)   : Carácter leído del teclado.
; (colCursor): Columna donde está el cursor.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
moveCursorP1:
   push rbp
   mov  rbp, rsp
   ;guardar el estado de los registros que se modifican en esta 
   ;subrutina y que no se utilizan para devolver valores.	

   condition_if:
      cmp BYTE[charac], 'k'                     ; comparar charac con "k"
      jne condition_else                        ; Si no se cumple == (JNE), salta a condition_else
      cmp DWORD[colCursor], 0                   ; Siguiente comparacion con colCursor, 0
      jle condition_else                        ; JLE (opposite), jump a condition_else
      dec DWORD[colCursor]                      ; Reducimos colCursor--
      jmp condition_end_if                      ; Para prevenir el ingreso en el segundo bloque hacemos "jmp condition_end_if"
   condition_else:
      cmp BYTE[charac], 'l'                     ; Hacemos lo mismo, comparar charac=='l'
      jne condition_end_if                      ; Opposite (not equal), jump condition_end_if
      cmp DWORD[colCursor], COLSMATRIX-1        ; Comparar colCursor < COLSMATRIX-1
      jge condition_end_if                      ; Si se cumple el opuesto (jge), saltamos a condition_end_if
      inc DWORD[colCursor]                      ; Incrementamos colCursor en +1 (colCursor++)
   condition_end_if: 
   
   moveCursorP1_end:  
   ;restaurar el estado de los registros que se han guardado en la pila.
   
   mov rsp, rbp
   pop rbp
   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Inserta el disco (discSymbol) del jugador en la columna donde está 
; el cursor (colCursor) y en la primera fila libre de esa columna.
; La primera fila libre (row) de una columna dentro de la matriz (mBoard) 
; la tenemos guardada en la columna (colCursor) del vector (freeRowXcol)
; (freRowXcol[colCursor]).
; Si podemos introducir el disco (row>=0):
;   Si el estado del juego es (state==1) el (discSymbol = discSymbolPLAYER1),
;   si el estado del juego es (state==2) el (discSymbol = discSymbolPLAYER2).
;   Colocar el símbolo (discSymbol) en la matriz (mBoard) en la primera fila 
;   libre (row) y en la columna donde está el cursor (colCursor).
;   Decrementar la fila libre del vector (freeColXrow) de la columna donde
;   hemos insertado el disco (colCursor).
;   Cambiar de jugador, de jugador 1 a jugador 2 y de jugador 2 a jugador 1
;   (state = 3 - state).
; Si no queda espacio en esa columna (row=-1) no insertamos el disco.
; Devolver estado del juego.
; 
; Variables globales utilizadas:	
; (row)        : Fila de la matriz mBoard.
; (colCursor)  : Columna donde está el cursor.
; (freeRowXcol): Dirección de la matriz que indica la primera fila libre de cada columna del tablero.
; (mBoard)     : Dirección de la matriz donde guardamos los discos introducidos. 
; (discSymbol) : Símbolo del jugador que está jugando.
; (state)      : Estado del juego.
; (newState)   : Estado del juego.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
insertDiscP1:
   push rbp
   mov  rbp, rsp
   ;guardar el estado de los registros que se modifican en esta 
   ;subrutina y que no se utilizan para devolver valores.	
   
   push rsi						; Set registro rsi en pila (4 bytes, desplazamiento)
   push rax						; Set registro rax en pila (4 bytes)

   mov rsi, 4                                           ; Cargamos valor 4 en el rsi para calcular desplazamientos
   imul esi, DWORD[colCursor]                           ; Multiplicamos esi*DWORD[colCursor] (mismas dimensiones)
   mov eax, DWORD[freeRowXcol+esi]                      ; Anhadimos desplazamiento
   mov DWORD[row], eax                                  ; Asignamos el valor desplazado en row
   cmp DWORD[row], 0                                    ; Compara 'row' con 0 (if positive)
   jl termina_end_if                                    ; Condicion opuesta (less)
   cmp DWORD[state], 1                                  ; Comparamos de nuevo (state==1)
   jne condition_else_2                                 ; Condicion opuesta (not equal)
      mov BYTE[discSymbol], DISCSYMBOLPLAYER1           ; Si se cumple, asignamos el conteindo a discSymbol
      jmp termina_end_if_2                              ; Terminamos saltando a 'termina_end_if_2'
   condition_else_2:					; Else
      mov BYTE[discSymbol], DISCSYMBOLPLAYER2           ; Asignamos el contenido con el player 2
   termina_end_if_2:
      mov rsi, COLSMATRIX                               ; Metemos COLSMATRIX en rsi
      imul esi, DWORD[row]                              ; Multiplicamos esi*DWORD[row], para desplazamiento
      add esi, DWORD[colCursor]                         ; Sumamos para calcular la posicion especifica
      mov al, BYTE[discSymbol]                          ; Cargamos simbolo del registro         
      mov BYTE[mBoard+esi], al                          ; En la posicion mBoard+esi (calculada) metemos el simbolo del registro al
      mov rsi, 4                                        ; Hacemos set de nuevo rsi, 4
      imul esi, DWORD[colCursor]                        ; Multiplicamos por 4 (salto unidades, integer)
      dec DWORD[freeRowXcol+esi]                        ; Reducimos freeRowXcol-- (-1)
      mov rax, 3                                        ; Hacemos set de nuevo rax, 3
      sub eax, DWORD[state]                             ; Calculamos state-3
      mov DWORD[newState], eax                          ; Guardamos el contenido en newstate
   termina_end_if:

  insertDiscP1_end:
  ;restaurar el estado de los registros que se han guardado en la pila.
  
  mov rsp, rbp
  pop rbp
  ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Verificar si el tablero está lleno y no se puede continuar jugando.
; El tablero está lleno si la primera fila libre de todas las columnas
; indicada en el vector (freeRowXcol) son -1.
; Si se recorre todo el vector (freeRowXcol) y todas las posiciones
; valen -1, (c==COLSMATRIX) pondremos (state=5) para indicar que
; el tablero está lleno y no se puede continuar jugando.
; 
; Variables globales utilizadas:	
; (freeRowXcol): Dirección de la matriz que indica la primera fila libre de cada columna del tablero.
; (state)      : Estado del juego.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
checkEndP1:
   push rbp
   mov  rbp, rsp
   ;guardar el estado de los registros que se modifican en esta 
   ;subrutina y que no se utilizan para devolver valores.	
   
   mov rax, 0   			      ; Set registro rax para la variable c (integer, 4 bytes)
   beginning_loop:
      cmp eax, COLSMATRIX   	; Comparar c < COLSMATRIX
      jge ending_loop		   ; Si eax >= COLSMATRIX, termina el bucle
      mov esi, eax   		   ; Copiamos "c" para calcular el desplazamiento, lo trasladamos a rsi (4 bytes)
                              ; El calculo por desplazamiento es c*4 en este caso (integer)         
      shl esi, 2   		      ; Multiplicamos esi*4
      cmp DWORD[freeRowXcol+esi], -1    ; Comparamos freeRowXcol[c]==-1
      jne ending_loop   		; Si no es igual, salimos del loop
      inc eax   			      ; Si se cumplen las condiciones anteriores
                              ; Se incrementa c++ en el registro eax
                  
      jmp beginning_loop		; Vuelve al inicio del bucle despues de hacer c++
   ending_loop:

      cmp eax, COLSMATRIX	   ; Comparamos c con COLSMATRIX para saber si se realizo correctamente el loop
      jne ending_if		      ; Si no son iguales, salta al final del if	 
      mov DWORD[state], 5	   ; Si son iguales, almacena el valor state=5
   ending_if:
   checkEndP1_end:
   ;restaurar el estado de los registros que se han guardado en la pila.
   		
   mov rsp, rbp
   pop rbp
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Mostrar el tablero de juego en la pantalla. Las líneas del tablero.
; 
; Variables globales utilizadas:	
; (rowScreen): Fila de la pantalla donde posicionamos el cursor.
; (colScreen): Columna de la pantalla donde posicionamos el cursor.
; 
; Parámetros de entrada: 
; Ninguno.
; 
; Parámetros de salida: 
; Ninguno.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
printBoardP1:
   push rbp
   mov  rbp, rsp
   ;guardamos el estado de los registros del procesador porque
   ;las funciones de C no mantienen el estado de los registros.
   push rax
   push rbx
   push rcx
   push rdx
   push rsi
   push rdi
   push r8
   push r9
   push r10
   push r11
   push r12
   push r13
   push r14
   push r15

   call printBoardP1_C
 
   ;restaurar el estado de los registros que se han guardado en la pila.
   pop r15
   pop r14
   pop r13
   pop r12
   pop r11
   pop r10
   pop r9
   pop r8
   pop rdi
   pop rsi
   pop rdx
   pop rcx
   pop rbx
   pop rax

   mov rsp, rbp
   pop rbp
   ret
 
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Mostrar un mensaje en la parte inferior del tablero según el 
; valor de la variable (state).
; (state) 0: Se ha presionado ESC para salir 
;         1: Juega el jugador 1.
;         2: Juega el jugador 2.
;         3: El jugador 1 ha hecho 4 en línea.
;         4: El jugador 2 ha hecho 4 en línea.
;         5: El tablero está lleno. Empate.
; 
; Variables globales utilizadas:	
; (state): Estado del juego.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
printMessageP1:
   push rbp
   mov  rbp, rsp
   ;guardamos el estado de los registros del procesador porque
   ;las funciones de C no mantienen el estado de los registros.
   push rax
   push rbx
   push rcx
   push rdx
   push rsi
   push rdi
   push r8
   push r9
   push r10
   push r11
   push r12
   push r13
   push r14
   push r15

   call printMessageP1_C
 
   ;restaurar el estado de los registros que se han guardado en la pila.
   pop r15
   pop r14
   pop r13
   pop r12
   pop r11
   pop r10
   pop r9
   pop r8
   pop rdi
   pop rsi
   pop rdx
   pop rcx
   pop rbx
   pop rax

   mov rsp, rbp
   pop rbp
   ret



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Función principal del juego
; Mostrar el tablero de juego y permitir hacer las jugadas de los 2 jugadores,
; alternativamente, hasta que uno de los dos jugadores ponga 4 discos en línea
; o el tablero quede lleno y nadie haya hecho ninguna línea de 4.
; 
; Pseudo-código:
; Mientras estén jugando el jugador 1 (state=1) o el jugador 2 (state = 2) hacer:
;   Mostrar las líneas del tablero llamando a la subrutina printBoardP2.
;   Actualizar el estado del tablero llamando a la subrutina updateBoardP2.
;   Mostrar un mensaje según el estado del juego (state) llamando 
;   a la subrutina printMessageP2.
;   Si (state==1) asignar a (discSymbol) el símbolo del jugador 1
;   (DISCSYMBOLPLAYER1='X'), si no, el símbolo del jugador 2
;   (DISCSYMBOLPLAYER2='O').
;   Leer una tecla llamando a la subrutina getchP2.
;   Si la tecla leída es 'k' o 'l' mover el cursor sin salir del
;   tablero llamando a la subrutina moveCursorP2.
;   Si la tecla leída es ' ' 
;     Insertar el disco en el tablero (mBoard) en la columna actual del 
;     cursor (colCursor) llamando a la subrutina insertDiscP2.
;     Si se ha introducido el disco, (state != newState)
;       Verificar si el tablero está lleno 
;       llamando a la subrutina checkEndP2.
;       Si no, si se ha hecho 4 en raya o el tablero está lleno (state <= 2)
;       actualizar el estado del juego (state = newState).
;   Si la tecla es ESC (ASCII 27) poner (state=0) para indicarlo.
; Actualizar el estado del tablero llamando a la subrutina updateBoardP2.
; Mostrar un mensaje según el estado del juego (state) llamando 
; a la subrutina printMessageP2.
; Termina el juego.
; 
; Variables globales utilizadas:
; (colCursor)  : Columna donde está el cursor.
; (state)      : Estado del juego.
; (newState)   : Estado del juego.
; (discSymbol) : Símbolo del jugador que está jugando.
; (charac)     : Carácter que leemos del teclado.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
playP1:
   push rbp
   mov  rbp, rsp
   ;guardar el estado de los registros que se modifican en esta 
   ;subrutina y que no se utilizan para devolver valores.
   push rbx
   push r12

   mov DWORD[colCursor], 3    ;colCursor = 3;
   mov DWORD[state], 1        ;state = 1;
   playP1_while:
   cmp DWORD[state], 1        ;while (state == 1 
   je playP1_loop
     cmp DWORD[state], 2      ;|| state ==2  ) {
     jne playP1_endwhile
     playP1_loop:
       call printBoardP1      ;printBoardP1_C();
       call updateBoardP1     ;updateBoardP1_C();
       call printMessageP1    ;printMessageP1_C();
       cmp DWORD[state], 1
       jne playP1_else1       ;if (state == 1) 
         mov BYTE[discSymbol], DISCSYMBOLPLAYER1;discSymbol = DISCSYMBOLPLAYER1; 
         jmp playP1_endif1
         playP1_else1:        ;else 
         mov BYTE[discSymbol], DISCSYMBOLPLAYER2;discSymbol = DISCSYMBOLPLAYER2;
         playP1_endif1:
         call showDiscPosP1   ;showDiscPosP1_C();
         call getchP1         ;getchP1_C();
         mov bl, BYTE[charac]
         cmp bl, 'k'          ;if (charac == 'k'  || charac == 'l') {
         je  playP1_move
           cmp bl, 'l'
           jne playP1_endmove
           playP1_move:
             call moveCursorP1;colCursor = moveCursorP1_C();
         playP1_endmove:      ;}
         cmp bl, ' '          ;if (charac == ' ' ) {
         jne playP1_endinsert
           call insertDiscP1       ;insertDiscP1_C();
           mov r12d, DWORD[newState]
           cmp DWORD[state], r12d         ;if(state != newState){ //new disc inserted
           je  playP1_notinserted
             call checkEndP1       ;checkEndP1_C();
           playP1_notinserted:     ;}
         cmp DWORD[state], 2       ;if (state <= 2) 
         jg  playP1_newstate
           mov DWORD[state], r12d  ;state = newState;
         playP1_newstate:
       playP1_endinsert:      ;}
       cmp bl, 27             ;if (charac == 27) {
       jne playP1_noesc
         mov DWORD[state], 0  ;state = 0;
       playP1_noesc:          ;}
     jmp playP1_while 
   playP1_endwhile:           ;}
   call updateBoardP1         ;updateBoardP1_C();
   call printMessageP1        ;printMessageP1_C();  

   playP1_end: 
   ;restaurar el estado de los registros que se han guardado en la pila.
   pop r12
   pop rbx

   mov rsp, rbp
   pop rbp
   ret
