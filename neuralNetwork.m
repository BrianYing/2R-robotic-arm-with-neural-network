% NeuralNetwork.m
% Two layer neural network
% For traning models for Inverse Kinematics

%{ 
Inputs: train_features - training samples
        train_labels - training labels
        num_hidden - number of hidden PEs
        gamma - learning rate
        momentum - momentum
        iter - number of epochs
        batch_size - epoch size
        tol - early stopping condition
Outputs: train_score - error of training score
         weights_1 - weight 1
         weights_2 - weight 2
%}

function [train_score, weights_1,weights_2] = neuralNetwork(train_features, train_labels, num_hidden, gamma, momentum, iter, batch_size, tol)
    % get number of input and output nodes
    num_input = size(train_features, 2);
    num_output = size(train_labels, 2);
    
    num_train = size(train_features, 1);
    train_bias = ones(num_train, 1);
    train_data = [train_bias train_features];

    % Initialize Weights
    weights_1 = rand(num_input+1,num_hidden).*0.2-0.1;
    weights_2 = rand(num_hidden+1,num_output).*0.2-0.1;
    
    
    % initialize previous delta terms for momentum
    prev_delta_1 = 0;
    prev_delta_2 = 0;
 
    num_batches = num_train / batch_size;
    
    learn_steps = [];
    train_err = [];
    
% Train over iter epochs
    for i = 1:iter
        % compute mini batches
        batch_start = mod(i-1,num_batches)*batch_size+1;
        batch_end = mod(i-1,num_batches+1)*batch_size;
        
        x = train_data(batch_start:batch_end,:);
        y = train_labels(batch_start:batch_end,:); 
        b = train_bias(batch_start:batch_end,:);
        
        % Forward propagation
        z_1 = x * weights_1; % n-by-10
        a_1 = [b tanh(z_1)]; % n-by-10
        z_2 = a_1 * weights_2; % n-by-1
        y_hat = tanh(z_2); % n-by-1

        % Check error convergence
        if recallScore(y_hat, y) < tol
            break;
        end        
     
        % Collect error at every 100 epochs
        if mod(i, 10) == 0
            learn_steps = [learn_steps i];
            
            train_pred = recall(train_data, weights_1, weights_2);
            train_score = recallScore(train_pred, train_labels);
            train_err = [train_err;train_score];
        end
            
        % Backward propagation - update weights
        delta_2 = gamma .* a_1.' * (tanhPrime(z_2) .* (y - y_hat));
        delta_1 = gamma .* x.' * ((((y - y_hat) .* tanhPrime(z_2)) * weights_2(2:end,:).') .* tanhPrime(z_1));
        weights_2 = weights_2 + delta_2 + (momentum * prev_delta_2); % 10-by-1
        weights_1 = weights_1 + delta_1 + (momentum * prev_delta_1); % 2-by-10
        prev_delta_2 = delta_2;
        prev_delta_1 = delta_1;
    end

    train_pred = recall(train_data, weights_1, weights_2);
    train_score = recallScore(train_pred, train_labels);
    

% for 1/x data
   figure,
   plotError(learn_steps, train_err);
   hold on;
end

% predicts training data with given weights
function train_pred = recall(train_data, weights_1, weights_2)
    num_train = size(train_data, 1);
    train_bias = ones(num_train, 1);
    train_pred = tanh([train_bias tanh(train_data * weights_1)] * weights_2);
end

% mean squared error
function score = recallScore(pred, labels)
    score = 1 / length(pred) * sum(abs(pred - labels));
end

% derivative of tanh
function gradient = tanhPrime(x)
    gradient = 1 - tanh(x).^2;
end

% plot training error
function plotError(learn_steps, train_err)
    plot(learn_steps, train_err(:,1));
    hold on
    plot(learn_steps, train_err(:,2));
    title({'Training Error by Number of Learning Steps'})
    xlabel('Learning Steps');
    ylabel('Error');
    legend('train error t1', 'train error t2');
end
