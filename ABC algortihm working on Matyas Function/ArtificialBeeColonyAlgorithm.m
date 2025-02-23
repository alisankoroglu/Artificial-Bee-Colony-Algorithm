lb = [-10 -10]; % lower bound 
ub = [10 10]; % upper bound

cs = 200; % Colony size
Np = cs/2; % employed bee number and number of solution
D = length(lb); % number of variables
T = 200; % iteration number
limit = 5;   % try limit, limit = cs*d/2 could be used
inst_M = []; % help us in ploting graph

f = NaN(Np,1); % for storing the obective function values
fit = NaN(Np,1); % for storing the Fitness values of the solutions
trail = NaN(Np,1); % for storing the trail values of each solution area

% Xij = Xj(min)+ rand(0,1)*(Xj(max)-Xj(min))
P = repmat(lb, Np, 1) + rand(Np, D).*repmat((ub-lb), Np, 1); % generated initial solutions  


for p =1:Np

    f(p) = MatyasFun_ABC(P(p,1),P(p,2)); % calculated objective function values for all the solutions   
    fit(p) = CalFitMatyas(f(p)); %calculated fitness values of all solutions
end

[bestobj, ind] = min(f); % saved best obective fuction value and its index
bestSol = P(ind,:); % saved best solution

% end of Initialization phase

for t = 1:T
 
 % Employed bee phase
    
    for i = 1:Np
        [trail,P,fit,f] = GenNewSolMatyas(lb,ub,Np,i,P,fit,trail,f,D);
    end
    
 % Onlooker Bee phase
   
    probability = fit/sum(fit);
    m = 0;
    n = 1;
    while (m<Np)
        if (rand<probability(n)) % generate a random number and compare it with probability
            [trail, P, fit, f] = GenNewSolMatyas(lb,ub, Np, n, P, fit, trail, f, D);
            m = m + 1;
        end
        n = mod(n, Np) + 1; % increasing n by 1 and setes n back to 1 if it is greater than Np
    end

    [bestobj,ind] =min([f;bestobj]); % stacking the bestobj to the objective function value matrix than saving the minimun of all the values again in bestobj
    CombinedSol = [P;bestSol]; % we stacked the solution corresponding to bestobj in the main solution matrix that is P
    bestSol = CombinedSol(ind,:); % Saved the best solution which is at the position "ind"

  % Scout Bee phase

  [val, ind] = max(trail);

  if (val>limit)
      trail(ind) = 0;
      P(ind,:) = lb + rand(1,D).*(ub-lb); % generating a new random solution
      f(ind) = MatyasFun_ABC(P(ind,1),P(ind,2)); % calculated objective value of the new solution
      fit(ind) = CalFitMatyas(f(ind)); % calculated fitness value of the new solution
  end
  
  inst_M(t) = bestobj;

end

 [bestobj,ind] =min([f;bestobj]); % stacking the bestobj to the objectine function value matrix than saving the minimun of all the values again in bestobj
    CombinedSol = [P;bestSol]; % we stacked the solution corresponding to bestobj in the main solution matrix that is P
    bestsol = CombinedSol(ind,:) % showing the best / optimal solution that we got
    objective_function = MatyasFun_ABC(bestsol(:,1),bestsol(:,2)) % showing the best objective function value of the best solution  
    
    % ploting 

    generations= 1:T;
    plot(generations,inst_M,"LineWidth",2);
    xlabel("Number of iterations");
    ylabel("Objective Funtion Value");
    title("Convergence Curve of ABC");