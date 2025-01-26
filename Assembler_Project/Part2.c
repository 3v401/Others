/**
 * Implementación en C de la práctica, para que tengáis una
 * versión funcional en alto nivel de todas las funciones que 
 * debéis implementar en ensamblador.
 * Desde este código se hacen las llamadas a las subrutinas de ensamblador.
 * ESTE CÓDIGO NO SE PUEDE MODIFICAR Y NO SE DEBE ENTREGAR.
 **/

#include <stdio.h>
#include <termios.h>    //termios, TCSANOW, ECHO, ICANON
#include <unistd.h>     //STDIN_FILENO

/**
 * Constantes.
 **/
#define ROWSMATRIX 6
#define COLSMATRIX 7
#define DISCSYMBOLPLAYER1 'X'
#define DISCSYMBOLPLAYER2 'O'


/**
 * Definición de variables globales.
 **/
extern int developer;	//Variable declarada en ensamblador que indica el nombre del programador


                         
/**
 * Definición de las funciones en C.
 **/
void  clearScreen_C();
void  gotoxyP2_C(int, int);
void  printchP2_C(char);
char  getchP2_C();
char  printMenuP2_C();
void  printBoardP2_C();

long  calcIndexP2_C(int, int);                                              //pos:(row,col)
void  updateBoardP2_C(char[][COLSMATRIX]);                                     //:(mBoard)
void  showDiscPosP2_C(char, int, int[]);                                       //:(discSymbol, colCursor, freeRowXcol)
int   moveCursorP2_C(char, int);                                      //colCursor:(charac, colCursor) 
int   insertDiscP2_C(int, char[][COLSMATRIX], int[], int);                //state:(colCursor, mBoard, freeRowXcol, state)
unsigned char checkLineP2_C(int, int, int[][8], char[][COLSMATRIX]);//fourINaLINE:(row, col, direction, mBoard)
int   checkEndP2_C(int[], int, int[][8], char[][COLSMATRIX], int);        //state:( freeRowXcol, colCursor, direction, mBoard, state)

void  printMessageP2_C(int);                        //:(/state)
void  playP2_C(char[][COLSMATRIX], int[], int[][8]);//:(mBoard, freeRowXcol, direction);

/**
 * Definición de las subrutinas en ensamblador que se llaman desde C.
 **/
long  calcIndexP2(int, int);                                              //pos:(row,col)
void  updateBoardP2(char[][COLSMATRIX]);                                     //:(mBoard)
void  showDiscPosP2(char, int, int[]);                                       //:(discSymbol, colCursor, freeRowXcol)
int   moveCursorP2(char, int);                                      //colCursor:(charac, colCursor) 
int   insertDiscP2(int, char[][COLSMATRIX], int[], int);                //state:(colCursor, mBoard, freeRowXcol, state)
unsigned char checkLineP2(int, int, int[][8], char[][COLSMATRIX]);//fourINaLINE:(row, col, direction, mBoard)
int   checkEndP2(int[], int, int[][8], char[][COLSMATRIX], int);        //state:( freeRowXcol, colCursor, direction, mBoard, state)

void  printMessageP2(int);                        //:(state)
void  playP2(char[][COLSMATRIX], int[], int[][8]);//:(mBoard, freeRowXcol, direction);


/**
 * Borrar la pantalla
 * 
 * Variables globales utilizadas:   
 * Ninguna.
 * 
 * Parámetros de entrada: 
 * Ninguno.
 *   
 * Parámetros de salida: 
 * Ninguno.
 * 
 * Esta función no se llama desde ensamblador
 * y no hay definida una subrutina de ensamblador equivalente.
 **/
void clearScreen_C(){
   
    printf("\x1B[2J");
    
}


/**
 * Situar el cursor en una fila y una columna de la pantalla
 * en función de la fila (rowScreen) y de la columna (colScreen) 
 * recibidos como parámetro.
 * 
 * Variables globales utilizadas:   
 * Ninguna.
 * 
 * Parámetros de entrada: 
 * (rowScreen): rdi(edi): Fila
 * (colScreen): rsi(esi): Columna
 * 
 * Parámetros de salida: 
 * Ninguno.
 * 
 * Se ha definido una subrutina en ensamblador equivalente 'gotoxyP2' 
 * para poder llamar a esta función guardando el estado de los registros 
 * del procesador. Esto se hace porque las funciones de C no mantienen 
 * el estado de los registros.
 * El paso de parámetros es equivalente.
 **/
void gotoxyP2_C(int rowScreen, int colScreen){
   
   printf("\x1B[%d;%dH",rowScreen,colScreen);
   
}


/**
 * Mostrar un carácter (c) en la pantalla, recibido como parámetro, 
 * en la posición donde está el cursor.
 * 
 * Variables globales utilizadas:   
 * Ninguna.
 * 
 * Parámetros de entrada: 
 * (c): rdi(dil): Carácter que queremos mostrar
 * 
 * Parámetros de salida: 
 * Ninguno.
 * 
 * Se ha definido una subrutina en ensamblador equivalente 'printchP2' 
 * para llamar a esta función guardando el estado de los registros del 
 * procesador. Esto se hace porque las funciones de C no mantienen 
 * el estado de los registros.
 * El paso de parámetros es equivalente.
 **/
void printchP2_C(char c){
   
   printf("%c",c);
   
}


