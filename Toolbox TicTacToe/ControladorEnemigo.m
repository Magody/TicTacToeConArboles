classdef ControladorEnemigo < handle
    
    
    methods(Static)
        % Metodos de utilidad
        function jugada = obtenerNumeroJugada(matriz)
            % Nos dice si somos la primera, segunda u otra jugada.
            suma = sum(matriz);
            if(suma == 0)
                jugada = 1;
                return
            elseif(suma == 1)
                jugada = 2;
                return
            else
                jugada = 0; % no somos ni la primera ni la segunda
                return
            end
        end
         
        function [fila,columna] = primeraJugada()
            % la esquina es la mejor estrategia para empezar, es una estrategia
            [fila,columna] = ControladorEnemigo.escogerEsquinaAleatoria();
            return
        end
        
        function [fila,columna] = escogerEsquinaAleatoria()
            f = randi([1 2]);
            c = randi([1 2]);
            esquinas(1,1,1) = 1;
            esquinas(1,1,2) = 1;
            
            esquinas(1,2,1) = 1;
            esquinas(1,2,2) = 3;
            
            esquinas(2,1,1) = 3;
            esquinas(2,1,2) = 1;
            
            esquinas(2,2,1) = 3;
            esquinas(2,2,2) = 3;
            
            fila = esquinas(f,c,1);
            columna = esquinas(f,c,2);
            
        end
        
        function [fila,columna] = segundaJugada(matriz)
            % Programacion manual de una segunda jugada, para aumentar el rendimiento
            
            if(matriz == [0 0 0;0 1 0;0 0 0]) %#ok<BDSCA> es para suprimir warnings
                % centro
                [fila,columna] = ControladorEnemigo.escogerEsquinaAleatoria();
                return
            elseif(matriz == [0 1 0;0 0 0;0 0 0]) %#ok<BDSCA>
                % lado 1
                fila=1;
                columna=3;
                return
            elseif(matriz == [0 0 0;0 0 1;0 0 0]) %#ok<BDSCA>
                % lado 2
                fila=3;
                columna=3;
                return
            elseif(matriz == [0 0 0;0 0 0;0 1 0]) %#ok<BDSCA>
                % lado 3
                fila=3;
                columna=3;
                return
            elseif(matriz == [0 0 0;1 0 0;0 0 0]) %#ok<BDSCA>
                % lado 4
                fila=3;
                columna=1;
                return
            elseif(matriz == [1 0 0;0 0 0;0 0 0]) %#ok<BDSCA>
                % esquina 1
                fila=2;
                columna=2;
                return
            elseif(matriz == [0 0 1;0 0 0;0 0 0]) %#ok<BDSCA>
                % esquina 2
                fila=2;
                columna=2;
                return
            elseif(matriz == [0 0 0;0 0 0;0 0 1]) %#ok<BDSCA>
                % esquina 3
                fila=2;
                columna=2;
                return
            elseif(matriz == [0 0 0;0 0 0;1 0 0]) %#ok<BDSCA>
                % esquina 4
                fila=2;
                columna=2;
                return
            end
        end
        
        function [f,c] = contraJugadas(matriz)
            % estrategias de jugadas notables, humanamente racionalizadas, retorna cero si no esta implementada
            
            fila=0;
            columna=0;
            
            % Vamos a rotar una matriz con las posiciones, al mismo tiempo que la matriz dada, de esa manera si
            % obtenemos que 'encaja' la matriz recibida con la pre-programada, podemos obtener la posición sin
            % tener que rotar de nuevo. Es una solucion bastante creativa, puede ser confusa
            posiciones = [1 4 7;
                          2 5 8;
                          3 6 9];
            
            col_posiciones = [1 1 1 2 2 2 3 3 3];
            fil_posiciones = [1 2 3 1 2 3 1 2 3];
            
            copia = posiciones;

            for i=1:4
                if(matriz == [1 0 0;0 2 0;0 0 1]) %#ok<BDSCA>
                    fila=1;
                    columna=2;
                    break;
                end
                
                matriz = rot90(matriz);
                copia = rot90(copia);
            end
            
            if(fila>0 && columna>0)
                c = col_posiciones(copia(fila,columna));
                f = fil_posiciones(copia(fila,columna));
            else
                c = 0;
                f = 0;
            end
        end
        
        function matriz3x3 = convertirVectorMatriz3x3(vector)
            % como trabajamos con vectores de 9 elementos, esta funcion es muy util
            matriz3x3 = zeros(3);
            matriz3x3(:) = vector(:);
            matriz3x3 = matriz3x3';
            
        end
 
        function turno_nuevo = alternarTurno(turno_actual)
            % si el turno era 1, lo cambia a 2, si era 2 lo cambia a 1
            turno_nuevo = -1;
            if(turno_actual == 1)
                turno_nuevo = 2;
            else if(turno_actual == 2)
                turno_nuevo = 1;
                end
            end
            return
        end
        
        function booleano = noTieneCeros(matriz)
            % verifica si queda algun cero en el contenido del arbol (matriz)
            booleano = true;
            for i=1:length(matriz)
                if(matriz(i) == 0)
                    booleano = false;
                    return
                end
            end
        end
        
        function resultado = analizarEstado(matriz)
            % Codigo proporcionado en el script 'checkBoard', modificado saber si gano o perdio un nodo especifico
            % No se agrega return porque esperamos el peor caso (en un nodo final, puede haber dos ganadores por
            % 'error'. Mas que error, es algo a proposito, ya que asi los pesos nos traen más informacion
            resultado = 0;
            if ~isempty(  find( sum( matriz == 1, 2 ) == 3, 1 )  )
                resultado = -1;
            elseif ~isempty(  find( sum( matriz == 1, 1 ) == 3, 1 )  )
                resultado = -1;
            elseif sum(sum( (matriz == 1).*eye(3,3) ) ) == 3
                resultado = -1;
            elseif sum(sum( (matriz == 1).*rot90(eye(3), 1) ) ) == 3
                resultado = -1;
            end
            
            if ~isempty(  find( sum( matriz == 2, 2 ) == 3, 1 )  )
                resultado = 1;
            elseif ~isempty(  find( sum( matriz == 2, 1 ) == 3, 1 )  )
                resultado = 1;
            elseif sum(sum( (matriz == 2).*eye(3,3) ) ) == 3
                resultado = 1;
            elseif sum(sum( (matriz == 2).*rot90(eye(3), 1) ) ) == 3
                resultado = 1;
            end
        end

        function jugada = elegirSiguienteJugada(l)
            % Una vez generada todo el arbol con sus pesos, elegiremos (del nivel 1) el nodo con mayor peso
            nodo_elegido = 1;
            jugada = 0;
            puntero = l;
            mayor = -inf;
            if(isempty(puntero.l))
                jugada = 1;
                return
            end
            
            while(puntero.peso >= 0 || puntero.peso < 0)
                % Comparacion hecha a causa de 'nan'
                if(puntero.peso > mayor)
                   mayor = puntero.peso;
                   qunt = puntero;
                   jugada = nodo_elegido;
                
                elseif(puntero.peso == mayor)
                    try
                        if( sum(qunt.posicion == 'esquina') == numel('esquina'))
                            qunt.peso = qunt.peso + 3;
                        elseif(sum(qunt.posicion == 'centro') == numel('centro'))
                            qunt.peso = qunt.peso + 2;
                        end
                    catch
                        
                    end
                    try
                        if(sum(puntero.posicion == 'esquina') == numel('esquina'))
                            puntero.peso = puntero.peso + 3;
                        elseif(sum(puntero.posicion == 'centro') == numel('centro'))
                            puntero.peso = puntero.peso + 2;
                        end
                    catch
                        
                    end
                    nodo_elegido = 1;
                    jugada = 0;
                    puntero = l;
                    mayor = -inf;
                    continue
                end
                
                puntero = puntero.h;
                
                if(isempty(puntero))
                   break; 
                end
                
                nodo_elegido = nodo_elegido + 1;
                
                
                
            end
        end
        
        function lugar = posicionJugada(pos)
            
            esquinas = [1,3,7,9];
            
            % 1 2 3; 4 5 6; 7 8 9
            if(pos == 5)
                lugar = 'centro';
                return
            else
                for i=1:numel(esquinas)
                   if(pos == esquinas(i))
                       lugar = 'esquina';
                       return
                   end
                end
                
                lugar = 'lado';
                return
                
            end
            
           
            
            
        end

        function total = calcularNodosHijos(espacios_disponibles)
            
            % n!*sumatorio(1/(n-i)!) en donde i va desde 1 hasta n
            n = espacios_disponibles;
            
            parte_factorial = factorial(n);
            sumatorio = 0;
            
            for i=1:n
                sumatorio = sumatorio + (1/factorial(n-i));
            end
            total = parte_factorial*sumatorio;
            
        end
        
        function [fila,columna] = usarJugadaElegidaEnEspacioDisponible(matriz_inicial, limite)
            % Esta funcion elige un espacio en blanco y aplica la jugada elegida en la funcion
            % elegirSiguienteJugada(lista), primero transforma en 'unos' los espacios disponibles y la variable
            % limite nos permite ir recorriendo los 'unos' hasta llegar al 'uno' que nosotros queremos (la posicion)
            matriz = (zeros(3) == matriz_inicial); % obtiene los espacios disponibles
            matriz = matriz';
            matriz = matriz(:)';
            fila = 1;
            columna = 1;
            
            contador = limite;
            
            for i=1:numel(matriz)
                columna = mod(i,3);
                if(columna == 0)
                    columna = 3;
                end
                if(i == 4 || i == 7)
                   fila = fila + 1;
                end
                
                if(matriz(i) == 1)
                    contador = contador - 1;
                    if(contador == 0)
                        break;
                    end
                end  
            end
        end
        
        function ceros = contarCeros(matriz)
            vector = (matriz == zeros(3));
            vector = vector(:);
            ceros = sum(vector);
            
        end
        
        function nx = jugadasPosiblesNX(matriz)
            vec = matriz';
            vec = vec(:);
            vec = vec';
            for i=1:9
               if(vec(i) == 2)
                   vec(i) = 10;
               end
            end
            
            mat = vec2mat(vec,3);
            nx = 0;
            for i=1:3
%                if sum(mat(:,i)) == 2
%                    % columnas
%                    nx = nx + 1;
%                end
               if sum(mat(:,i)) == 1
                   % columnas
                   nx = nx + 1;
               end
%                if sum(mat(i,:)) == 2
%                    % columnas
%                    nx = nx + 1;
% 
%                end
               if sum(mat(:,i)) == 1
                   % columnas
                   nx = nx + 1;

               end
            end
            
%             if sum(diag(mat)) == 2
%                 columnas
%                 nx = nx + 1;
%             end
            if sum(diag(mat)) == 1
                % columnas
                nx = nx + 1;
            end
%             if sum(diag(rot90(mat))) == 2
%                 % columnas
%                 nx = nx + 1;
%             end
            if sum(diag(rot90(mat))) == 1
                % columnas
                nx = nx + 1;
            end
                
        end
        
        function ny = jugadasPosiblesNO(matriz)
            vec = matriz';
            vec = vec(:);
            vec = vec';
            
            for i=1:9
               if(vec(i) == 1)
                   vec(i) = 10;
               end
            end
            
            mat = vec2mat(vec,3);
            
            ny = 0;
            for i=1:3
%                if sum(mat(:,i)) == 4
%                    % columnas
%                    ny = ny + 1;
%                end
               if sum(mat(:,i)) == 2
                   % columnas
                   ny = ny + 1;
               end
%                if sum(mat(i,:)) == 4
%                    % columnas
%                   ny = ny + 1;
% 
%                end
               if sum(mat(:,i)) == 2
                   % columnas
                   ny = ny + 1;

               end
            end
            
%             if sum(diag(mat)) == 4
%                 % columnas
%                 ny = ny + 1;
%             end
            if sum(diag(mat)) == 2
                % columnas
               ny = ny + 1;
            end
%             if sum(diag(rot90(mat))) == 4
%                 % columnas
%                 ny = ny + 1;
%             end
            if sum(diag(rot90(mat))) == 2
                % columnas
                ny = ny + 1;
            end
                
        end
    end
    
    
end