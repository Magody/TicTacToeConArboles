clc;
clear variables;
global matrix;
global turno;
global victorias_uno;
global victorias_dos;
global empates;
global total;
global modo;
global detener;
detener = false;
addpath('Toolbox TicTacToe');
victorias_uno = 0;
victorias_dos = 0;
empates = 0;
total = 0;
estado_partida = 0;
turno = setWhoGoesFirst();
matrix = zeros(3);

modo = 1;
interface1;