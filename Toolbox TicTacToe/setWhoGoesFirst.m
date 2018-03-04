function player = setWhoGoesFirst()
% setWhoGoesFirst flips a fair coin and decides which agent goes first. 
%
% Syntaxis:
%
% player = setWhoGoesFirst()
%
% Output:
% 
% player: Integer that indicates who plays first. If player = 1, then agent 1
% goes first; otherwise if player = 2, then agent 2 goes first
%
% Marco E. Benalcázar, Ph.D.
% marco.benalcazar@epn.edu.ec

% Drawing the turn using a fair coin
if rand >= 0.5
    player = 1;
else
    player = 2;
end 
return