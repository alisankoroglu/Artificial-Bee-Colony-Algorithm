function z = RBFun_ABC(x,y)   
    z = (1-x).^(2)+ 100.*((y-(x.^(2))).^(2));
end