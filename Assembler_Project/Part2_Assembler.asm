section .note.GNU-stack noalloc noexec nowrite progbits
section .data               
;Cambiar Nombre y Apellido por vuestros datos.
developer db "_Nombre_ _Apellido_",0

;Constante que también está definida en C.
ROWSMATRIX equ 6
COLSMATRIX equ 7
DISCSYMBOLPLAYER1 equ 'X'
DISCSYMBOLPLAYER2 equ 'O'

section .text            
;Variables definidas en ensamblador.
global developer                        

;Subrutinas de ensamblador que se llaman desde C.
global calcIndexP2, updateBoardP2, showDiscPosP2, moveCursorP2, insertDiscP2
global checkLineP2, checkEndP2, playP2

;Funciones de C que se llaman desde ensamblador.
extern gotoxyP2_C, printchP2_C, getchP2_C
extern printBoardP2_C, printMessageP2_C

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ATENCIÓN: Recordad que en ensamblador las variables y los parámetros 
;;   de tipo 'char' se deben asignar a registros de tipo  
;;   BYTE (1 byte): al, ah, bl, bh, cl, ch, dl, dh, sil, dil, ..., r15b
;;   los de tipo 'short' se deben asignar a registros de tipo 
;;   WORD (2 bytes): ax, bx, cx, dx, si, di, ...., r15w
;;   los de tipo 'int' se deben asignar a registros de tipo 
;;   DWORD (4 bytes): eax, ebx, ecx, edx, esi, edi, ...., r15d
;;   los de tipo 'long' se deben asignar a registros de tipo 
;;   QWORD (8 bytes): rax, rbx, rcx, rdx, rsi, rdi, ...., r15
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Las subrutinas en ensamblador que se deben modificar para
;; implementar el paso de parámetros son:
;;   calcIndexP2, updateBoardP2, showDiscPosP2
;;   moveCursorP2, insertDiscP2
;; La subrutina que se debe modificar la funcionalidad:
;;   checkEndP2
;; La subrutina que se debe implementar:
;;   checkLineP2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Esta subrutina se da hecha. NO LA PODEIS MODIFICAR.
; Situar el cursor en una fila y una columna de la pantalla
; en función de la fila (edi) y de la columna (esi) recibidos como 
; parámetro llamando a la función gotoxyP2_C.
; 
; Variables globales utilizadas:	
; Ninguna
; 
; Parámetros de entrada: 
; (rowScreen): rdi(edi) : Fila de la pantalla donde se sitúa el cursor.
; (colScreen): rsi(esi) : Columna de la pantalla donde se sitúa el cursor.
;
; Parámetros de salida: 
; Ninguno
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gotoxyP2:
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

   ; Cuando llamamos a la función gotoxyP2_C(int row_num, int col_num) desde ensamblador 
   ; el primer parámetro (row_num) debe pasarse por el registro rdi(edi), y
   ; el segundo  parámetro (col_num) debe pasarse por el registro rsi(esi).	
   call gotoxyP2_C
 
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
; Esta subrutina se da hecha. NO LA PODEIS MODIFICAR.
; Mostrar un carácter (dil) en la pantalla, recibido como parámetro, 
; en la posición donde está el cursor llamando a la función printchP2_C.
; 
; Variables globales utilizadas:	
; Ninguna
; 
; Parámetros de entrada: 
; (c) : rdi(dil) : Carácter a mostrar.
; 
; Parámetros de salida: 
; Ninguno
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
printchP2:
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

   ; Cuando llamamos a la función printchP2_C(char c) desde ensamblador, 
   ; el parámetro (c) debe pasarse por el registro rdi(dil).
   call printchP2_C
 
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
; Esta subrutina se da hecha. NO LA PODEIS MODIFICAR.
; Leer una tecla y retornar el carácter asociado (al) sin 
; mostrarlo por pantalla, llamando a la función getchP2_C.
; 
; Variables globales utilizadas:	
; Ninguna
; 
; Parámetros de entrada: 
; Ninguno
; 
; Parámetros de salida: 
; (c) : rax(al) : Carácter leído desde el teclado.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
getchP2:
   push rbp
   mov  rbp, rsp
   ;guardamos el estado de los registros del procesador porque
   ;las funciones de C no mantienen el estado de los registros.
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
   
   mov rax, 0
   ; Cuando llamamos a la función getchP2_C desde ensamblador, 
   ; retorna sobre el registro rax(al) el carácter leído
   call getchP2_C
 
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
   
   mov rsp, rbp
   pop rbp
   ret 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; **** Esta función no es necesaria en C, solo en ensamblador.****
