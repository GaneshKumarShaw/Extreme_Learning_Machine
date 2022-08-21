function decimal_value=TwosCom(Register)
decimal_value=Register;
flag=17;

for m=16:-1:1
    flag=flag-1;
    if Register(1,m)==1
     break 
   end
end
decimal_value(1,flag:16)=Register(1,flag:16);
for n=1:flag-1
    if Register(1,n)==1
        decimal_value(1,n)=0;
    else
        decimal_value(1,n)=1;
    end
end
end
    