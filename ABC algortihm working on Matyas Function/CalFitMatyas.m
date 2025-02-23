function fit = CalFitMatyas(f)

    % fitness(i) = if f(i)>=0,  1/(1+f(i) 
    %              if f(i)<0, 1+abs(f(i))

    if f>0
        fit = 1/(1+f);
    else
        fit = 1+abs(f);
    end

end