; Calcular el índice para acceder a la matriz (mBoard) en ensamblador.
; (mBoard[row][col]) en C, es ([mBoard+indexMat]) en ensamblador.
; donde indexMat = row*COLSMATRIX+col.
; La matriz (mBoard) es de tipo char(BYTE)1byte.
; Recibe la fila (row) y la columna (col) como parámetros y retorna 
; el índice (indexMat) para acceder a la matriz.
; 
; Variables globales utilizadas:	
; Ninguna.
; 
; Parámetros de entrada:
; (row) :rdi(edi): Fila de la matriz mBoard.
; (col) :rsi(esi): Columna de la matriz mBoard.
; 
; Parámetros de salida: 
; (indexMat) :rax(rax): Índice para acceder a la matriz mBoard. (ok)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
calcIndexP2:
   push rbp
   mov  rbp, rsp
   ;guardar el estado de los registros que se modifican en esta 
   ;subrutina y que no se utilizan para retornar valores.
   
   mov rax, COLSMATRIX        ; Copiar contenido COLSMATRIX (cte) en rax pra realizar las operaciones
   imul eax, edi              ; Hacemos la multiplicacion eax=row*COLSMATRIX
                              ; row es un entero de 4 bytes (DWORD)
   add eax, esi               ; Hacemos la suma eax=row*COLSMATRIX+col
                              ; para calcular el indice linear de la matriz
      
   calcIndexP2_end:  
   ;restaurar el estado de los registros que se han guardado en la pila.
   	
   mov rsp, rbp
   pop rbp
   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Mostrar los valores de la matriz (mBoard), recibida como parámetro,