/**
 * Leer una tecla y devolver el carácter asociado 
 * sin mostrarlo en pantalla. 
 * 
 * Variables globales utilizadas:   
 * Ninguna.
 * 
 * Parámetros de entrada: 
 * Ninguno.
 * 
 * Parámetros de salida: 
 * (c): rax(al): Carácter leído del teclado
 * 
 * Se ha definido una subrutina en ensamblador equivalente 'getchP2' 
 * para llamar a esta función guardando el estado de los registros del 
 * procesador. Esto se hace porque las funciones de C no mantienen 
 * el estado de los registros.
 * El paso de parámetros es equivalente.
 **/
char getchP2_C(){

   int c;   

   static struct termios oldt, newt;

   /*tcgetattr obtener los parámetros del terminal
   STDIN_FILENO indica que se escriban los parámetros de la entrada estándar (STDIN) sobre oldt*/
   tcgetattr( STDIN_FILENO, &oldt);
   /*se copian los parámetros*/
   newt = oldt;

   /* ~ICANON para tratar la entrada de teclado carácter a carácter no como línea completa acabada con /n
      ~ECHO para que no muestre el carácter leído*/
   newt.c_lflag &= ~(ICANON | ECHO);          

   /*Fijar los nuevos parámetros del terminal para la entrada estándar (STDIN)
   TCSANOW indica a tcsetattr que cambie los parámetros inmediatamente.*/
   tcsetattr( STDIN_FILENO, TCSANOW, &newt);

   /*Leer un carácter*/
   c=getchar();                 
    
   /*restaurar los parámetros originales*/
   tcsetattr( STDIN_FILENO, TCSANOW, &oldt);

   /*Devolver el carácter leído*/
   return (char)c;
   
}

/**
 * Mostrar en pantalla el menú del juego y pedir una opción.
 * Solo acepta una de las opciones correctas del menú ('0'-'9')
 * 
 * Variables globales utilizadas:   
 * (developer):((char;)&developer): variable definida en el código ensamblador.
 * 
 * Parámetros de entrada: 
 * Ninguno.
 * 
 * Parámetros de salida: 
 * (charac): rax(al): Opción elegida del menú, leída del teclado.
 * 
 * Esta función no se llama desde ensamblador
 * y no hay definida una subrutina de ensamblador equivalente.
 **/
char printMenuP2_C(){
	
  clearScreen_C();
  gotoxyP2_C(1,1);
  printf("                            \n");
  printf("      Developed by:         \n");
  printf("     ( %s )    \n",(char *)&developer);
  printf(" __________________________ \n");
  printf("|                          |\n");
  printf("|   MENU 4 IN a LINE v2.0  |\n");
  printf("|__________________________|\n");
  printf("|                          |\n");
  printf("|     1.  CalcIndex        |\n");
  printf("|     2.  UpdateBoard      |\n");
  printf("|     3.  ShowDisc&Pos     |\n");
  printf("|     4.  MoveCursor       |\n");
  printf("|     5.  InsertDisc       |\n");
  printf("|     6.  CheckLine        |\n");
  printf("|     7.  CheckEnd         |\n");
  printf("|     8.  Play Game        |\n");
  printf("|     9.  Play Game C      |\n");
  printf("|     0.  Exit             |\n");
  printf("|                          |\n");
  printf("|         OPTION:          |\n");
  printf("|__________________________|\n"); 
   
  char charac =' ';
  while ((charac < '0' || charac > '9') && charac!=27) {
    gotoxyP2_C(20,19);      
    charac = getchP2_C();   
  }
  return charac;
   
}


/**
 * Mostrar el tablero de juego en la pantalla. Las líneas del tablero.
 * 
 * Variables globales utilizadas:	
 * Ninguna
 * 
 * Parámetros de entrada: 
 * Ninguno.
 * 
 * Parámetros de salida: 
 * Ninguno.
 * 
 * Se ha definido una subrutina en ensamblador equivalente 'printBoardP2' 
 * para llamar a esta función guardando el estado de los registros del 
 * procesador. Esto se hace porque las funciones de C no mantienen 
 * el estado de los registros.
 * El paso de parámetros es equivalente.
 **/
void printBoardP2_C(){
   int i;

   clearScreen_C();
   gotoxyP2_C(1,1);                                     //ScreenRows   
   printf(" _____________________________________ \n"); //01
   printf("|                                     |\n"); //02
   printf("|             4 IN a LINE             |\n"); //03
   printf("|                                     |\n"); //04
   printf("|                                     |\n"); //05
//Screen Colums  08  12  16  20  24  28  32      
   printf("|    +---+---+---+---+---+---+---+    |\n"); //06
   printf("|  0 |   |   |   |   |   |   |   |    |\n"); //07
   printf("|    +---+---+---+---+---+---+---+    |\n"); //08
   printf("|  1 |   |   |   |   |   |   |   |    |\n"); //09
   printf("|    +---+---+---+---+---+---+---+    |\n"); //10
   printf("|  2 |   |   |   |   |   |   |   |    |\n"); //11
   printf("|    +---+---+---+---+---+---+---+    |\n"); //12
   printf("|  3 |   |   |   |   |   |   |   |    |\n"); //13
   printf("|    +---+---+---+---+---+---+---+    |\n"); //14
   printf("|  4 |   |   |   |   |   |   |   |    |\n"); //15
   printf("|    +---+---+---+---+---+---+---+    |\n"); //16
   printf("|  5 |   |   |   |   |   |   |   |    |\n"); //17
   printf("|    +---+---+---+---+---+---+---+    |\n"); //18  
   printf("|      0   1   2   3   4   5   6      |\n"); //19
   printf("|                                     |\n"); //20
   printf("|    (ESC)Exit   (Space)Inser Disc    |\n"); //21
   printf("|     (k) Left     (l)  Right         |\n"); //22
   printf("|_____________________________________|\n"); //23
   printf("|                                     |\n"); //24
   printf("|                                     |\n"); //25
   printf("|_____________________________________|\n"); //26
   
}


