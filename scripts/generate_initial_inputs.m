function I = generate_initial_inputs(map_x, map_y, init_player_x, init_player_y,init_enemy_x, init_enemy_y, generation_size)
    %I = [init_player_x/(map_x) init_player_y/(map_y) init_enemy_x/(map_x) init_enemy_y/(map_y) abs(map_x-init_player_x)/(map_x*2) abs(-map_x-init_player_x)/(map_x*2) abs(map_y-init_player_y)/(map_y*2) abs(-map_y-init_player_y)/(map_y*2)];
    I = [init_player_x/(map_x) init_player_y/(map_y) init_enemy_x/(map_x) init_enemy_y/(map_y)];
    I = repmat(I, 1, 1, generation_size);
end