function [p_x_pre, p_y_pre, e_x_pre, e_y_pre,  p_x_curr, p_y_curr, e_x_curr, e_y_curr] = set_up_position_track(init_player_x, init_player_y, init_enemy_x, init_enemy_y)
    p_x_pre = [init_player_x (init_player_x)+1 (init_player_x)+1 init_player_x];
    p_y_pre = [(init_player_y)-1 (init_player_y)-1 init_player_y init_player_y];
    e_x_pre = [init_enemy_x (init_enemy_x)+1 (init_enemy_x)+1 init_enemy_x];
    e_y_pre = [(init_enemy_y)-1 (init_enemy_y)-1 init_enemy_y init_enemy_y];
    p_x_curr = p_x_pre;
    p_y_curr = p_y_pre;  
    e_x_curr = e_x_pre;
    e_y_curr = e_y_pre;  
end