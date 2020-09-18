% ��������� ��������� ���������
% clear variables

% ����� ���������
sim_time = 10;
% ��������� �������
X0 = [pi/4; 0; 0; 0]; % x2 = 0.56094
Z0 = [pi/2; 0; 0; 0];

% ��������������� ���������� ���������
% theta = [0.0761,      0.0662,      0.0316,      0.9790,   0.3830,   9.81, 0,    0];
% theta = [0.015124521, 0.005097714, 0.006191948, 0.074911, 0.030058, 9.81, 0.08, 0.00001];
% theta = [0.0242598,0.0057766848,0.006213312,0.102338,0.0295872,9.81,0,0];
% theta = [0.034 0.0125 0.01 0.215 0.073 9.81 0 0];
% theta = [1.356,0.019,0.042,1.28,0.06,9.81,0.001,0.00001];

% ��� �������
theta = [0.014680882,0.00223765,0.00146916,0.060038,0.00693,9.81,0.0001,0.0001];

disp('��������� �������������:');
disp(theta);
% ��������� ������� ��� g(t,x,u)
h2 = pi/15; h4 = pi/15;
[L1, L2, L_brute] = lipschitzconst(theta, h2, h4);
disp(['�� �������� ����� ��������� ������� g(t,x,u) fminsearch 1-�� ��������: ', num2str(L1)]);
disp(['�� �������� ����� ��������� ������� g(t,x,u) fminsearch 2-�� ��������: ', num2str(L2)]);
disp(['�� �������� ����� ��������� ������� g(t,x,u) ��������� �� x3 ��� ������� ��������� x2 � x4: ', num2str(L_brute)]);
disp(' ');

% ������� ������� 
A = matrix_A(theta);
B = matrix_B(theta);
C = [1 0 0 0; ...
     0 0 1 0];
% ������ ������ ������������
alpha = 1; beta = pi/2; norm_y = 40; n_L = 1;
% y_fminsearchstart = [10 10 10 10; 1 1 1 1; 1 1 1 1];
[l0, L] = finding_l0(A, C, alpha, beta, norm_y, max([L1 L2 L_brute]), n_L);
% % % ������� L ���������������� �����������
% % L = [30 0; 30 0; 0 30; 0 30];
% % % ������� ������������� ���������� ��� ---------------------- UP-UP ----- %
% % K_up = [34.88, 6.41, 34.81, 4.53] * 2;
% % ��� ������� ������ LQR-�������
% % % ������� �������, ��������������� � ������� ���������
% % mu = 1/(theta(1)*theta(2) - theta(3)^2);
% % A_up = [0, 1, 0, 0;...
% %      (theta(2)*theta(4)-theta(3)*theta(5))*theta(6)*mu, 0, -theta(3)*theta(5)*theta(6)*mu, 0;...
% %      0, 0, 0, 1;...
% %      theta(6)*mu*(theta(5)*(theta(1) + theta(3)) - theta(4)*(theta(2) + theta(3))), 0, theta(6)*theta(5)*mu*(theta(1) + theta(3)), 0];
% % B_up = mu*[0; theta(2); 0; (- theta(2) - theta(3))];
% % Q_mid = diag([10 65 5 5]); R_up = 50; K_up = -lqr(A_up, B_up, Q_up, R_up);
% 
% % ������� ������������� ���������� ��� -------------------- DOWN-UP ----- %
% K_mid = - [-0.2897, -0.1212, -3.6969, -0.4429];
% % ��� ������� ������ LQR-�������
% % ������� �������, ��������������� � ������� ���������
% mu = 1/(theta(1)*theta(2) - theta(3)^2);
% A_mid = [0, 1, 0, 0;...
%          -(theta(6)*(theta(2)*theta(4) - theta(3)*theta(5)))/(- theta(3)^2 + theta(1)*theta(2)), -(theta(7)*theta(2))/(- theta(3)^2 + theta(1)*theta(2)), (theta(6)*theta(3)*theta(5))/(- theta(3)^2 + theta(1)*theta(2)), (theta(8)*(theta(2) - theta(3)))/(- theta(3)^2 + theta(1)*theta(2));...
%          0, 0, 0, 1;...
%           (theta(6)*(theta(1)*theta(5) + theta(2)*theta(4) - theta(3)*theta(4) - theta(3)*theta(5)))/(- theta(3)^2 + theta(1)*theta(2)), (theta(7)*(theta(2) - theta(3)))/(- theta(3)^2 + theta(1)*theta(2)), (theta(6)*theta(5)*(theta(1) - theta(3)))/(- theta(3)^2 + theta(1)*theta(2)), -(theta(8)*(theta(1) + theta(2) - 2*theta(3)))/(- theta(3)^2 + theta(1)*theta(2))];
% B_mid = mu*[0; theta(2); 0; (- theta(2) - theta(3))];
% % Q_mid = diag([10 65 5 5]); R_mid = 50; K_mid = -lqr(A_mid, B_mid, Q_mid, R_mid);
% 
% % % ������� ������������� ���������� ��� ------------------ DOWN-DOWN ----- %
% % K_down = [34.88, 6.41, 34.81, 4.53];
% % % ��� ������� ������ LQR-�������
% % % Q = diag([10 65 5 5]); R = 50; K_up = -lqr(A, B, Q, R);
% 
% % % % ����� ���������
% % sim('pb_model')
% % % anim = kawaii(pend_out);
% % anim = pendubot_animation(pend_out);
% disp(L0)