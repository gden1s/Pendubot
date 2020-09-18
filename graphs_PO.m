% Display Graphs for Pendubot and its observer

% graphs dimension
x_ = 640;
y_ = 320;

% Get system dynamics
T = pend_data.time; % timeseries
X = pend_data.signals.values * 180 / pi;
Z = observer1.signals.values * 180 / pi; 

% Set up figures
close all;

F1 = figure('NumberTitle', 'off', 'Name', 'Pendubot X1', 'Color', 'white', 'Position', [100 100 x_ y_]);
hold on; grid on; 
plot(T, Z(:, 1), 'LineWidth', 1.5, 'LineStyle', '--', 'DisplayName', 'Observer', 'Color', [0.850 0.325 0.098]);
plot(T, X(:, 1), 'LineWidth', 1.5, 'LineStyle', '-', 'DisplayName', 'Pendubot', 'Color', [0 0.447 0.741]);
xlabel('Time, sec'); 
ylabel('Angle q_1, deg');
legend;

E1 = figure('NumberTitle', 'off', 'Name', 'Error X1', 'Color', 'white', 'Position', [200 200 x_ y_]);
hold on; grid on; 
plot(T, X(:, 1) - Z(:, 1), 'LineWidth', 1.5, 'LineStyle', '-', 'DisplayName', 'Error', 'Color', [0 0 0]);
xlabel('Time, sec'); 
ylabel('Angle q_1 error, deg');
legend;

F2 = figure('NumberTitle', 'off', 'Name', 'Pendubot X3', 'Color', 'white', 'Position', [750 100 x_ y_]);
hold on; grid on; 
plot(T, Z(:, 3), 'LineWidth', 1.5, 'LineStyle', '--', 'DisplayName', 'Observer', 'Color', [0.850 0.325 0.098]);
plot(T, X(:, 3), 'LineWidth', 1.5, 'LineStyle', '-', 'DisplayName', 'Pendubot', 'Color', [0 0.447 0.741]);
xlabel('Time, sec'); 
ylabel('Angle q_2, deg');
legend

E2 = figure('NumberTitle', 'off', 'Name', 'Error X3', 'Color', 'white', 'Position', [200 200 x_ y_]);
hold on; grid on; 
plot(T, X(:, 3) - Z(:, 3), 'LineWidth', 1.5, 'LineStyle', '-', 'DisplayName', 'Error', 'Color', [0 0 0]);
xlabel('Time, sec'); 
ylabel('Angle q_2 error, deg');
legend;

F3 = figure('NumberTitle', 'off', 'Name', 'Pendubot X2', 'Color', 'white', 'Position', [150 150 x_ y_]);
hold on; grid on; 
plot(T, Z(:, 2), 'LineWidth', 1.5, 'LineStyle', '--', 'DisplayName', 'Observer', 'Color', [0.850 0.325 0.098]);
plot(T, X(:, 2), 'LineWidth', 1.5, 'LineStyle', '-', 'DisplayName', 'Pendubot', 'Color', [0 0.447 0.741]);
xlabel('Time, sec'); 
ylabel('Angular velocity q_1, deg');
legend;

F4 = figure('NumberTitle', 'off', 'Name', 'Pendubot X4', 'Color', 'white', 'Position', [800 150 x_ y_]);
hold on; grid on; 
plot(T, Z(:, 4), 'LineWidth', 1.5, 'LineStyle', '--', 'DisplayName', 'Observer', 'Color', [0.850 0.325 0.098]);
plot(T, X(:, 4), 'LineWidth', 1.5, 'LineStyle', '-', 'DisplayName', 'Pendubot', 'Color', [0 0.447 0.741]);
xlabel('Time, sec'); 
ylabel('Angular velocity q_2, deg');
legend;