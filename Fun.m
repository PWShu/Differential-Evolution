function y = Fun(x)
%d = length(x);
%y = -20*exp(-0.2*sqrt((sum(x.^2))/d)) - exp(sum(cos(2*pi*x))./d)+ 20 + exp(1); 
y = sum(x.^2);
end