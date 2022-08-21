function [Ytest_hat] = ELM_test_fixed(X_test,parameters_fixed)
% This function tests the ELM model

% Input description:
% X_test, Y_test: Testing data and label
% parameters: contain weight matrices

% Output desciption
% Ytest_hat : predicted one-hot encoded output 


% hidden layer output
H_fixed = ReLU(X_test*parameters_fixed.w10);

% prediction from output layer 

Ytest_hat_fixed = H_fixed*parameters_fixed.w21;
Ytest_hat_d = double(Ytest_hat_fixed);
Ytest_hat= (Ytest_hat_d==max(Ytest_hat_d,[],2));

end

