function [B1, B2, B3] = initialize_bias(input_size, hidden_size, output_size, generation_size)
    B1 = zeros(1, hidden_size, generation_size);
    B2 = zeros(1, hidden_size, generation_size);  
    B3 = zeros(1, output_size, generation_size);  
end