/**
 * Calcular el índice para acceder a la matriz (mBoard) en ensamblador.
 * (mBoard[row][col]) en C, es ([mBoard+indexMat]) en ensamblador.
 * donde indexMat = row*COLSMATRIX+col.
 * La matriz (mBoard) es de tipo char(BYTE)1byte.
 * Recibe la fila (row) y la columna (col) como parámetros y retorna 
 * el índice (indexMat) para acceder a la matriz.
 * 
 * Variables globales utilizadas:	
 * Ninguna.
 * 
 * Parámetros de entrada:
 * (row) :rdi(edi): Fila de la matriz mBoard.
 * (col) :rsi(esi): Columna de la matriz mBoard.
 * 
 * Parámetros de salida: 
 * (indexMat) :rax(rax): Índice para acceder a la matriz mBoard.
 * 
 **** Esta función no es necesaria en C, solo en ensamblador.****
 * Hay una subrutina de ensamblador equivalente 'calcIndexP2', 
 * el paso de parámetros es equivalente.
 */
long calcIndexP2_C(int row, int col){ //pos:(row,col){
   long indexMat = (long)(row*COLSMATRIX+col);
   return indexMat;
}


/**
 * Mostrar los valores de la matriz (mBoard) dentro del tablero,
 * en las posiciones correspondientes. 
 * Se debe recorrer toda la matriz (mBoard), de izquierda a derecha y 
 * de arriba hacia abajo, desde la posición [0][0]=(0) hasta la posición [5][6]=(41),
 * cada posición es de tipo char(BYTE)1byte, y para cada elemento hacer:
 * Posicionar el cursor en el tablero en función de las variables 
 * (rowScreen) fila y (colScreen) columna llamando a la función gotoxyP2_C.
 * Las variables (rowScreen) y (colScreen) se inicializarán en 7 y 8, 
 * respectivamente, que es la posición en pantalla de la casilla [0][0].
 * Las filas se incrementan de 2 en 2 y las columnas de 4 en 4.
 * Mostrar los caracteres de cada posición de la matriz (mBoard) llamando
 * a la función printchP2_C.
 *  
 * Variables globales utilizadas:	
 * Ninguna.
 * 
 * Parámetros de entrada:
 * (mBoard):rdi(rdi): Dirección de la matriz donde guardamos los discos introducidos. 
 * 
 * Parámetros de salida: 
 * Ninguno.
 * 
 * Esta función no se llama desde ensamblador.
 * Hay una subrutina en ensamblador equivalente 'updateBoardP2',
 * el paso de parámetros es equivalente.
 **/
void  updateBoardP2_C(char mBoard[][COLSMATRIX]){
   
   int  i,j;
   char charac;
   int  rowScreen, colScreen;
   rowScreen = 7;
   for (i=0;i<ROWSMATRIX;i++){
	  colScreen = 8;
      for (j=0;j<COLSMATRIX;j++){
         gotoxyP2_C(rowScreen, colScreen);
         charac = mBoard[i][j];
         printchP2_C(charac);
         colScreen = colScreen + 4;
      }
      rowScreen = rowScreen + 2;
   }
   
}


/**
 * Muestra en el tablero el símbolo del jugador (discSymbol)
 * que está jugando en la columna donde está el cursor (colCursor)
 * y posiciona el cursor en la posición del tablero
 * donde caerá el disco en esa columna.
 * El símbolo del jugador se muestra en la fila (rowScreen=5) y la columna
 * (colScreen=8+colCursor*4).
 * Después, posicionar el cursor en la misma columna y 
 * en la fila donde caerá el disco si se presiona espacio.
 * (rowScreen = 7+freeRowXcol[colCursor]*2)
 * La matriz freeRowXcol es de tipo int(DWORD)4bytes.
 * Posicionar el cursor en el tablero en función de las variables 
 * (rowScreen) fila y (colScreen) columna llamando a la función gotoxyP2_C.
 * Mostrar el símbolo (discSymbol) llamando a la función printchP2_C.
 *  
 * Variables globales utilizadas:	
 * Ninguna.
 * 
 * Parámetros de entrada:
 * (discSymbol) :rdi(dil): Símbolo del jugador que está jugando.
 * (colCursor)  :rsi(esi): Columna donde está el cursor.
 * (freeRowXcol):rdx(rdx): Dirección de la matriz que indica la primera fila libre de cada columna del tablero.
 * 
 * Parámetros de salida: 
 * Ninguno.
 * 
 * Esta función no se llama desde ensamblador.
 * Hay una subrutina en ensamblador equivalente 'showDiscPosP2',
 * el paso de parámetros es equivalente.
 **/
