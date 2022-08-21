function [Ytest_hat] = ELM_test(X_test,parameters)
% This function tests the ELM model

% Input description:
% X_test, Y_test: Testing data and label
% parameters: contain weight matrices

% Output desciption
% Ytest_hat : predicted one-hot encoded output 


% hidden layer output
H = ReLU(X_test*parameters.W10);

% prediction from output layer 
Ytest_hat = H*parameters.W21;
Ytest_hat= (Ytest_hat==max(Ytest_hat,[],2));

end