; dentro del tablero, en las posiciones correspondientes. 
; Se debe recorrer toda la matriz (mBoard), de izquierda a derecha y 
; de arriba a abajo, desde la posición [0][0]=(0) a la posición [5][6]=(41),
; cada posición es de tipo char(BYTE)1byte, y para cada elemento hacer:
; Posicionar el cursor en el tablero en función de las variables 
; (rowScreen) fila y (colScreen) columna llamando a la subrutina gotoxyP2.
; Las variables (rowScreen) y (colScreen) se inicializarán en 7 y 8, 
; respectivamente, que es la posición en pantalla de la casilla [0][0].
; Las filas se incrementan de 2 en 2 y las columnas de 4 en 4.
; Mostrar los caracteres de cada posición de la matriz (mBoard) llamando
; a la subrutina printchP2.
;  
; Variables globales utilizadas:	
; Ninguna.
; 
; Parámetros de entrada:
; (mBoard):rdi(rdi): Dirección de la matriz donde guardamos los discos introducidos. 
; 
; Parámetros de salida: 
; Ninguno. (ok)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
updateBoardP2:
   push rbp
   mov  rbp, rsp
   ;guardar el estado de los registros que se modifican en esta 
   ;subrutina y que no se utilizan para retornar valores.

         push r11                         ; colScreen. Almacenamos registro en la pila
         push r12                         ; rowScreen
         push r13                         ; Almacenamos registro en la pila
         push r14
         push r15
         push rsi                         
         push rdi


         mov r13, 7                       ; Asignamos el valor 7 al registro r13, rowScreen = 7
         mov r11, rdi                     ; almacenamos el puntero a mBoard en r11

         xor r15, r15                     ; Inicializamos r15 (i=0)

      loop_for_i: cmp r15d, ROWSMATRIX    ; Inicializamos bucle externo (i=0;i<ROWSMATRIX;i++)
                                          ; Comparamos i con ROWSMATRIX
                  jge end_loop_for_i      ; Si pasa el complementario (>=) salimos
                  mov esi, 8              ; Inicializamos colScreen = 8
                  xor r14, r14            ; Inicializamos r14 (j=0)

         loop_for_j: cmp r14d, COLSMATRIX ; Inicializamos bucle interno (j=0;j<COLSMATRIX;j++)
                                          ; Comparamos j con COLSMATRIX
                     jge end_loop_for_j   ; Si pasa el complementario (>=) salimos
                     mov edi, r13d        ; Inicializamos edi = rowScreen
                     call gotoxyP2        ; Llamamos funcion gotoxyP2

                     mov r12, COLSMATRIX  ; Almacenamos COLSMATRIX en r12 para calcular el desplazamiento
                     imul r12d, r15d      ; Multiplicamos para calcular el desplazamiento COLSMATRIX*i
                     add r12d, r14d       ; Sumamos r12 = COLSMATRIX*i+j para el desplazamiento final

                     mov dil, BYTE[r11+r12] ; dil = mBoard[i][j] (1 byte)
                     call printchP2         ; Llamamos funcion printchP2
                     add esi, 4             ; colScreen = colScreen + 4
                     inc r14d               ; j = j+1
                     jmp loop_for_j         ; Vuelve al inicio del bucle loop_for_j
         end_loop_for_j:                  ; Terminamos bucle loop_for_j
                     add r13d, 2          ; rowScreen = rowScreen + 2 para siguiente fila
                     inc r15d             ; i = i+1
                     jmp loop_for_i       ; Jump beginning of loop_for_i
      end_loop_for_i:

         pop rdi                          ; Restaurar registro de la pila
         pop rsi
         pop r15
         pop r14
         pop r13
         pop r12
         pop r11                          ; Restaurar registro de la pila



         
   
     
   updateBoardP2_end:  
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
; en la fila donde caerá el disco si se pulsa espacio.
; (rowScreen = 7+freeRowXcol[colCursor]*2)
; La matriz freeRowXcol es de tipo int(DWORD)4bytes.
; Posicionar el cursor en el tablero en función de las variables 
; (rowScreen) fila y (colScreen) columna llamando a la subrutina gotoxyP2.
; Mostrar el símbolo (discSymbol) llamando a la subrutina printchP2.
;  
; Variables globales utilizadas:	
; Ninguna.
; 
; Parámetros de entrada:
; (discSymbol) :rdi(dil): Símbolo del jugador que está jugando.
; (colCursor)  :rsi(esi): Columna donde está el cursor.
; (freeRowXcol):rdx(rdx): Dirección de la matriz que indica la primera fila libre de cada columna del tablero.
; 
; Parámetros de salida: 
; Ninguno. (ok)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
showDiscPosP2:
   push rbp
   mov  rbp, rsp
   ;guardar el estado de los registros que se modifican en esta 
   ;subrutina y que no se utilizan para retornar valores.	
   
      push rsi                      ; Almacenar registro en pila
      push rdi
      push r14
      push r15                      

      xor r14, r14                  ; Declaramos registro r14
      xor r15, r15                  ; Declaramos registro r15
      mov r15d, esi                 ; Almacenamos el valor de colCursor en r15d
      mov r14b, dil                 ; Almacenamos dil (discSymbol) en r14b

      mov rdi, 5                    ; rowScreen = 5
      mov rsi, 4                    ; Almacenamos 4 en el registro rsi (colScreen)
      imul esi, r15d                ; colCursor * 4
      add esi, 8                    ; colScreen = colCursor*4+8
      call gotoxyP2                 ; Llamamos gotoxyP2

      mov dil, r14b                 ; Almacenamos registro 14b (discSymbol) en dil
      call printchP2                ; Llamamos funcion printchP2
      imul r15d, 4                  ; Calculamos colCursor*4 (para el desplazamiento)
      mov rdi, 2                    ; Asignamos rdi = 2
      imul edi, DWORD[rdx+r15]      ; Calculamos freeRowXcol[colCursor]*2
      add edi, 7                    ; rowScreen = freeRowXcol[colCursor]*2+7
      call gotoxyP2                 ; Llamamos gotoxyP2

      pop r15                       ; Restauramos valores registros
      pop r14                       ; Restauramos valores registros
      pop rdi
      pop rsi                       ; Restauramos valores registros

   showDiscPosP2_end:  
   ;restaurar el estado de los registros que se han guardado en la pila.
   
   mov rsp, rbp
   pop rbp
   ret
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Actualizar la columna donde está el cursor (colCursor).
; Si se ha leído (charac=='k') izquierda o (charac=='l') derecha 
; actualizar la posición del cursor (colCursor +/- 1)
; controlando que no salga del tablero [0..(COLSMATRIX-1)]. 
; Retornar el valor actualizado de (colCursor).
;  
; Variables globales utilizadas:	
; Ninguna
; 
; Parámetros de entrada: 
; (charac)   :rdi(dil): Carácter leído desde el teclado.
; (colCursor):rsi(esi): Columna donde está el cursor.
; 
; Parámetros de salida: 
; (colCursor):rax(eax):  Columna donde está el cursor actualizada. (aqui, ok)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
moveCursorP2:
   push rbp
   mov  rbp, rsp
   ;guardar el estado de los registros que se modifican en esta 
   ;subrutina y que no se utilizan para retornar valores.	
      mov eax, esi                     ; Almacenar el valor de colCursor en eax
      cmp dil, 'k'                     ; Comparar el caracter leido con "k"
      jne else                         ; Si no es igual, saltar a "else"
      cmp esi, 0                       ; Comparamos colCursor con 0
      jle else                         ; Si esi <= 0, saltar a "else"
      dec eax                          ; Reducir eax en 1
      jmp end_if                       ; Saltamos a "end_if"
   else:
      cmp dil, 'l'                     ; Comparamos el caracter con "l"
      jne end_if                       ; Si no es igual saltamos a "end_if"
      cmp esi, COLSMATRIX-1            ; Comparamos colCursor con COLSMATRIX-1
      jge end_if                       ; Si colCursor >= COLSMATRIX-1 saltamos a "end_if"
      inc eax                          ; Incrementamos colCursor en 1
   end_if:
   
   
   
   moveCursorP2_end:  
   ;restaurar el estado de los registros que se han guardado en la pila.
   		
   mov rsp, rbp
   pop rbp
   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Insertar el disco (discSymbol) del jugador en la columna donde está 
