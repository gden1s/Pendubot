%%% PENDUBOT ANIMATION %%%
function animation = pendubot_animation(pend_out)

% Pendubot parameters
l1 = 1; % first link length
l2 = 1; % second link length
r1 = l1 * 0.12; r2 = l2 * 0.1; % joints radii
w1 = l1 * 1/20; w2 = l2 * 1/20; % 1/2 widths of links
joint_coef = 0.6; % ratio of top and bottom joints 

% Window size
% wsize = [-1.25 * (l1 + l2), 1.25 * (l1 + l2), ...
%        -1.25 * (l1 + l2), 1.25 * (l1 + l2)];
wsize = [-0.6 * (l1 + l2), 0.6 * (l1 + l2), ...
       -0.1 * (l1 + l2), 1.1 * (l1 + l2)];

% Get system dynamics
T = pend_out.time; % timeseries
X = [pend_out.signals.values(:,1) - pi/2, ...   <----   for system -1
     pend_out.signals.values(:,3)]; % angles

%%% Set up first frame ------------------------------------------------ %%%
animation = figure('Position', [100, 100, 640, 640], 'NumberTitle', ...
            'off', 'Name', 'Pendubot animation', 'Color', 'white');
hold on;
grid on;
axis equal;
axis(wsize);
  
ht = title(sprintf('Time: %0.2f sec', T(1)));

tp = 0:pi/10:2*pi;
% Draw the bottom joint 1
x_c1_1 = r1 * cos(tp); y_c1_1 = r1 * sin(tp);
h_c1_1 = fill(x_c1_1 , y_c1_1, [0.5, 1, 0.5]);

% Draw the bottom joint 2
x_c2_1 = r2 * cos(tp);
y_c2_1 = r2 * sin(tp);
h_c2_1 = fill(x_c2_1 + cos(X(1, 1)) * l1,  ...
              y_c2_1 + sin(X(1, 1)) * l1, [0.9, 0.9, 0.9]);

% Draw the first link ------------------------------------------------------- %
k1 = sqrt(r1^2 - w1^2);
k2 = sqrt(r2^2 - w1^2);

A0 = [0, 0];
A1 = [w1 * sin(-X(1, 1)) + k1 * cos(X(1, 1)), ...
      w1 * cos(-X(1, 1)) + k1 * sin(X(1, 1))];
A2 = [w1 * sin(-X(1, 1)) + (l1 - k2) * cos(X(1, 1)), ...
      w1 * cos(-X(1, 1)) + (l1 - k2) * sin(X(1, 1))];
A3 = [l1 * cos(X(1, 1)), ...
      l1 * sin(X(1, 1))];
A4 = [-w1 * sin(-X(1, 1)) + (l1 - k2) * cos(X(1, 1)), ...
      -w1 * cos(-X(1, 1)) + (l1 - k2) * sin(X(1, 1))];
A5 = [-w1 * sin(-X(1, 1)) + k1 * cos(X(1, 1)), ...
      -w1 * cos(-X(1, 1)) + k1 * sin(X(1, 1))];
A = [A0; A1; A2; A3; A4; A5; A0];

h_l1 = fill(A(:, 1), A(:, 2), 'r');

% Draw the top joint 1
x_c1_2 = joint_coef * r1 * cos(tp);
y_c1_2 = joint_coef * r1 * sin(tp);
h_c1_2 = fill(x_c1_2, y_c1_2, [0, 0, 0]);

% Draw the second link -------------------------------------------------- %
k3 = sqrt(r2^2 - w2^2);

B0 = A3;
B1 = A3 + [w2 * sin(-X(1, 1) - X(1, 2)) + k3 * cos(X(1, 1) + X(1, 2)), ...
           w2 * cos(-X(1, 1) - X(1, 2)) + k3 * sin(X(1, 1) + X(1, 2))];
B2 = A3 + [w2 * sin(-X(1, 1) - X(1, 2)) + (l2 - k3) * cos(X(1, 1) + X(1, 2)), ...
           w2 * cos(-X(1, 1) - X(1, 2)) + (l2 - k3) * sin(X(1, 1) + X(1, 2))];
B3 = A3 + [l2 * cos(X(1, 1) + X(1, 2)), l2 * sin(X(1, 1) + X(1, 2))];       
B4 = A3 + [-w2 * sin(-X(1, 1) - X(1, 2)) + (l2 - k3) * cos(X(1, 1) + X(1, 2)), ...
           -w2 * cos(-X(1, 1) - X(1, 2)) + (l2 - k3) * sin(X(1, 1) + X(1, 2))];     
B5 = A3 + [-w2 * sin(-X(1, 1) - X(1, 2)) + k3 * cos(X(1, 1) + X(1, 2)), ...
           -w2 * cos(-X(1, 1) - X(1, 2)) + k3 * sin(X(1, 1) + X(1, 2))];