void showDiscPosP2_C(char discSymbol, int colCursor, int freeRowXcol[]){
	
  int rowScreen;
  int colScreen;
  rowScreen = 5;
  colScreen = 8+colCursor*4;
  gotoxyP2_C(rowScreen, colScreen);
  printchP2_C(discSymbol);
  rowScreen = 7+freeRowXcol[colCursor]*2;
  //colScreen = 8+colCursor*4;
  gotoxyP2_C(rowScreen, colScreen);
  
}
 
 
/**
 * Actualizar la columna donde está el cursor (colCursor).
 * Si se ha leído (charac=='k') izquierda o (charac=='l') derecha 
 * actualizar la posición del cursor (colCursor +/- 1)
 * controlando que no salga del tablero [0..(COLSMATRIX-1)]. 
 * Devolver el valor actualizado de (colCursor).
 *  
 * Variables globales utilizadas:	
 * Ninguna.
 * 
 * Parámetros de entrada: 
 * (charac)   :rdi(dil): Carácter leído del teclado.
 * (colCursor):rsi(esi): Columna donde está el cursor.
 * 
 * Parámetros de salida: 
 * (colCursor):rax(eax):  Columna donde está el cursor actualizada.
 * 
 * Esta función no se llama desde ensamblador.
 * Hay una subrutina en ensamblador equivalente 'moveCursorP2',  
 * el paso de parámetros es equivalente.
 **/
int moveCursorP2_C(char charac, int colCursor){
	
   if ((charac=='k') && (colCursor>0)){             
      colCursor--;
   } else 
   if ((charac=='l') && (colCursor<(COLSMATRIX-1))){
      colCursor++;
   }
   return colCursor;
   
}

/**
 * Inserta el disco (discSymbol) del jugador en la columna donde está 
 * el cursor (colCursor) y en la primera fila libre de esa columna.
 * La primera fila libre (row) de una columna dentro de la matriz (mBoard) 
 * la tenemos guardada en la columna (colCursor) del vector (freeRowXcol)
 * (freRowXcol[colCursor]).
 * Si podemos introducir el disco (row>=0):
 *   Si el estado del juego es (state==1) el (discSymbol = DISCSYMBOLPLAYER1),
 *   si el estado del juego es (state==2) el (discSymbol = DISCSYMBOLPLAYER2).
 *   Poner el símbolo (discSymbol) en la matriz (mBoard) en la primera fila 
 *   libre (row) y en la columna donde está el cursor (colCursor).
 *   Decrementar la fila libre del vector (freeColXrow) de la columna donde
 *   hemos insertado el disco (colCursor).
 *   Cambiamos de jugador, de jugador 1 a jugador 2 y de jugador 2 a jugador 1
 *   (state = 3 - state).
 * Si no queda espacio en esa columna (row=-1) no insertamos el disco.
 * Devolver estado del juego.
 * 
 * Variables globales utilizadas:	
 * Ninguna.
 * 
 * Parámetros de entrada:
 * (colCursor)  :rdi(edi): Columna donde está el cursor.
 * (mBoard)     :rsi(rsi): Dirección de la matriz donde guardamos los discos introducidos. 
 * (freeRowXcol):rdx(rdx): Dirección de la matriz que indica la primera fila libre de cada columna del tablero.
 * (state)      :rcx(ecx): Estado del juego.
 * 
 * Parámetros de salida: 
 * (state)      :rax(eax): Estado del juego.
 * 
 * Esta función no se llama desde ensamblador.
 * Hay una subrutina en ensamblador equivalente 'insertDiscP2',  
 * el paso de parámetros es equivalente.
 **/
int  insertDiscP2_C(int colCursor, char mBoard[][COLSMATRIX], int freeRowXcol[], int state){
	
  char discSymbol;

  int row = freeRowXcol[colCursor];
	
  if(row >= 0) {
    if (state == 1) discSymbol = DISCSYMBOLPLAYER1; else discSymbol = DISCSYMBOLPLAYER2;
	mBoard[row][colCursor] = discSymbol;
	freeRowXcol[colCursor]--;
	state = 3 - state;
  }
  return state;
  
}

