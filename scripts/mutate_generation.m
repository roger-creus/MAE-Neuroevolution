function [W1, W2, W3, B1, B2, B3] = mutate_generation(current_W1, current_W2, current_W3, current_B1, current_B2, current_B3, weight_prob, bias_prob, weight_range, bias_range, generation_size)
    input_size = size(current_W1,1);
    hidden_size = size(current_W1,2);
    output_size = size(current_W3,2);
    
    a_w = weight_range;
    b_w = -weight_range;
    
    a_b = bias_range;
    b_b = -bias_range;
    
    P1 = rand(input_size, hidden_size, generation_size);
    W1 = current_W1;
   
    W1(P1 <= weight_prob) = (b_w-a_w).*rand(1, size(W1(P1 <= weight_prob),1)) + a_w;
    
    
    P2 = rand(hidden_size, hidden_size, generation_size);
    W2 = current_W2;
    W2(P2 <= weight_prob) = (b_w-a_w).*rand(1, size(W2(P2 <= weight_prob),1)) + a_w;
    
    P3 = rand(hidden_size, output_size, generation_size);
    W3 = current_W3;
    W3(P3 <= weight_prob) = (b_w-a_w).*rand(1, size(W3(P3 <= weight_prob),1)) + a_w;
    
    PB1 = rand(1, hidden_size, generation_size);
    B1 = current_B1;
    B1(PB1 <= bias_prob) = (b_b-a_b).*rand(1, size(B1(PB1 <= bias_prob),1)) + a_b;
    
    PB2 = rand(1, hidden_size, generation_size);
    B2 = current_B2;
    B2(PB2 <= bias_prob) = (b_b-a_b).*rand(1, size(B2(PB2 <= bias_prob),1)) + a_b;
    
    PB3 = rand(1, output_size, generation_size);
    B3 = current_B3;
    B3(PB3 <= bias_prob) = (b_b-a_b).*rand(1, size(B3(PB3 <= bias_prob),1)) + a_b;
end