B = [B0; B1; B2; B3; B4; B5; B0];

h_l2 = fill(B(:, 1), B(:, 2), 'b');

% Draw the top joint 2
x_c2_2 = joint_coef * r2 * cos(tp);
y_c2_2 = joint_coef * r2 * sin(tp);
h_c2_2 = fill(x_c2_2 + cos(X(1, 1)) * l1, y_c2_2 + sin(X(1, 1)) * l1, [0, 0, 0]);

% Get figure size
pos = get(gcf, 'Position');
width = pos(3);
height = pos(4);

% Preallocate data (for storing frame data)
mov = zeros(1.25 * height, 1.25 * width, 1, length(T), 'uint8');

%%% Upgrade graphics data --------------------------------------------- %%%

% Loop through by changing XData and YData
for i = 1:length(T)
    % Change time
    set(ht, 'String', sprintf('Time: %0.2f sec', T(i)));
    
    % Redraw the bottom joint 2
    set(h_c2_1, 'XData', x_c2_1 + cos(X(i, 1)) * l1, ...
                'YData', y_c2_1 + sin(X(i, 1)) * l1);
    
    % Redraw the first link
    A1 = [w1 * sin(-X(i, 1)) + k1 * cos(X(i, 1)), ...
          w1 * cos(-X(i, 1)) + k1 * sin(X(i, 1))];
    A2 = [w1 * sin(-X(i, 1)) + (l1 - k2) * cos(X(i, 1)), ...
          w1 * cos(-X(i, 1)) + (l1 - k2) * sin(X(i, 1))];
    A3 = [l1 * cos(X(i, 1)), ...
          l1 * sin(X(i, 1))];
    A4 = [-w1 * sin(-X(i, 1)) + (l1 - k2) * cos(X(i, 1)), ...
          -w1 * cos(-X(i, 1)) + (l1 - k2) * sin(X(i, 1))];
    A5 = [-w1 * sin(-X(i, 1)) + k1 * cos(X(i, 1)), ...
          -w1 * cos(-X(i, 1)) + k1 * sin(X(i, 1))];
    A = [A0; A1; A2; A3; A4; A5; A0];
    % Change the data of the first link
    set(h_l1, 'XData', A(:, 1), ...
              'YData', A(:, 2));
    
    % Redraw the top joint 1
    set(h_c1_2, 'XData', x_c1_2, ...
                'YData', y_c1_2);
    
    % Redraw the second link
    B0 = A3;
    B1 = A3 + [w2 * sin(-X(i, 1) - X(i, 2)) + k3 * cos(X(i, 1) + X(i, 2)), ...
               w2 * cos(-X(i, 1) - X(i, 2)) + k3 * sin(X(i, 1) + X(i, 2))];
    B2 = A3 + [w2 * sin(-X(i, 1) - X(i, 2)) + (l2 - k3) * cos(X(i, 1) + X(i, 2)), ...
               w2 * cos(-X(i, 1) - X(i, 2)) + (l2 - k3) * sin(X(i, 1) + X(i, 2))];
    B3 = A3 + [l2 * cos(X(i, 1) + X(i, 2)), l2 * sin(X(i, 1) + X(i, 2))];       
    B4 = A3 + [ - w2 * sin(-X(i, 1) - X(i, 2)) + (l2 - k3) * cos(X(i, 1) + X(i, 2)), ...
                - w2 * cos(-X(i, 1) - X(i, 2)) + (l2 - k3) * sin(X(i, 1) + X(i, 2))];     
    B5 = A3 + [ - w2 * sin(-X(i, 1) - X(i, 2)) + k3 * cos(X(i, 1) + X(i, 2)), ...
                - w2 * cos(-X(i, 1) - X(i, 2)) + k3 * sin(X(i, 1) + X(i, 2))];
    % Change the data of the second link
    B = [B0; B1; B2; B3; B4; B5; B0];
    set(h_l2, 'XData', B(:, 1), ...
              'YData', B(:, 2));
    
    % Redraw the top joint 2
    set(h_c2_2, 'XData', x_c2_2 + cos(X(i, 1)) * l1, ...
                'YData', y_c2_2 + sin(X(i, 1)) * l1);

    % Get frame as an image
    f = getframe(gcf);
    
    % Create a colormap for the first frame. For the rest of the frames,
    % use the same colormap
    if i == 1
        [mov(:, :, 1, i), map] = rgb2ind(f.cdata, 256, 'nodither');
    else
        mov(:, :, 1, i) = rgb2ind(f.cdata, map, 'nodither');
    end
end

% Create animated GIF
imwrite(mov, map, 'pendubot_animation.gif', 'DelayTime', 0, 'LoopCount', inf);