; el cursor (colCursor) y en la primera fila libre de esa columna.
; La primera fila libre (row) de una columna dentro de la matriz (mBoard) 
; la tenemos guardada en la columna (colCursor) del vector (freeRowXcol)
; (freeRowXcol[colCursor]).
; Si podemos introducir el disco (row>=0):
;   Si el estado del juego es (state==1) el (discSymbol = discSymbolPLAYER1),
;   si el estado del juego es (state==2) el (discSymbol = discSymbolPLAYER2).
;   Poner el símbolo (discSymbol) en la matriz (mBoard) en la primera fila 
;   libre (row) y en la columna donde está el cursor (colCursor).
;   Decrementar la fila libre del vector (freeColXrow) de la columna donde
;   hemos insertado el disco (colCursor).
;   Cambiar de jugador, de jugador 1 a jugador 2 y de jugador 2 a jugador 1
;   (state = 3 - state).
; Si no queda espacio en esa columna (row=-1) no insertamos el disco.
; Retornar estado del juego.
; 
; Variables globales utilizadas:	
; Ninguna
; 
; Parámetros de entrada: 
; (colCursor)  :rdi(edi): Columna donde está el cursor.
; (mBoard)     :rsi(rsi): Dirección de la matriz donde guardamos los discos introducidos. 
; (freeRowXcol):rdx(rdx): Dirección de la matriz que indica la primera fila libre de cada columna del tablero.
; (state)      :rcx(ecx): Estado del juego.
; 
; Parámetros de salida: 
; (state)      :rax(eax): Estado del juego. (ok)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
insertDiscP2:
   push rbp
   mov  rbp, rsp
   ;guardar el estado de los registros que se modifican en esta 
   ;subrutina y que no se utilizan para retornar valores.	

      push r12                            ; Almacenamos registro en pila
      push r13                            ; Almacenamos registro en pila
      push r14                            ; Almacenamos registro en pila
      push r15                            ; Almacenamos registro en pila
      
      xor r12, r12                        ; Declaramos r12

      mov eax, ecx                        ; Almacenamos contenido de ecx en eax
      mov r12d, edi                       ; Almacenamos colCursor en r12d
      shl r12d, 2                         ; Calculamos offset colCursor = colCursor*4
      mov r15d, DWORD[rdx+r12]            ; Almacenamos freeRowXcol[colCursor] en r15d

      cmp r15d, 0                         ; Comparamos freeRowXcol[colCursor] con 0
      jl end_if_2                         ; Si <0, saltamos end_if_2 (si la columna esta llena)

      mov r14, DISCSYMBOLPLAYER2          ; Almacenamos simbolo jugador 2 en registro r14
      cmp eax, 1                          ; Comparamos el state con 1
      jne else_2                          ; Si state != 1, saltamos a else_2
      mov r14, DISCSYMBOLPLAYER1          ; Si state == 1, almacenamos el simbolo del jugador 1 en registro r14
   
   else_2:
      
      mov r13, COLSMATRIX                 ; Almacenamos COLSMATRIX en r13 (para calcular posicion)
      imul r13d, r15d                     ; Calculamos row*COLSMATRIX (desplazamiento)
      add r13d, edi                       ; Calculamos row*COLSMATRIX+colCursor (posicion calculada)
      mov BYTE[rsi+r13], r14b             ; Asignamos el valor de r14b a la posicion calculada de mBoard

      dec DWORD[rdx+r12]                  ; Disminuimos freeRowXcol[colCursor] - 1
      mov eax, 3                          ; Almacenamos 3 en eax
      sub eax, ecx                        ; state = state-3 (para alternar estados entre jugadores 1 y 2)

   end_if_2:

      pop r15                             ; Restaurar registro
      pop r14                             ; Restaurar registro
      pop r13                             ; Restaurar registro
      pop r12                             ; Restaurar registro

   insertDiscP2_end:
   
   ;restaurar el estado de los registros que se han guardado en la pila.
  		
   mov rsp, rbp
   pop rbp
   ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Comprobar si el nuevo disco introducido, en la fila (row), columna (col)
