classdef Arbol < handle
    
    properties
        nivel;          % cada generacion es un nivel de profundidad
        contenido;      % matriz
        h;        % tipo Arbol
        l;          % tipo Arbol, representa a un hijo y su cadena de hs
        peso;           % define si ha ganado, perdido o empatado en cualquier nodo
        nx_no;
        posicion;
    end
    
    methods
        
        function obj = Arbol()
            % constructor
            obj.nivel = nan;
            obj.contenido = [];
            obj.h = [];
            obj.l = [];
            obj.peso = nan;
            obj.nx_no = nan;
            obj.posicion = nan;
        end
        
        function agregarContenido(obj,contenido)
            obj.contenido = contenido;
        end
        
        function arreglo = generarNodos(obj, matriz, turno, nivel)
            % funcion recursiva que retorna una lista con todas sus siguientes encadenaciones(siguientes jugadas turnadas)
            % la matriz recibe un vector de 9 elementos, el turno principal y el nivel principal
            if(Controlador.noTieneCeros(matriz))
                % Si ya no quedan ceros, significa que ya no hay mas posibles jugadas, si no se aplico un recorte
                % antes, este es el caso base de la funcion recursiva
                arreglo = [];  
                return
            end
            
            arreglo = Arbol();
            puntero = arreglo;
            
            for i=1:length(matriz)
                siguiente_matriz = matriz;  % renueva el valor original de la matriz
                if(siguiente_matriz(i) == 0)
                    siguiente_matriz(i) = turno;  % realiza la jugada segun el turno de quien le toque
                    
                    % ya que usamos un vector de 9 elementos, para agregar contenido hacemos la conversion
                    puntero.agregarContenido(Controlador.convertirVectorMatriz3x3(siguiente_matriz));
                    
                    puntero.posicion = Controlador.posicionJugada(i);
                    puntero.nivel = nivel;
                    
                    % CONDICION DE RECORTE
                    estado = Controlador.analizarEstado(puntero.contenido);
                    if(estado ~= 0)
                        %recorte del arbol, si ya gana alguien, no genera mas hs ni hijos
                        espacios_disponibles = Controlador.contarCeros(Controlador.convertirVectorMatriz3x3(siguiente_matriz));
                        puntero.peso = estado + Controlador.calcularNodosHijos(espacios_disponibles)*estado;
                        if(nivel == 1 || nivel == 2)
                            puntero.peso = puntero.peso * 100;
                        end
                        
                        return;
                    end
                    
                    % Manera recursiva de seguir agregando nuevas listas(hijos) en cada nivel
                    puntero.l = obj.generarNodos(siguiente_matriz, Controlador.alternarTurno(turno), nivel+1);
                    % Cuando genera el ultimo hijo posible, genera los enlaces de cada nivel
                    if(~isempty(puntero.l))
                        if(puntero.l.peso >= 0 || puntero.l.peso <0) % verifica que no es nan
                            puntero.peso = obj.sumaPesosHijos(puntero.l);
                            
                        end
                    end
                    
                    if(~Controlador.noTieneCeros(siguiente_matriz))
                        % Este if permite no crear un arbol al terminal de todos los nodos
                        puntero.h = Arbol();
                        puntero = puntero.h; % recorre para agregar todo a sus hs
                    elseif(Controlador.noTieneCeros(siguiente_matriz))
                        % Aqui solo entran los nodos totalmente terminales. Y son la base para ir autosumando
                        puntero.peso = Controlador.analizarEstado(Controlador.convertirVectorMatriz3x3(siguiente_matriz));
                    end
                end
            end
        end
        
        function suma_pesos = sumaPesosHijos(~,l)
            % retorna la suma de los pesos de la lista(hijos) dada de cierto nivel
            puntero = l;
            suma_pesos = 0;
            while(~isempty(puntero.contenido))
                suma_pesos = suma_pesos + puntero.peso;
                if(~isempty(puntero.h))
                    puntero = puntero.h;
                elseif(isempty(puntero.h))
                    return;
                end
            end
            
            
        end
        
        function leerNiveles(obj, puntero, niveles, contador)
            % recibe como parametros, todo el arbol y cuantos niveles
            % quiere leer. Contador debe iniciar en 0 siempre ( es para
            % realizar las impresiones, es un auxiliar
            if(niveles == 0)
                return
            end

            try
                if(~isempty(puntero))
                    while(~isempty(puntero) && ~isempty(puntero.contenido))
                        
                        if(contador ~= 0 && contador ~= 1)
                            guiones = '';
                            for i=1:contador
                                guiones = strcat(guiones,'-');
                            end
                            fprintf('%sPeso de la matriz = %d, Nivel %d: \n',guiones,puntero.peso,contador);
                            disp(puntero.contenido);
                            
                        else if(contador == 1)
                                fprintf('Raiz(Nivel uno): \n');
                                disp(puntero.contenido);
                            end
                        end

                        obj.leerNiveles(puntero.l, niveles-1, contador+1);
                        
                        
                        puntero = puntero.h;
                        
                    end
                end
                
                 
            catch error
                disp(['Error?: ',error.message]);
                
            end
                
            
        end
        
    end
    
    
    
        
    
    
end