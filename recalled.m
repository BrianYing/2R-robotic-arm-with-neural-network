% Predicts training and test data with given weights
% recalled.m

function test_pred = recalled(test_data, weights_1, weights_2)
%{
Input: test_data - data input
       weights_1 - weight 1
       weights_2 - weight 2
Output: test_pred - predicted value
%}
    num_test = size(test_data, 1);
    test_bias = ones(num_test, 1);
    test_pred = tanh([test_bias tanh(test_data * weights_1)] * weights_2);
end