/**
 * Comprobar si el nuevo disco introducido, en la fila (row), columna (col)
 * de la matriz (mBoard), hace 4 en línea (fourINaLINE=1) en alguna 
 * dirección: diagonal, horizontal o vertical, indicada con el valor 
 * que debemos modificar la posición actual (row, col) para seguir 
 * esa dirección en la matriz (direction).
 * dirección:  0    1      2    3      4    5      6    7
 *         { -1 , +1  ,  +1 , -1  ,   0 ,  0  ,  -1 , +1  } //modificación de la fila
 *         { -1 , +1  ,  -1 , +1  ,  -1 , +1  ,   0 ,  0  } //modificación de la columna
 *         (izq./der.)(izq./der.)(izq./der.)(izq./der.) //(leftright: izq.=0, der.=1)
 *          diagonal 1  diagonal 2  horizontal  vertical
 * La línea de 4 (discsINaLINE==4), respecto a la posición actual (X) 
 * puede estar, por cada dirección: a la izquierda XXX(X), a la derecha (X)XXX 
 * o en ambos lados XX(X)X o X(X)XX.
 * Obtenemos el símbolo de la posición actual del cursor (discSymbol = mBoard[row][col]).
 * Mientras no hagamos 4 en línea (fourINaLINE==0) y no hayamos mirado todas las direcciones (dir<8) hacer:
 *   Si miramos hacia la izquierda de la posición actual (leftright==0) 
 *     contamos 1 disco (discsINaLINE=1)(el que acabamos de poner).
 *     si estamos mirando a la derecha (leftright==1) no modificamos 
 *     (discsINaLINE) y continuamos contando fichas iguales.
 *   Mientras podamos continuar buscando en esa dirección (exit==0)
 *     Obtenemos la posición de la casilla que queremos mirar (nextRow, nextCol)
 *     con el incremento indicado en la matriz (direction) de la dirección 
 *     que estamos mirando (dir).
 *     (nextRow = nextRow + direction[0][dir])(nextCol = nextCol + direction[1][dir])
 *     Si la fila o la columna está fuera del tablero
 *     ((nextRow < 0) || (nextRow >= ROWSMATRIX)) y
 *     ((nextCol < 0) || (nextCol >= COLSMATRIX))
 *     dejamos de buscar en esa dirección (exit=1).
 *     Si está dentro del tablero, miramos si el símbolo que hay en esa 
 *     casilla (mBoard[nextRow][nextCol]) es el mismo símbolo
 *     que la casilla inicial (discSymbol), 
 *     si es el mismo símbolo incrementamos (discsINaLINE),
 *     si no es el mismo, dejamos de buscar en esa dirección (exit=1).
 *   Si estábamos buscando hacia la izquierda (leftright==0) pasaremos 
 *   a buscar hacia la derecha (leftright=1),   
 *   si no, pasaremos a buscar hacia la izquierda (leftright=0),
 *   en una nueva dirección (dir++) de la matriz (direction).
 *   Si (discsINaLINE==4), tenemos una línea de 4, 
 *   lo indicamos poniendo (fourINaLINE=1).
 * devolvemos (foruINaLINE) para indicar si hemos encontrado un 4 en línea o no.
 * 
 * Variables globales utilizadas:	
 * Ninguna.
 * 
 * Parámetros de entrada: 
 * (row)      :rdi(edi): Fila donde hemos insertado el disco.
 * (col)      :rsi(esi): Columna donde hemos insertado el disco.
 * (direction):rdx(rdx): Dirección de la matriz que indica el incremento que se debe hacer en la posición actual para seguir una dirección.
 * (mBoard)   :rcx(rcx): Dirección de la matriz donde guardamos los discos introducidos. 
 *  
 * Parámetros de salida: 
 * (fourINaLINE):rax(al): Indica si hemos hecho 4 en línea (1) o no (0).
 * 
 * Esta función no se llama desde ensamblador.
 * Hay una subrutina en ensamblador equivalente 'checkLineP2',  
 * el paso de parámetros es equivalente.
 **/
unsigned char checkLineP2_C(int row, int col, int direction[][8], char mBoard[][COLSMATRIX]){
  
  int discsINaLINE;
  int nextRow;
  int nextCol;
  char discSymbol = mBoard[row][col];
  unsigned char fourINaLINE = 0; //0=false, 1=true
  long dir = 0;
  int leftright=0;
  while (fourINaLINE == 0 && dir < 8){
	nextRow = row;
	nextCol = col;
	int exit = 0;  //1: dejar de buscar en esa dirección
	if (leftright==0) discsINaLINE = 1;
	while (exit == 0){
	  nextRow = nextRow + direction[0][dir];
	  if ((nextRow < 0) || (nextRow >= ROWSMATRIX)) {
		  exit=1; //La fila está fuera del tablero y deja de buscar en esa dirección.
	  } else {
		nextCol = nextCol + direction[1][dir];
		if ((nextCol < 0) || (nextCol >= COLSMATRIX)) {
		  exit=1; //La columna está fuera del tablero y deja de buscar en esa dirección.
		} else {
		  if (mBoard[nextRow][nextCol] == discSymbol) {
			discsINaLINE++; //Encuentra un disco igual en esa dirección y sigue buscando.
		  } else {
			exit=1; //Encuentra un disco diferente y deja de buscar en esa dirección.
		  }
		}
	  }
	}
	if (leftright==0) leftright=1; else leftright=0;
	dir++;
	if (discsINaLINE >= 4) fourINaLINE = 1;
  }
  return fourINaLINE;
  
}

/**
 * Verifica si el jugador que ha introducido el último disco ha hecho 
 * 4 en línea o si el tablero está lleno y no se puede continuar jugando.
 * Primero obtiene la primera fila (row) de la columna (colCursor) 
 * de la matriz (mBoard) con disco, es la posición (colCursor) 
 * del vector (freeRowXcol) + 1.
 * Después, llamando a la función checkLineP2_C comprueba si con el disco
 * introducido, en la fila (row), columna (colCursor) de la matriz (mBoard), 
 * hace 4 en línea en alguna dirección: diagonal, horizontal o vertical 
 * y actualiza la variable (fourINaLine: 1 hay 4 en línea, 0 no).
 * Si hay 4 en línea (fourINaLine==1) incrementamos (state) en 2 para 
 * indicar que el jugador que ha introducido el disco gana.
 * Si no, miraremos si el tablero está lleno.
 *   El tablero está lleno si la primera fila libre de todas las columnas
 *   indicada en el vector (freeRoxWcol) es -1.
 *   Si se recorre todo el vector (freeRowXcol) y todas las posiciones
 *   valen -1, (c==COLSMATRIX) pondremos (state=5) para indicar que
 *   el tablero está lleno y no se puede continuar jugando.
 * Devolver el estado del juego.
 * 
 * Variables globales utilizadas:	
 * Ninguna.
 * 
 * Parámetros de entrada:
 * (freeRowXcol):rdi(rdi): Dirección de la matriz que indica la primera fila libre de cada columna del tablero.
 * (colCursor)  :rsi(esi): Columna donde está el cursor.
 * (direction)  :rdx(rdx): Dirección de la matriz que indica el incremento que se debe hacer en la posición actual para seguir una dirección.
 * (mBoard)     :rcx(rcx): Dirección de la matriz donde guardamos los discos introducidos.
 * (state)      :r8 (r8d): Estado del juego.
 *  
 * Parámetros de salida: 
 * (state)      :rax(eax): Estado del juego.
 * 
 * Esta función no se llama desde ensamblador.
 * Hay una subrutina en ensamblador equivalente 'checkEndP2',  
 * el paso de parámetros es equivalente.
 **/
