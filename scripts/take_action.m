function [update, L, R] = take_action(inputs, outputs, L_, R_, map_x, map_y, player_adv,enemy_dist_coll)
    update = inputs;
    R = R_;
    L = L_;
    
    for i=find(L)
       %AGENT ACTION
       [M,idx] = max(outputs(:,:,i));
       
       if idx == 1
           update(1,1,i) = inputs(1,1,i) + (player_adv / (map_x));
           %update(1,5,i) = inputs(1,5,i) - (player_adv / (map_x*2));
           %update(1,6,i) = inputs(1,6,i) + (player_adv / (map_x*2));
       elseif idx == 2
           update(1,1,i) = inputs(1,1,i) - (player_adv / (map_x));
           %update(1,5,i) = inputs(1,5,i) + (player_adv / (map_x*2));
           %update(1,6,i) = inputs(1,6,i) - (player_adv / (map_x*2));
       elseif idx == 3
           update(1,2,i) = inputs(1,2,i) + (player_adv / (map_y));
           %update(1,7,i) = inputs(1,7,i) - (player_adv / (map_y*2));
           %update(1,8,i) = inputs(1,8,i) + (player_adv / (map_y*2));
       elseif idx == 4
           update(1,2,i) = inputs(1,2,i) - (player_adv / (map_y));
           %update(1,7,i) = inputs(1,7,i) + (player_adv / (map_y*2));
           %update(1,8,i) = inputs(1,8,i) - (player_adv / (map_y*2));
       end
       
       %ENEMY ACTION
       enemy_direction_Y_pre = update(1,2,i) - update(1,4,i);
       enemy_direction_X_pre = update(1,1,i)-update(1,3,i);
       
       tan = atand(abs(enemy_direction_Y_pre)/abs(enemy_direction_X_pre));
       
       enemy_direction_Y = sind(tan) / (map_x);
       enemy_direction_X = cosd(tan) / (map_y);
       
       if enemy_direction_X_pre < 0
           enemy_direction_X = -enemy_direction_X;
       end
       
       if enemy_direction_Y_pre < 0
           enemy_direction_Y = -enemy_direction_Y;
       end
       
       update(1,3,i) = update(1,3,i) + enemy_direction_X;
       update(1,4,i) = update(1,4,i) + enemy_direction_Y;
       
       
       %Crash into wall check
       if abs(update(1,1,i)) >= 1 ||  abs(update(1,2,i)) >= 1 
          L(i) = 0;    
          
       %Catched by enemy check   
       elseif  abs(update(1,1,i)-update(1,3,i)) <= enemy_dist_coll && abs(update(1,2,i)-update(1,4,i)) <= enemy_dist_coll
          L(i) = 0;
       else
          R(i) = R(i) + 1;
          
       end
    end
     
end