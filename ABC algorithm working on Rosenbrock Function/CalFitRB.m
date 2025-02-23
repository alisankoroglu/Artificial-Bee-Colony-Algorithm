function [fit,violation] = CalFitRB(f,x,y)
    
    % constraint
    con = (x.^(2) + y.^(2))-2;

    if con>0
        violation = abs(con);
    else
        violation = 0 ;
    end

    lambda = 900000;

    % fitness(i)= if f(i)>=0,  1/(1+f(i) 
    %             if f(i)<0, 1+abs(f(i))

    if f>=0
        fit = 1/(1+f) - lambda.*(violation);
    else
        fit = 1+abs(f) - lambda.*(violation);
    end

end