int checkEndP2_C(int freeRowXcol[], int colCursor, int direction[][8], char mBoard[][COLSMATRIX], int state){

  unsigned char fourINaLINE; //0=false, 1=true
  int row = freeRowXcol[colCursor]+1;
  fourINaLINE = checkLineP2_C(row, colCursor, direction, mBoard);
  if (fourINaLINE == 1) {
	  state= state + 2;
  } else {
    int c=0;
    while (freeRowXcol[c] == -1 && c < COLSMATRIX){
      c++;
    }
    if (c == COLSMATRIX) state = 5;
  }
  return state;
  
}
 

/**
 * Muestra un mensaje en la parte inferior del tablero según el 
 * valor de la variable (state).
 * (state) 0: Se ha presionado ESC para salir 
 *         1: Juega el jugador 1.
 *         2: Juega el jugador 2.
 *         3: El jugador 1 ha hecho 4 en línea.
 *         4: El jugador 2 ha hecho 4 en línea.
 *         5: El tablero está lleno. Empate.
 * 
 * Variables globales utilizadas:	
 * Ninguna.
 * 
 * Parámetros de entrada:
 * (state): rdi(edi): Estado del juego.
 * 
 * Parámetros de salida: 
 * Ninguno.
 *  
 * Se ha definido una subrutina en ensamblador equivalente 'printMessageP2' 
 * para llamar a esta función guardando el estado de los registros del 
 * procesador. Esto se hace porque las funciones de C no mantienen 
 * el estado de los registros.
 * El paso de parámetros es equivalente.
 **/
void printMessageP2_C(int state){

   gotoxyP2_C(25,4);
   switch(state){
	 case 0:
       printf("       EXIT: (ESC) PRESSED ");
     break;
     case 1: 
       printf("       Play: PLAYER 1 (%c)       ", DISCSYMBOLPLAYER1);
     break;
     case 2:
       printf("       Play: PLAYER 2 (%c)       ", DISCSYMBOLPLAYER2);
     break;
     case 3:
       printf("      PLAYER 1 (%c): WIN!!!      ", DISCSYMBOLPLAYER1);
     break;
     case 4:
       printf("      PLAYER 2 (%c): WIN!!!      ", DISCSYMBOLPLAYER2);
     break;
     case 5:
       printf("  GAME OVER: Grid Full! = DRAW = ");
     break;
   }
   
}


/**
 * Función principal del juego
 * Muestra el tablero de juego y permite realizar las jugadas de los 2 jugadores,
 * alternativamente, hasta que uno de los dos jugadores coloca 4 discos en línea
 * o el tablero queda lleno y nadie ha hecho ninguna línea de 4.
 * 
 * Pseudo-código:
 * Mientras estén jugando el jugador 1 (state=1) o el jugador 2 (state = 2) hacer:
 *   Mostrar las líneas del tablero llamando a la función printBoardP2_C.
 *   Actualizar el estado del tablero llamando a la función updateBoardP2_C.
 *   Mostrar un mensaje según el estado del juego (state) llamando 
 *   a la función printMessageP2_C.
 *   Si (state==1) asignar a (discSymbol) el símbolo del jugador 1
 *   (DISCSYMBOLPLAYER1='X'), de lo contrario, el símbolo del jugador 2
 *   (DISCSYMBOLPLAYER1='O').
 *   Leer una tecla llamando a la función getchP2_C.
 *   Si la tecla leída es 'k' o 'l' mover el cursor sin salir del
 *   tablero llamando a la función moveCursorP2_C.
 *   Si la tecla leída es ' ' 
 *     Insertar el disco en el tablero (mBoard) en la columna actual del 
 *     cursor (colCursor) llamando a la función insertDiscP2_C.
 *     Si se ha introducido el disco, (state != newState)
 *       Verificar si se ha hecho 4 en línea o el tablero está lleno 
 *       llamando a la función checkEndP2_C.
 *       Si no se ha hecho 4 en línea o el tablero está lleno (state <= 2)
 *       actualizar el estado del juego (state = newState).
 *   Si la tecla es ESC(ASCII 27) poner (state=0) para indicarlo.
 * Actualizar el estado del tablero llamando a la función updateBoardP2_C.
 * Mostrar un mensaje según el estado del juego (state) llamando 
 * la función printMessageP2_C.
 * Se acaba el juego.
 * 
 * Variables globales utilizadas:	
 * Ninguna.
 * 
 * Parámetros de entrada:
 * (mBoard)     :rdi(rdi): Dirección de la matriz donde guardamos los discos introducidos.
 * (freeRowXcol):rsi(rsi): Dirección de la matriz que indica la primera fila libre de cada columna del tablero.
 * (direction)  :rdx(rdx): Dirección de la matriz que indica el incremento que se debe hacer en la posición actual para seguir una dirección.
 * 
 * Parámetros de salida: 
 * Ninguno.
 *  
 * Esta función no se llama desde ensamblador.
 * Hay una subrutina en ensamblador equivalente 'playP2',  
 * el paso de parámetros es equivalente.
 **/
