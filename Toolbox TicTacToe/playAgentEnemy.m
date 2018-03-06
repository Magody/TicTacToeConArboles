function [row, col] = playAgentEnemy(delay,board)
pause(delay);
% recibimos la matriz actual del juego
matriz_inicial = board;
% conversion de la matriz en un vector de 9 elementos, para rellenar las posibles jugadas
matriz_inicial = matriz_inicial';
matriz_inicial = matriz_inicial(:);

% jugada nos dice si somos la primera(1), la segunda(2) u otra jugada (0)
jugada = ControladorEnemigo.obtenerNumeroJugada(matriz_inicial);

%Es una estrategia complementaria (con jugadas notables).A los arboles de desición con pesos
[f,c] = Controlador.contraJugadas(board);
if(f>0 && c >0)
    row = f;
    col = c;
    return
end

if(jugada == 0)
    % creamos los siguientes estados, a partir de la matriz actual}
    raiz = ArbolEnemigo();
    raiz.nivel = 0;
    raiz.contenido = board;
    raiz.l = raiz.generarNodos(matriz_inicial,2,1);
    nodo_a_jugar = ControladorEnemigo.elegirSiguienteJugada(raiz.l);
    [a,b] = ControladorEnemigo.usarJugadaElegidaEnEspacioDisponible(board,nodo_a_jugar);
    
elseif(jugada == 1)
    [a,b] = ControladorEnemigo.primeraJugada();
elseif(jugada == 2)
    [a,b] = ControladorEnemigo.segundaJugada(board);
end

row = a;
col = b;
return