% 
% import stuff
% 
:- 
    load_files([my_agent, wumpus_world]).

% 
% load the world, and the agent
% 
[wumpus_world].
[my_agent].

:-
    % 
    % put the world into motion
    % 
    wumpus:evaluate_agent(1, Score, Time),
    write('Score:'),write(Score),write('\n'),
    write('Time:'),write(Time),write('\n').