; de la matriz (mBoard), hace 4 en línea (fourINaLINE=1) en alguna 
; dirección: diagonal, horizontal o vertical, indicada con el valor 
; que se debe modificar la posición actual (row, col) para seguir 
; esa dirección en la matriz (direction).
; dirección:  0    1      2    3      4    5      6    7
;         { -1 , +1  ,  +1 , -1  ,   0 ,  0  ,  -1 , +1  } //modificación de la fila
;         { -1 , +1  ,  -1 , +1  ,  -1 , +1  ,   0 ,  0  } //modificación de la columna
;         (izq./der.)(izq./der.)(izq./der.)(izq./der.) //(leftright: izq.=0, der.=1)
;          diagonal 1  diagonal 2  horizontal  vertical
; La línea de 4 (discsINaLINE==4), respecto a la posición actual (X) 
; puede estar, para cada dirección: a la izquierda XXX(X), a la derecha (X)XXX 
; o ambos lados XX(X)X o X(X)XX.
; Obtenemos el símbolo de la posición actual del cursor (discSymbol = mBoard[row][col]).
; Para obtener el índice para acceder a la matriz (mBoard) llamamos a la 
; subrutina calcIndexP2.
; Mientras no hagamos 4 en línea (fourINaLINE==0) y no hayamos mirado todas las direcciones (dir<8) hacer:
;   Si miramos a la izquierda de la posición actual (leftright==0) 
;     contamos 1 disco (discsINaLINE=1)(el que acabamos de poner).
;     si estamos mirando a la derecha (leftright==1) no modificamos 
;     (discsINaLINE) y continuamos contando fichas iguales.
;   Mientras podamos continuar buscando en esa dirección (exit==0)
;     Obtenemos la posición de la casilla que queremos mirar (nextRow, nextCol)
;     con el incremento indicado en la matriz (direction) de la dirección 
;     que estamos mirando (dir).
;     (nextRow = nextRow + direction[0][dir])(nextCol = nextCol + direction[1][dir])
;     Si la fila o la columna está fuera del tablero
;     ((nextRow < 0) || (nextRow >= ROWSMATRIX)) y
;     ((nextCol < 0) || (nextCol >= COLSMATRIX))
;     dejamos de buscar en esa dirección (exit=1).
;     Si está dentro del tablero, miramos si el símbolo que hay en esa 
;     casilla (mBoard[nextRow][nextCol]) es el mismo símbolo
;     que la casilla inicial (discSymbol), para obtener el índice para 
;     acceder a la matriz (mBoard) llamamos a la subrutina calcIndexP2.
;     si es el mismo símbolo incrementamos (discsINaLINE),
;     si no es el mismo, dejamos de buscar en esa dirección (exit=1).
;   Si estábamos buscando hacia la izquierda (leftright==0) pasaremos 
;   a buscar a la derecha (leftright=1),   
;   si no, pasaremos a buscar a la izquierda (leftright=0),
;   en una nueva dirección (dir++) de la matriz (direction).
;   Si (discsINaLINE==4), tenemos una línea de 4, 
;   lo indicamos poniendo (fourINaLINE=1).
; retornamos (fourINaLINE) para indicar si hemos encontrado un 4 en línea o no.
; 
; Variables globales utilizadas:	
; Ninguna
; 
; Parámetros de entrada: 
; (row)      :rdi(edi): Fila donde hemos insertado el disco.
; (col)      :rsi(esi): Columna donde hemos insertado el disco.
; (direction):rdx(rdx): Dirección de la matriz que indica el incremento que se debe hacer a la posición actual para seguir una dirección.
; (mBoard)   :rcx(rcx): Dirección de la matriz donde guardamos los discos introducidos. 
;  
; Parámetros de salida: 
; (fourINaLINE):rax(al): Indica si hemos hecho 4 en línea (1) o no (0). (ok)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
checkLineP2:
   push rbp
   mov  rbp, rsp
   ;guardar el estado de los registros que se modifican en esta 
   ;subrutina y que no se utilizan para retornar valores.	

   push rbx                                              ; Activar registro
   push r8                      
   push r9                      
   push r10                      
   push r11                      
   push r12                      
   push r13                      
   push r14                       
   push r15                      

   xor r9, r9                                          ; Declarar a 0        
   xor r10, r10                  
   xor r11, r11                  
   xor r12, r12                  
   xor r13, r13                  
   xor r14, r14                  
   xor r15, r15                                          ; Declarar a 0                  

   mov r8, COLSMATRIX                                    ; Almacenamos COLSMATRIX en r8
   imul r8d, edi                                         ; r8 = row * COLSMATRIX para calcular desplazamiento
   add r8d, esi                                          ; r8 = row * COLSMATRIX + col para calcular la posicion de mBoard
   mov r12b, BYTE[rcx+r8]                                ; Cargamos el simbolo del disco

   loop_one:                                             ; loop "fourINaLINE == 0 && dir < 8"
      cmp r11b, 0                                        ; Comprobamos si fourINaLINE == 0
      jne end_loop_one                                   ; Si no es asi, salimos del loop principal (loop_one)
      cmp r10, 8                                         ; Comprobamos dir, 8 (para comprobar las direcciones)
      jge end_loop_one                                   ; Si r10 >= 8 salimos del bucle principal (loop_one)

      mov r14d, edi                                      ; Almacenamos en r14 la fila (nextRow)
      mov r13d, esi                                      ; Almacenamos en r13 la columna (nextCol)

      xor rbx, rbx                                       ; Reiniciamos rbx (final de busqueda)

      cmp r9d, 0                                         ; Comprobamos la direccion (left = 0, right =1) para inicializar
                                                         ; discsINaLINE
      jne salto                                          ; Si es derecha, saltamos a salto
      mov r15d, 1                                        ; Almacenamos discsINaLINE = 1

   salto:
   loop_two:                                          ; while (exit == 0)
      cmp rbx, 0                                      ; Comparamos rbx con 0
      jne end_loop_two                                ; Si exit no es igual, saltamos al final de loop_two (la busqueda termino)

      mov r8, r10                                     ; Obetenemos direccion cargando dir en r8
      shl r8, 2                                       ; Multiplicamos r8*4 (integer)
      add r14d, DWORD[rdx+r8]                         ; Actualizamos la fila (nextRow = row + direction)

      cmp r14d, 0                                     ; Comprobamos comparando r14d con cte
      jl label_nextRow                              ; Si nextRow < 0 saltamos a conditional one
      cmp r14d, ROWSMATRIX                            ; Comparamos nextRow con ROWSMATRIX
      jge label_nextRow                             ; Si nextROw >= ROWSMATRIX, saltamos a conditional_one

      mov r8, 8                                       ; Actualizamos nextCol
      add r8, r10                                     ; Sumamos r8 = r8 + r10
      shl r8, 2                                       ; Multiplicamos dir*4
      add r13d, DWORD[rdx+r8]                         ; nextCol += direction


      cmp r13d, 0                                     ; Comparamos r13d (nextCol)
      jl label_nextCol                                ; Si nextCol < 0, saltamos a label_nextCol
      cmp r13d, COLSMATRIX                            ; Comparamos nextCol con COLSMATRIX
      jge label_nextCol                               ; Si nextCol >= COLSMATRIX, saltamos a label_nextCol



      mov r8, COLSMATRIX                              ; Calculamos el desplazamiento para nextRow y nextCol
      imul r8d, r14d                                  ; r8 = nextRow * COLSMATRIX
      add r8d, r13d                                   ; r8 = nextRow * COLSMATRIX + nextCol
      cmp BYTE[rcx+r8], r12b                          ; Comprobamos el simbolo de mBoard con discSymbol
      jne label_mBoard                                ; Si no es igual, saltamos a label_mBoard
      inc r15d                                        ; Incrementamos discsINaLINE r15 = r15 +1
      jmp end_label_mBoard                            ; Saltamos a end_label_mBoard
   label_mBoard:
      mov rbx, 1                                      ; Marcamos fin de la busqueda
   end_label_mBoard:
      jmp end_label_nextCol                           ; Saltamos a end_label_nextCol (continuamos)
   label_nextCol:
      mov rbx, 1                                      ; Marcamos fin busqueda
   end_label_nextCol:
      jmp end_label_nextRow                           ; Saltamos a end_label_nextRow
   label_nextRow:
      mov rbx, 1                                      ; Marcamos fin busqueda
   end_label_nextRow:
      jmp loop_two                                    ; Iniciamos el segundo bucle de nuevo
   end_loop_two:                                      ; Terminamos segundo bucle

      xor r9d, 1                                         ; Alternamos entre left (0) y right (1)
      inc r10d                                           ; Incrementamos dir r10 = r10 + 1
      cmp r15d, 4                                        ; Comprobamos discsINaLINE r15d con 4
      jl label_discsInALine                              ; Si es < volvemos al bucle principal label_discsInALine
      mov r11b, 1                                        ; Almacenamos "se consiguio un 4 en linea"

   label_discsInALine:                                ; Usamos el bucle "label_discsInALine" para entrar al loop_one
      jmp loop_one                                    ; (loop principal)
   end_loop_one:                                      ; Salimos del loop principal (loop_one)

      mov al, r11b                                       ; Almacenamos el resultado en al (fourINaLINE)
      
      pop r15                                             ; Restauramos registro
      pop r14                                             ; Restauramos registro
      pop r13
      pop r12
      pop r11
      pop r10
      pop r9
      pop r8
      pop rbx                                            ; Restauramos registro


   checkLineP2__end:  
   ;restaurar el estado de los registros que se han guardado en la pila.
   
   mov rsp, rbp
   pop rbp
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Verificar si el jugador que ha introducido el último disco ha hecho 
; 4 en línea o si el tablero está lleno y no se puede continuar jugando.
; Primero obtiene la primera fila (row) de la columna (colCursor) 
; de la matriz (mBoard) con disco, es la posición (colCursor) 
; del vector (freeRowXcol) + 1.
; Luego, llamando a la subrutina checkLineP2 comprobar si con el disco
; introducido, en la fila (row), columna (colCursor) de la matriz (mBoard), 
; hace 4 en línea en alguna dirección: diagonal, horizontal o vertical 
; y actualiza la variable (fourINaLine: 1 hay 4 en línea, 0 no).
; Si hay 4 en línea (fourINaLine==1) incrementamos (state) en 2 para 
; indicar que el jugador que ha introducido el disco gana.
; Si no, miraremos si el tablero está lleno.
;   El tablero está lleno si la primera fila libre de todas las columnas
;   indicado en el vector (freeRowXcol) son -1.
;   Si se recorre todo el vector (freeRowXcol) y todas las posiciones
;   valen -1, (c==COLSMATRIX) pondremos (state=5) para indicar que
;   el tablero está lleno y no se puede continuar jugando.
; Retornar el estado del juego.
; 
; Variables globales utilizadas:	
; Ninguna
; 
; Parámetros de entrada: 
; (freeRowXcol):rdi(rdi): Dirección de la matriz que indica la primera fila libre de cada columna del tablero.
; (colCursor)  :rsi(esi): Columna donde está el cursor.
; (direction)  :rdx(rdx): Dirección de la matriz que indica el incremento que se debe hacer a la posición actual para seguir una dirección.
; (mBoard)     :rcx(rcx): Dirección de la matriz donde guardamos los discos introducidos.
; (state)      :r8 (r8d): Estado del juego.
;  
; Parámetros de salida: 
; (state)      :rax(eax): Estado del juego. (ok)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
checkEndP2:
   push rbp
   mov  rbp, rsp
   ;guardar el estado de los registros que se modifican en esta 
   ;subrutina y que no se utilizan para retornar valores.	

   push r9                                      ; Declarar registro en pila
   push r10
   push r11
   push r12
   push r13
   push r14                                     ; Declarar registro en pila

   mov r13, 4                                   ; Declaramos r13 como cte (desplazamiento)
   imul r13d, esi                               ; r13 = r13*4 (para calcular desplazamiento de la columna)
                                                ; r13 = desplazamiento * 4
   xor r14, r14                                 ; Inicializamos r14
   mov r14d, DWORD[rdi + r13]                   ; Asignamos contenido en r14d

   inc r14d                                     ; Incrementamos r14 = r14 + 1
   mov r12, rdi                                 ; Direccion de la matriz para indicar primera fila libre

   mov edi, r14d                                ; Almacenamos r14d despues del incremento, en edi
   call checkLineP2                             ; Llamamos a checkLineP2
   cmp al, 1                                    ; Comprobar si checkLineP2 devolvio fourINaLINE == 1
   jne label_fourInALine                        ; Si no es igual, saltamos a label_fourInALine
   add r9d, 2                                   ; Si es igual, incrementamos r9d = r9d + 2
   jmp end_label_fourInALine                    ; Saltamos a end_label_fourInALine

   label_fourInALine:
      xor r14, r14                              ; Inicializamos de nuevo r14
   loop_fourInALine:                            ; while (freeRowXcol[c] == -1 && c < COLSMATRIX)
      mov r13, 4                                ; Almacenamos r13 = 4
      imul r13d, r14d                           ; Calculamos desplazamiento r13d = r14d*4
      mov r11d, DWORD[r12 + r13]                ; Calculamos r11d = freeRowXcol[c]
      cmp r11d, -1                              ; Si la celda esta vacia (-1)
      jne end_loop_fourInALine                  ; Si no esta vacia end_loop_fourInALine
      cmp r14d, COLSMATRIX                      ; Comprobar si las columnas se recorrieron (&& c< COLSMATRIX)
      jge end_loop_fourInALine                  ; Si r14 >= que COLSMATRIX saltamos a end_loop_fourInALine
      inc r14d                                  ; Incrementamos r14d = r14d + 1
      jmp loop_fourInALine                      ; Volvemos al inicio del bucle loop_four
   end_loop_fourInALine:                        ; Terminamos el bucle
   
      cmp r14d, COLSMATRIX                         ; Comprobar r14d == COLSMATRIX
      jne end_label_fourInALine                    ; Si no lo es, saltamos a end_label_fourInALine
      mov r9d, 5                                   ; Si lo es, almacenamos state r9d = 5

   end_label_fourInALine:

      mov eax, r9d                                 ; Devolvemos el valor en r9d
      
      pop r14                                       ; Restauramos registro
      pop r13
      pop r12
      pop r11
      pop r10
      pop r9

   
   checkEndP2_end:
   ;restaurar el estado de los registros que se han guardado en la pila.
  		
   mov rsp, rbp
   pop rbp
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Mostrar el tablero de juego en la pantalla. Las líneas del tablero.
; 
; Variables globales utilizadas:	
; Ninguna
; 
; Parámetros de entrada: 
; Ninguno.
; 
; Parámetros de salida: 
; Ninguno
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
printBoardP2:
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

   ;Llamamos a la función printBoardP2_C() desde ensamblador
   ;sin parámetros.
   call printBoardP2_C
 
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
; (state) 0: Se ha pulsado ESC para salir 
;         1: Juega el jugador 1.
;         2: Juega el jugador 2.
;         3: El jugador 1 ha hecho 4 en línea.
;         4: El jugador 2 ha hecho 4 en línea.
;         5: El tablero está lleno. Empate.
; 
; Variables globales utilizadas:	
; Ninguna
; 
; Parámetros de entrada: 
; (state): rdi(edi): Estado del juego.
; 
; Parámetros de salida: 
; Ninguno
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
printMessageP2:
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

   ; Cuando llamamos a la función printMessageP2_C(int state) desde ensamblador, 
   ; el parámetro (state) debe pasarse por el registro rdi(edi).
   call printMessageP2_C
 
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
; Muestra el tablero de juego y deja hacer las jugadas de los 2 jugadores,
; alternativamente, hasta que uno de los dos jugadores pone 4 discos en línea
; o el tablero queda lleno y nadie ha hecho ninguna línea de 4.
; 
; Pseudo-código:
; Mientras estén jugando el jugador 1 (state=1) o el jugador 2 (state = 2) hacer:
;   Mostrar las líneas del tablero llamando a la subrutina printBoardP2.
;   Actualizar el estado del tablero llamando a la subrutina updateBoardP2.
;   Mostrar un mensaje según el estado del juego (state) llamando 
;   a la subrutina printMessageP2.
;   Si (state==1) asignar a (discSymbol) el símbolo del jugador 1
;   (DISCSYMBOLPLAYER1='X'), sino el símbolo del jugador 2
;   (DISCSYMBOLPLAYER1='O').
;   Leer una tecla llamando a la subrutina getchP2.
;   Si la tecla leída es 'k' o 'l' mover el cursor sin salir del
;   tablero llamando a la subrutina moveCursorP2.
;   Si la tecla leída es ' ' 
;     Insertar el disco en el tablero (mBoard) en la columna actual del 
;     cursor (colCursor) llamando a la subrutina insertDiscP2.
;     Si se ha introducido el disco, (state != newState)
;       Verificar si se ha hecho 4 en línea o el tablero está lleno 
;       llamando a la subrutina checkEndP2.
;       Si no se ha hecho 4 en línea o el tablero está lleno (state <= 2)
;       actualizar el estado del juego (state = newState).
;   Si la tecla es ESC(ASCII 27) poner (state=0) para indicarlo.
; Actualizar el estado del tablero llamando a la subrutina updateBoardP2.
; Mostrar un mensaje según el estado del juego (state) llamando 
; a la subrutina printMessageP2.
; Se acaba el juego.
; 
; Variables globales utilizadas:	
; Ninguna
; 
; Parámetros de entrada: 
; (mBoard)     :rdi(rdi): Dirección de la matriz donde guardamos los discos introducidos.
; (freeRowXcol):rsi(rsi): Dirección de la matriz que indica la primera fila libre de cada columna del tablero.
; (direction)  :rdx(rdx): Dirección de la matriz que indica el incremento que se debe hacer a la posición actual para seguir una dirección.
; 
; Parámetros de salida: 
; Ninguno
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
playP2:
   push rbp
   mov  rbp, rsp
   ;guardar el estado de los registros que se modifican en esta 
   ;subrutina y que no se utilizan para retornar valores.
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

   mov  r9d, 3                ;int  colCursor = 3; //0..6
   mov  r10d, 1               ;int state = 1; // Estado del juego
                              ;// 0: Se ha pulsado ESC para salir   
                              ;// 1: Juega el jugador 1.
                              ;// 2: Juega el jugador 2.
                              ;// 3: El jugador 1 ha hecho 4 en línea.
                              ;// 4: El jugador 2 ha hecho 4 en línea.
                              ;// 5: El tablero está lleno. Empate.
                              
   mov r13, rdi               ;(mBoard)
   mov r14, rsi               ;(freeRowXcol)
   mov r15, rdx               ;(direction)
   playP2_while:
   cmp r10d, 1                ;while (state == 1 
   je playP2_loop
     cmp r10d, 2              ;|| state ==2  ) {
     jne playP2_endwhile
     playP2_loop:
       call printBoardP2      ;printBoardP2_C();
       mov rdi, r13
       call updateBoardP2     ;updateBoardP2_C(mBoard);
       mov  edi, r10d
       call printMessageP2    ;printMessageP2_C(state);
       cmp r10d, 1
       jne playP2_else1       ;if (state == 1) 
         mov bl, DISCSYMBOLPLAYER1;discSymbol = DISCSYMBOLPLAYER1; 
         jmp playP2_endif1
         playP2_else1:        ;else 
         mov bl, DISCSYMBOLPLAYER2;discSymbol = DISCSYMBOLPLAYER2;
         playP2_endif1:
         mov dil, bl
         mov esi, r9d
         mov rdx, r14
         call showDiscPosP2   ;showDiscPosP2_C(discSymbol, colCursor, freeRowXcol);
         call getchP2         ;charac = getchP2_C();
         mov bl, al
         cmp bl, 'k'          ;if (charac == 'k'  || charac == 'l') {
         je  playP2_move
           cmp bl, 'l'
           jne playP2_endmove
           playP2_move:
             mov dil, bl
             mov esi, r9d
             call moveCursorP2;colCursor = moveCursorP2_C(charac, colCursor);
             mov r9d, eax
         playP2_endmove:      ;}
         cmp bl, ' '          ;if (charac == ' ' ) {
         jne playP2_endinsert
           mov edi, r9d
           mov rsi, r13
           mov rdx, r14
           mov ecx, r10d
           call insertDiscP2  ;int newState = insertDiscP2_C(colCursor, mBoard, freeRowXcol, state);
           mov r12d, eax
           cmp r10d, r12d     ;if(state != newState){ //new disc inserted
           je  playP2_notinserted
             mov rdi, r14
             mov esi, r9d
             mov rdx, r15
             mov rcx, r13
             mov r8d, r10d
             call checkEndP2  ;state = checkEndP2_C(freeRowXcol, colCursor, direction, mBoard, state);
             mov r10d, eax
           playP2_notinserted:;}
         cmp r10d, 2          ;if (state <= 2) 
         jg  playP2_newstate
           mov r10d, r12d     ;state = newState;
         playP2_newstate:
       playP2_endinsert:      ;}
       cmp bl, 27             ;if (charac == 27) {
       jne playP2_noesc
         mov r10d, 0          ;state = 0;
       playP2_noesc:          ;}
     jmp playP2_while 
   playP2_endwhile:           ;}
   mov rdi, r13
   call updateBoardP2         ;updateBoardP2_C(mBoard);
   mov edi, r10d
   call printMessageP2        ;printMessageP2_C(state);  

   playP2_end: 
   ;restaurar el estado de los registros que se han guardado en la pila.
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
