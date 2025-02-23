function [trail,P,fit,f] = GenNewSolRB(lb,ub,Np,n,P,fit,trail,f,D)

j = randi(D,1); % randomly selected variable that is to be changed
p = randi(Np,1); % randomly selected a partner

while (p==n)
    p = randi(Np,1);
end
        
    phi=(-1)+(1-(-1))*rand; % generate a rondom number between -1 to 1 

    Xnew=P(n,:);
    
    Xnew(j)=P(n,j)+phi*(P(n,j)-P(p,j)); % generating a solution
    %Vij=Xij+Qij(Xij-Xkj)
    Xnew(j)=min(Xnew(j),ub(j));
    Xnew(j)=max(Xnew(j),lb(j));
    
    ObjNewSol=RBFun_ABC(Xnew(1,1),Xnew(1,2));
    [FitnessNewSol,~]=CalFitRB(ObjNewSol,Xnew(1,1),Xnew(1,2));
     
    if FitnessNewSol > fit(n)
        P(n,:) = Xnew;
        fit(n) = FitnessNewSol;
        f(n) = ObjNewSol;
        trail(n) = 0 ;
    else
        trail(n) = trail(n) + 1;
    end

end