void playP2_C(char mBoard[][COLSMATRIX], int freeRowXcol[], int direction[][8]){

  char charac;      //Carácter leído del teclado.
  char discSymbol;  //Símbolo del disco del jugador que está jugando.
  
  int colCursor = 3;//Columna donde está el cursor [0..6]
  int state = 1;    // Estado del juego
                    // 0: Se ha presionado ESC para salir   
                    // 1: Juega el jugador 1.
                    // 2: Juega el jugador 2.
                    // 3: El jugador 1 ha hecho 4 en línea.
                    // 4: El jugador 2 ha hecho 4 en línea.
                    // 5: El tablero está lleno. Empate.
                  
  while (state == 1 || state ==2  ) {
    printBoardP2_C();
    updateBoardP2_C(mBoard);
    printMessageP2_C(state);
    if (state == 1) discSymbol = DISCSYMBOLPLAYER1; else discSymbol = DISCSYMBOLPLAYER2;  
    showDiscPosP2_C(discSymbol, colCursor,  freeRowXcol);
    charac = getchP2_C();   
    if (charac == 'k'  || charac == 'l') {
      colCursor = moveCursorP2_C(charac, colCursor);
    }
    if (charac == ' ' ) {
      int newState = insertDiscP2_C(colCursor, mBoard, freeRowXcol, state);
      if(state != newState){ //new disc inserted
        state = checkEndP2_C(freeRowXcol, colCursor, direction, mBoard, state);
        if (state <= 2) state = newState;
      }
    }
    if (charac == 27) {
       state = 0;
    }
  }
  updateBoardP2_C(mBoard);
  printMessageP2_C(state);
   
}


/**
 * Programa Principal
 * 
 * ATENCIÓN: Podéis probar la funcionalidad de las subrutinas que deben
 * desarrollarse quitando los comentarios de la llamada a la función 
 * equivalente implementada en C que hay debajo de cada opción.
 * Para el juego completo hay una opción para la versión en ensamblador y 
 * una opción para el juego en C.
 **/
