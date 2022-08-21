function acc =check_acc(Y_hat,Y)

score =0;
m= size(Y,1);
for i = 1:m
    if isequal(Y_hat(i,:),Y(i,:))
        score= score+ 1;
    end
end
acc = (score/m)*100;
end


