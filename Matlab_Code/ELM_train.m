function [parameters,Ytrain_hat] = ELM_train(X_train,Y_train,hidden_neurons)
% This function trains the ELM model

% Input description:
% X_train, Y_train: Training data and label
% hidden_neurons: #neurons in hidden layer

% Output desciption
% parameters: stores the weight matrices
% Ytrain_hat : predicted one-hot encoded output 

input_nodes =  size(X_train,2);

% input to hidden layer weight random initialization 
% W10= rand(input_nodes,hidden_neurons)*2-1;
W10=LFSR(input_nodes,hidden_neurons);
parameters.W10 = W10;

% hidden layer output
H = ReLU(X_train*W10);
parameters.H=H;

% matching perceptron value with generated in verilog 
Perceptron_img0=zeros(hidden_neurons,2);
for p=1:hidden_neurons 
 Perceptron_img0(p,1)=p-1;
end
Perceptron_img0(:,2)=H(1,:);

parameters.Perceptron_img0=Perceptron_img0;
%fprintf('Perceptron(1)=');
%disp(H(1,1));
%fprintf('Perceptron1_bin=');
%p=H(1,1);
%p=fi(p,1,32,24);
%p=p.bin;
%disp(p);

% hidden to output layer weight
W21 = pinv(H)*Y_train;
parameters.W21 = W21;

% prediction from output layer 
Ytrain_hat = H*W21;
Ytrain_hat=(Ytrain_hat==max(Ytrain_hat,[],2));

end