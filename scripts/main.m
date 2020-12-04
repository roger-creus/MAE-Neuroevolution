addpath 'D:\MAE-NN\mtimesx_20110223'

%NEURAL NETWORK
num_generations = 50;
generation_size = 8000;
crossover_size = 4;
weight_range = 1;
bias_range = 0.5;
weight_mutation_prob = 0.08;
bias_mutation_prob = 0.05;
input_size = 4;
output_size = 4;
hidden_size = 8;
max_time_steps = 500;
current_time_step = 1;
pretrained = 1;

%GAME DEFINITION
map_x = 10;
map_y = 10;
init_player_x = -5;
init_player_y = 5;
init_enemy_x = 5;
init_enemy_y = -5;
player_adv = 2;
enemy_distance_collision = 0.1;

%PLOTS
offsetDraw = 0.5;

%%%%% INITIALIZATION %%%%%

[W1, W2, W3] = initialize_weights(input_size, hidden_size, output_size, weight_range, generation_size);
[B1, B2, B3] = initialize_bias(input_size, hidden_size, output_size, generation_size);

mean_performance = zeros(1,num_generations);
max_performance = zeros(1,num_generations);
best_performance = 0;

if pretrained == 0
    
    %%%%%% TRAINING PHASE %%%%%%
    
    for i=1:num_generations
        L = ones(1,generation_size);
        R = zeros(1,generation_size);
        I = generate_initial_inputs(map_x, map_y, init_player_x, init_player_y,init_enemy_x, init_enemy_y, generation_size);

        current_time_step = 1;
        
        %%% GAMEPLAY %%%
        
        %All the generation plays at the same time
        while current_time_step < max_time_steps
            dead = find(L==0);
            
            %Check if all individuals have died
            if size(dead,2) == generation_size
                break
            end

            I(:,:,dead) = 0;
            W1(:,:,dead) = 0;
            W2(:,:,dead) = 0;
            W3(:,:,dead) = 0;
            B1(:,:,dead) = 0;
            B2(:,:,dead) = 0;
            B3(:,:,dead) = 0;
            
            %3D Feed Forward pass (dead individuals set to 0)
            OUTPUTS = softmax(mtimesx(ReLU(mtimesx(ReLU(mtimesx(I,W1) + B1), W2) + B2),W3) + B3);
            
            %Agent takes action and enemy does too accordingly
            [I,L,R] = take_action(I, OUTPUTS, L, R, map_x, map_y, player_adv, enemy_distance_collision);
            
            current_time_step = current_time_step+1;
        end

        %Store configuration of best individual ever seen
        [b,idx] = max(R);
        if b > best_performance
            writematrix(W1(:,:,idx),'model/W1.txt');
            writematrix(W2(:,:,idx),'model/W2.txt');
            writematrix(W3(:,:,idx),'model/W3.txt');
            writematrix(B1(:,:,idx),'model/B1.txt');
            writematrix(B2(:,:,idx),'model/B2.txt');
            writematrix(B3(:,:,idx),'model/B3.txt');
            best_performance = b;
            
        end
        %Printing generation
        i
        
        %%% REPRODUCTION + MUTATION %%%
        
        %Find best performing individuals in the generation
        best_ind = select_best_individuals(crossover_size, R);
        [W1,W2,W3,B1,B2,B3] = create_new_generation(W1(:,:,best_ind), W2(:,:,best_ind), W3(:,:,best_ind), B1(:,:,best_ind), B2(:,:,best_ind), B3(:,:,best_ind), generation_size);
        [W1,W2,W3,B1,B2,B3] = mutate_generation(W1,W2,W3,B1,B2,B3,weight_mutation_prob,bias_mutation_prob,weight_range,bias_range,generation_size);

        mean_performance(i) = mean(R);
        max_performance(i) = max(R);
        
        %Stopping if game is solved at any generation
        if max(R) == max_time_steps-1
           break 
        end
    end
    
    plot_train_performance(mean_performance, max_performance);
    
else
    %%%%%% VISUALIZATION OF BEST INDIVIDUAL %%%%%%
    
    mov = moviein(max_time_steps); 
    %Set up visualization
    draw_background(map_x, map_y, "k", offsetDraw)
    
    %Loading pre-trained individual
    path = 'model/';
    [W1, W2, W3, B1, B2, B3] = read_pretrained_network(path, 'W1.txt', 'W2.txt', 'W3.txt', 'B1.txt', 'B2.txt', 'B3.txt');
   
    %Configuration for a single gameplay
    I = generate_initial_inputs(map_x, map_y, init_player_x, init_player_y,init_enemy_x, init_enemy_y, generation_size);
    L = ones(1,1);
    R = zeros(1,1);
    
    %Stack of variables needed for the purpose of visualization of the gameplay
    previous_pos_X_player = [init_player_x (init_player_x)+1 (init_player_x)+1 init_player_x];
    previous_pos_Y_player = [(init_player_y)-1 (init_player_y)-1 init_player_y init_player_y];
    previous_pos_X_enemy = [init_enemy_x (init_enemy_x)+1 (init_enemy_x)+1 init_enemy_x];
    previous_pos_Y_enemy = [(init_enemy_y)-1 (init_enemy_y)-1 init_enemy_y init_enemy_y];
    current_pos_X_player = previous_pos_X_player;
    current_pos_Y_player = previous_pos_Y_player;  
    current_pos_X_enemy = previous_pos_X_enemy;
    current_pos_Y_enemy = previous_pos_Y_enemy;  
    
    while current_time_step < max_time_steps
        %Storing updates in player/enemy positions
         previous_pos_X_player = current_pos_X_player;
         previous_pos_Y_player = current_pos_Y_player;
         previous_pos_X_enemy = current_pos_X_enemy;
         previous_pos_Y_enemy = current_pos_Y_enemy; 
        
         %Same as training phase
         OUTPUTS = softmax(mtimesx(ReLU(mtimesx(ReLU(mtimesx(I,W1)) + B1, W2) + B2),W3) + B3);
         [I,L,R] = take_action(I, OUTPUTS, L, R, map_x, map_y, player_adv, enemy_distance_collision);
         
         %Storing scaled positions for creating visualization
         current_pos_X_player = [(I(1)*map_x) (I(1)*map_x)+1 (I(1)*map_x)+1 (I(1)*map_x)];
         current_pos_Y_player = [(I(2)*map_y)-1 (I(2)*map_y)-1 (I(2)*map_y) (I(2)*map_y)];
         current_pos_X_enemy = [(I(3)*map_x) (I(3)*map_x)+1 (I(3)*map_x)+1 (I(3)*map_x)];
         current_pos_Y_enemy = [(I(4)*map_y)-1 (I(4)*map_y)-1 (I(4)*map_y) (I(4)*map_y)];

         %Update player/enemy positions
         drawPiece(current_pos_X_player, current_pos_Y_player, previous_pos_X_player , previous_pos_Y_player , 'b',offsetDraw, "player");
         drawPiece(current_pos_X_enemy,current_pos_Y_enemy, previous_pos_X_enemy, previous_pos_Y_enemy, 'r',offsetDraw, "enemy");

         mov(:, current_time_step) = getframe;
         current_time_step = current_time_step+1;
    end
    movie(mov,1,30)
end