void main(void){   

  char charac;      //Carácter leído del teclado.
  char discSymbol;  //Símbolo del disco del jugador que está jugando.
  int  colCursor = 3; //Columna donde está el cursor [0..6]
  unsigned char fourINaLINE = 0; //0=falso, 1=verdadero
  int state = 1;  // Estado del juego
                  // 0: Se ha presionado ESC para salir   
                  // 1: Juega el jugador 1.
                  // 2: Juega el jugador 2.
                  // 3: El jugador 1 ha hecho 4 en línea.
                  // 4: El jugador 2 ha hecho 4 en línea.
                  // 5: El tablero está lleno. Empate.

  //Matriz 6x7 que contiene el estado del tablero       0   1   2   3   4   5   6
  char mBoard[ROWSMATRIX][COLSMATRIX] = { /*0*/ {' ',' ',' ','O',' ',' ',' '},
                                          /*1*/ {'O',' ','O','X',' ',' ',' '},
                                          /*2*/ {'X',' ','O','O',' ',' ',' '},
                                          /*3*/ {'X',' ','O','X',' ','X',' '},
                                          /*4*/ {'O',' ','X','O','X','O',' '},
                                          /*5*/ {'O','X','O','X','X','X',' '} };
  int freeRowXcol[COLSMATRIX] = { 0, 4, 0, -1, 3, 2, 5 };
  int direction[2][8] = { { -1, +1, +1, -1,  0,  0, -1, +1},   //modificación de fila
                          { -1, +1, -1, +1, -1, +1,  0,  0} }; //modificación de columna
   
  int op=' ';
  while (op!='0' && op!=27) {
    op = printMenuP2_C();	  
    switch(op){
      case 27:
      case '0':
        gotoxyP2_C(21,0);
        break;
      case '1':
        clearScreen_C();
        printBoardP2_C();
        int row = 4;
        int col = 3;
        long indexMat = -1;
        //=======================================================
        indexMat = calcIndexP2(row, col);
        ///indexMat = calcIndexP2_C(row, col);
        //=======================================================
        gotoxyP2_C(25,4);
        printf("row(%i)*COLSMATRIX(7)+col(%i)=(%li)",row, col, indexMat);
        getchP2_C();
        gotoxyP2_C(25,4);
        printf("                           ");
        break;
      case '2':
        clearScreen_C();
        printBoardP2_C();
        //=======================================================
        updateBoardP2(mBoard);
        ///updateBoardP2_C(mBoard);	    
        //=======================================================
        gotoxyP2_C(25,4);
        printf("         Press any key ");
        getchP2_C();
        gotoxyP2_C(25,4);
        printf("                           ");
        break;
      case '3':
        clearScreen_C();
        printBoardP2_C();
        updateBoardP2_C(mBoard);
        gotoxyP2_C(25,4);
        printf("   Move cursor left and right ");
        colCursor = 3;
        discSymbol = 'X';
        do {
          charac = getchP2_C();
          gotoxyP2_C(5,4);
          printf("                               ");
          if (charac == 'k' && colCursor > 0) colCursor--;
          if (charac == 'l' && colCursor < COLSMATRIX-1) colCursor++;
          //=======================================================
          showDiscPosP2(discSymbol, colCursor,  freeRowXcol);
          ///showDiscPosP2_C(discSymbol, colCursor, freeRowXcol);
          //=======================================================
        } while (charac != 27);
        break;
      case '4': 	     
        clearScreen_C();
        printBoardP2_C();
        updateBoardP2_C(mBoard);
        gotoxyP2_C(25,4);
        printf("   Move cursor left and right ");
        colCursor = 3;
        discSymbol = 'X';
        charac = ' ';
        do {
          charac = getchP2_C();
          gotoxyP2_C(5,4);
          printf("                               ");	
          //=======================================================
          colCursor = moveCursorP2(charac, colCursor); 
          ///colCursor = moveCursorP2_C(charac, colCursor); 
          //=======================================================
          showDiscPosP2_C(discSymbol, colCursor, freeRowXcol);
        } while (charac != 27);
        break;  
      case '5': 	     
        clearScreen_C();
        printBoardP2_C();
        updateBoardP2_C(mBoard);
        gotoxyP2_C(25,4);
        printf("          Insert disc         ");
        colCursor = 3;
        state = 1;
        charac = ' ';
        do {
		  printBoardP2_C();
          updateBoardP2_C(mBoard);
          gotoxyP2_C(25,4);
          printf("          Insert disc         ");
          if (state == 1) discSymbol = DISCSYMBOLPLAYER1; else discSymbol = DISCSYMBOLPLAYER2;
          showDiscPosP2_C(discSymbol, colCursor, freeRowXcol);
          charac = getchP2_C();
          if (charac == 'k' || charac == 'l' ) colCursor = moveCursorP2_C(charac, colCursor);
          if (charac == ' '){
            //=======================================================
            state = insertDiscP2(colCursor, mBoard, freeRowXcol, state);
            ///state = insertDiscP2_C(colCursor, mBoard, freeRowXcol, state);		
            //=======================================================
          }
        } while (charac != 27); 
        break;
      case '6': 	     
        colCursor = 1;
        state = 2;
        if (state == 1) discSymbol = DISCSYMBOLPLAYER1; else discSymbol = DISCSYMBOLPLAYER2;
        clearScreen_C();
        printBoardP2_C();
        insertDiscP2_C(colCursor, mBoard, freeRowXcol, state);
        row = freeRowXcol[colCursor]+1;
        //=======================================================
        fourINaLINE = checkLineP2(row, colCursor, direction, mBoard);
        ///fourINaLINE = checkLineP2_C(row, colCursor, direction, mBoard);
        //=======================================================
        if (fourINaLINE == 1) state = state + 2;
        updateBoardP2_C(mBoard);
        printMessageP2_C(state);
        gotoxyP2_C(27,2);
        printf("New disc(%c) in row(%i) col(%i) - Press any key",discSymbol, row, colCursor);
        getchP2_C();
        break;
      case '7':
         char mBoard2[ROWSMATRIX][COLSMATRIX] = 
                                  { /*0*/ {'O','O','X',' ','X','X','X'},
                                    /*1*/ {'O','X','O','X','O','O','O'},
                                    /*2*/ {'X','X','O','O','O','X','O'},
                                    /*3*/ {'X','O','O','X','X','X','O'},
                                    /*4*/ {'O','X','X','O','X','O','X'},
                                    /*5*/ {'O','X','O','X','X','X','O'} };
        int freeRowXcol2[COLSMATRIX]  =   {-1, -1, -1,  0, -1, -1, -1 };
        colCursor = 3;
        state = 2; //state = 1; //fourINaLINE 'X'
        if (state == 1) discSymbol = DISCSYMBOLPLAYER1; else discSymbol = DISCSYMBOLPLAYER2;
        clearScreen_C();
        printBoardP2_C();
        insertDiscP2_C(colCursor, mBoard2, freeRowXcol2, state);
        //=======================================================
        state = checkEndP2(freeRowXcol2, colCursor, direction, mBoard2, state);
        ///state = checkEndP2_C(freeRowXcol2, colCursor, direction, mBoard2, state);
        //=======================================================
        updateBoardP2_C(mBoard2);
        printMessageP2_C(state);
        gotoxyP2_C(27,2);
        printf("          Press any key ");
        getchP2_C();
        break;
      case '8': 	//Juego completo en ensamblador.
        clearScreen_C();
        //=======================================================
        playP2(mBoard, freeRowXcol, direction);
        //=======================================================
        gotoxyP2_C(27,14); 
        printf("Press any key");
        getchP2_C();	  
        break;
      case '9': 	//Juego completo en C.
        clearScreen_C();
        //=======================================================
        playP2_C(mBoard, freeRowXcol, direction);
        //=======================================================
        gotoxyP2_C(27,14); 
        printf("Press any key");
        getchP2_C();	  
        break;
     }
  }
   
}
