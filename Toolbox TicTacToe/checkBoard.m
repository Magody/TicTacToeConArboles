function status = checkBoard(board)
% checkBoard(board) checks the current status of the board to determine the
% current status of the game.
% 
% Syntaxis:
%
% status = checkBoard(board)
%
% Input:
% 
% board: [3x3] matrix of integers where each element is either 0, 1, or 2:
%
% 0 = available position
% 1 = positions chosen by agent 1
% 2 = positions chosen by agent 2
%
% Output:
%
% status: structure with the fields 'state' and 'winner'. When there is
% a winner status.state = 'win' and status.winner indicates which agent
% won. When the game is still in progress, then status.state = 'inProgress'
% and status.winner = []
%
% Marco E. Benalcázar, Ph.D.
% marco.benalcazar@epn.edu.ec

if size(board,1) ~= 3 || size(board,2) ~= 3
    error('La matriz del juego no es de 3 x 3');
else
    % Player 1:
    if ~isempty(  find( sum( board == 1, 2 ) == 3, 1 )  )
        status.state = 'win';
        status.winner = 1;
        status.line = 'row';
        return;
    elseif ~isempty(  find( sum( board == 1, 1 ) == 3, 1 )  )
        status.state = 'win';
        status.winner = 1;
        status.line = 'col';
        return;
    elseif sum(sum( (board == 1).*eye(3,3) ) ) == 3
        status.state = 'win';
        status.winner = 1;
        status.line = 'mDiag';
        return;
    elseif sum(sum( (board == 1).*rot90(eye(3), 1) ) ) == 3
        status.state = 'win';
        status.winner = 1;
        status.line = 'sDiag';
        return;
    end
    % Player 2:
    if ~isempty(  find( sum( board == 2, 2 ) == 3, 1 )  )
        status.state = 'win';
        status.winner = 2;
        status.line = 'row';
        return;
    elseif ~isempty(  find( sum( board == 2, 1 ) == 3, 1 )  )
        status.state = 'win';
        status.winner = 2;
        status.line = 'col';
        return;
    elseif sum(sum( (board == 2).*eye(3,3) ) ) == 3
        status.state = 'win';
        status.winner = 2;
        status.line = 'mDiag';
        return;
    elseif sum(sum( (board == 2).*rot90(eye(3), 1) ) ) == 3
        status.state = 'win';
        status.winner = 2;
        status.line = 'sDiag';
        return;
    elseif sum(board(:) == 0) == 0
        status.state = 'tie';
        status.winner = [];
        status.line = [];
        return;
    else
        status.state = 'inProgress';
        status.winner = [];
        status.line = [];
    end
end
return