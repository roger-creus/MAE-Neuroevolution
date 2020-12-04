function [W1, W2, W3] = initialize_weights(input_size, hidden_size, output_size, range, generation_size)
    a = range;
    b = -range;
    
    W1 = (b-a).*rand(input_size, hidden_size, generation_size) + a;
    W2 = (b-a).*rand(hidden_size, hidden_size, generation_size) + a;  
    W3 = (b-a).*rand(hidden_size, output_size, generation_size) + a;  
    
end