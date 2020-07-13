f = @Fun;
popsize = 50;
maxIteration = 1000;
F = 0.5;
CR = 0.9;
[gb_sade, gbf_sade, fh_sade] = SaDE(popsize, maxIteration, F, CR, f);
[gb_de, gbf_de, fh_de] = DE(popsize, maxIteration, F, CR, f);
plot(fh_sade)
hold on;
plot(fh_de)
grid on;
legend('SaDE', 'DE')