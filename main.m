%% Main File
% The main file for DE optimization algorithm useage.


%%
F = 0.5;
CR = 0.9;
popsize = 200;
maxIteration = 10000;
[globalBest, globalBestFitness, FitnessHistory] = DE(popsize, maxIteration, F, CR, @Fun);

% For post-process
figure(1)
plot(log10(FitnessHistory))