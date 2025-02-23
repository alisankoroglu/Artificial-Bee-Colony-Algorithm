function z = MatyasFun_ABC(x,y)
    
    % Matyas Function is f(x,y) = 0.26*(x^2*y^2)-0.48*x*y
    z = 0.26.*((x.^2)+(y.^2))-0.48.*(x.*y);

end