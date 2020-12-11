function [player_x_curr, player_y_curr, enemy_x_curr, enemy_y_curr] = view_scaled_positions(I, map_x, map_y)
         player_x_curr = [(I(1)*map_x) (I(1)*map_x)+1 (I(1)*map_x)+1 (I(1)*map_x)];
         player_y_curr = [(I(2)*map_y)-1 (I(2)*map_y)-1 (I(2)*map_y) (I(2)*map_y)];
         enemy_x_curr = [(I(3)*map_x) (I(3)*map_x)+1 (I(3)*map_x)+1 (I(3)*map_x)];
         enemy_y_curr = [(I(4)*map_y)-1 (I(4)*map_y)-1 (I(4)*map_y) (I(4)*map_y)];
end