% function [W10]=LFSR(input_nodes,hidden_neurons)

function W10 = LFSR(input_nodes,hidden_neurons)
%generates random numbers for W10 matrix

%But 8 bits are selectively used for random number generation
%zero=0;
W10=zeros(input_nodes,hidden_neurons);
X=int8(0);
decimal_value=0;
for j=1:hidden_neurons
    for i=1:input_nodes

  %     if zero==0 
      W10(i,j)=decimal_value*(2^(-7)); 
     % W10(i,j)=decimal_value;
     wire1=bitxor(bitget(X,4,'int8'),bitget(X,5,'int8'));
       wire2=bitxor(bitget(X,6,'int8'),bitget(X,8,"int8"));
       wire=not(bitxor(wire1,wire2));
       temp(1)=wire;
       temp(2:8)=bitget(X,[1:7],'int8');
       shift=int8(wire);
       decimal_value=-(2^7)*temp(1)+(2^6)*temp(2)+(2^5)*temp(3)+(2^4)*temp(4)+(2^3)*temp(5)+(2^2)*temp(6)+(2)*temp(7)+temp(8);
       X = bitshift(X,1,'int8')+shift;
     

 %   zero=1;
%        else
% 
%        wire1=bitxor(bitget(X,1,'int8'),bitget(X,3,'int8'));
%        wire2=bitxor(bitget(X,4,'int8'),bitget(X,5,"int8"));
%        wire=not(bitxor(wire1,wire2));
%        temp(1)=wire;
%        temp(2:8)=bitget(X,[1:7],'int8');
%        shift=int8(wire);
%        decimal_value=-(2^7)*temp(1)+(2^6)*temp(2)+(2^5)*temp(3)+(2^4)*temp(4)+(2^3)*temp(5)+(2^2)*temp(6)+(2)*temp(7)+temp(8);
%        X = bitshift(X,1,'int8')+shift;
%      W10(i,j)=decimal_value*(2^(-7));
%     W10(i,j)=decimal_value;
%       zero=1;

   % end
      
    end

end

% W10 = W10*2^(-10);
end


