function [W1,W2,W3,B1,B2,B3] = create_new_generation(best_W1, best_W2, best_W3, best_B1, best_B2, best_B3, generation_size)

    crossover_size = size(best_W1,3);

    input_size = size(best_W1,1);
    hidden_size = size(best_W1,2);
    output_size = size(best_W3,2);
    
    %%% WEIGHT COMBINATIONS %%%
    
    %Set W1 for each individual of the new generation to be equal to one of the parents
     W1 = best_W1(:,:,1+floor((crossover_size)*(rand(1,generation_size))));
     %Choose random positions where 2cnd parent will be set
     P1 = rand(input_size, hidden_size, generation_size);
     %Choose new parent for each individual in the new generation 
     new_P1 = best_W1(:,:,1+floor((crossover_size)*(rand(1,generation_size))));
     %Set 2cnd parent weights
     W1(P1<=0.5) = new_P1(P1<=0.5);
     
     W2 = best_W2(:,:,1+floor((crossover_size)*(rand(1,generation_size))));
     P2 = rand(hidden_size, hidden_size, generation_size);
     new_P2 = best_W2(:,:,1+floor((crossover_size)*(rand(1,generation_size))));
     W2(P2<=0.5) = new_P2(P2<=0.5);
     
     W3 = best_W3(:,:,1+floor((crossover_size)*(rand(1,generation_size))));
     P3 = rand(hidden_size, output_size, generation_size);
     new_P3 = best_W3(:,:,1+floor((crossover_size)*(rand(1,generation_size))));
     W3(P3<=0.5) = new_P3(P3<=0.5);
     
     %%%%%%%%%%%%%%%%%%%%%%
     
     %%% BIAS COMBINATIONS %%%
     B1 = best_B1(:,:,1+floor((crossover_size)*(rand(1,generation_size))));
     PB1 = rand(1, hidden_size, generation_size);
     new_PB1 = best_B1(:,:,1+floor((crossover_size)*(rand(1,generation_size))));
     B1(PB1<=0.5) = new_PB1(PB1<=0.5);
     
     B2 = best_B2(:,:,1+floor((crossover_size)*(rand(1,generation_size))));
     PB2 = rand(1, hidden_size, generation_size);
     new_PB2 = best_B2(:,:,1+floor((crossover_size)*(rand(1,generation_size))));
     B2(PB2<=0.5) = new_PB2(PB2<=0.5);
     
     B3 = best_B3(:,:,1+floor((crossover_size)*(rand(1,generation_size))));
     PB3 = rand(1, output_size, generation_size);
     new_PB3 = best_B3(:,:,1+floor((crossover_size)*(rand(1,generation_size))));
     B3(PB3<=0.5) = new_PB3(PB3<=0.5);
     
%     W1 = best_W1(:,:,1+floor((crossover_size)*(rand(1,generation_size))));
%     W2 = best_W2(:,:,1+floor((crossover_size)*(rand(1,generation_size))));
%     W3 = best_W3(:,:,1+floor((crossover_size)*(rand(1,generation_size))));
%     B1 = best_B1(:,:,1+floor((crossover_size)*(rand(1,generation_size))));
%     B2 = best_B2(:,:,1+floor((crossover_size)*(rand(1,generation_size))));
%     B3 = best_B3(:,:,1+floor((crossover_size)*(rand(1,generation_size))));
%     
%     splits = zeros(1,crossover_size);
%     for k = 1:crossover_size
%        splits(k) = k*(1/crossover_size); 
%     end
%         
%     for i=1:generation_size
%        W1_ = W1(:,:,i);
%        W2_ = W2(:,:,i);
%        W3_ = W3(:,:,i);
%        B1_ = B1(:,:,i);
%        B2_ = B2(:,:,i);
%        B3_ = B3(:,:,i);
%        
%        P1 = rand(input_size, hidden_size);
%        P2 = rand(hidden_size, hidden_size);
%        P3 = rand(hidden_size, output_size);
%        PB1 = rand(1, hidden_size);
%        PB2 = rand(1, hidden_size);
%        PB3 = rand(1, output_size);
%        
%        for j=1:crossover_size
%             new_P1 = best_W1(:,:,j);
% 
%             new_P2 = best_W2(:,:,j);
% 
%             new_P3 = best_W3(:,:,j);
% 
%             new_PB1 = best_B1(:,:,j);
% 
%             new_PB2 = best_B2(:,:,j);
% 
%             new_PB3 = best_B3(:,:,j);
%             
%             if j == 1
%                 W1_(P1<=splits(j)) = new_P1(P1<=splits(j));
%                 W2_(P2<=splits(j)) = new_P2(P2<=splits(j));
%                 W3_(P3<=splits(j)) = new_P3(P3<=splits(j));
%                 B1_(PB1<=splits(j)) = new_PB1(PB1<=splits(j));
%                 B2_(PB2<=splits(j)) = new_PB2(PB2<=splits(j));
%                 B3_(PB3<=splits(j)) = new_PB3(PB3<=splits(j));
%             else
%                 W1_(P1<=splits(j) & P1 > splits(j-1)) = new_P1(P1<=splits(j) & P1 > splits(j-1));
%                 W2_(P2<=splits(j) & P2 > splits(j-1)) = new_P2(P2<=splits(j) & P2 > splits(j-1));
%                 W3_(P3<=splits(j) & P3 > splits(j-1)) = new_P3(P3<=splits(j) & P3 > splits(j-1));
%                 B1_(PB1<=splits(j) & PB1 > splits(j-1)) = new_PB1(PB1<=splits(j) & PB1 > splits(j-1));
%                 B2_(PB2<=splits(j) & PB2 > splits(j-1)) = new_PB2(PB2<=splits(j) & PB2 > splits(j-1));
%                 B3_(PB3<=splits(j) & PB3 > splits(j-1)) = new_PB3(PB3<=splits(j) & PB3 > splits(j-1));
%             end
%        end
%        W1(:,:,i) = W1_;
%        W2(:,:,i) = W2_;
%        W3(:,:,i) = W3_;
%        B1(:,:,i) = B1_;
%        B2(:,:,i) = B2_;
%        B3(:,:,i) = B3_;
%     end
    
end
    
  