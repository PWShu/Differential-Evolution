function [globalBest, globalBestFitness, FitnessHistory] = DE(popsize, maxIteration, F, CR, Fun)

% Parameters for objective function.
dim = 30;
LB = -100 * ones(1, dim);
UB = 100 * ones(1, dim);

% Initialization swarm.
Sol(popsize, dim) = 0; % Declare memory.
Fitness(popsize) = 0;
for i = 1:popsize
    Sol(i,:) = LB+(UB-LB).* rand(1, dim);
    Fitness(i) = Fun(Sol(i,:));
end

% Loop whole population, and find the best solution.
[fbest, bestIndex] = min(Fitness);
globalBest = Sol(bestIndex,:); % best solution
globalBestFitness = fbest; % best solution's fitness value.

% Start Simulation.
for time = 1:maxIteration
    for i = 1:popsize
        % for each solution(candidate) in the swarm, use it to generate new
        % trial solution. There are two main step to form a trial solution,
        % which are 'mutate' and 'crossover'.
        
        % stage1: Mutate Operation.
        % Choose three mutally different integer index within [1,popsize].
        
        %%r = randperm(popsize, 3);  
        r = randperm(popsize, 5);
        % Combine these chosen solutions to generate a mutant solution.
        % Here we use 'rand/1' strategy.
        mutantPos = Sol(r(1),:) + F * (Sol(r(2),:) - Sol(r(3),:)) ...
            + F * (Sol(r(4),:) - Sol(r(5),:));
        
        % stage2: Crossover Operation.
        % Generate Crossover Vector for Xi at time t.
        % specify one dim, which allows at least one dim in the original 
        % solution to be changed.
        jj = randi(dim);  % choose at least one dim to be changed.
        % start to change the solution bit by bit.
        % crossoverPos is a combination of mutantPos and original solution.
        for d = 1:dim
            if rand() < CR || d == jj
                crossoverPos(d) = mutantPos(d);
            else
                crossoverPos(d) = Sol(i,d);
            end
        end
        
        % Check out wether generated solution beyond the search space.
        % Using naive limit strategy to bound each dimenssion of solution.
        % if some dim. exceed upper bound(UB), simply assign it to UB.
        crossoverPos(crossoverPos>UB) = UB(crossoverPos>UB); 
        crossoverPos(crossoverPos<LB) = LB(crossoverPos<LB);
        
        % Evaluate the generated solution and compare with original solun.
        evalNewPos = Fun(crossoverPos);
        % if the new solution is better than original one,
        % accept the new solution and its coressponding fitness value.
        if evalNewPos < Fitness(i)
            Sol(i,:) = crossoverPos;
            Fitness(i) = evalNewPos;
        end
    end
    % After loop the whole population, we need to revise the 'best choice':
    % both best solution and its objective function value.
    [fbest, bestIndex] = min(Fitness);
    globalBest = Sol(bestIndex,:);
    globalBestFitness = fbest;
    
    % Store the best solution in each step of total optimization process.
    FitnessHistory(time) = fbest;
    
    % User-friendly output.
    disp(['At iteration ' num2str(time)...
        ',Obejctive Function:' num2str(fbest)]);
end
% Optimization Process flag;
disp('Optimization End.');
disp(['Optimization Result:' num2str(globalBestFitness)]);
end