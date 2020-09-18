function tau = pendubot_control(x1, x2, x3, x4, time, theta)

Kd = 1;
Kp = 1;
Ke = 5;

x_1 = x1 - pi;

FF = theta(2)*theta(3)*sin(x3)*(x2 + x4)^2 + ...
        (theta(3)^2)*sin(x3)*cos(x3)*(x2)^2 - theta(6)*theta(2)*theta(4)*cos(x1) + ...
        theta(6)*theta(3)*theta(5)*cos(x3)*cos(x1 + x3);
    
D = [theta(1) + theta(2) + 2*theta(3)*cos(x3), theta(2) + theta(3)*cos(x3); ...
     theta(2) + theta(3)*cos(x3), theta(2)];

% E = 0.5*theta(2)*x4^2 + theta(4)*theta(6)*sin(x1) + theta(5)*theta(6)*sin(x1 + x3);
E = 0.5*[x2, x4]*D*[x2; x4] + theta(4)*theta(6)*sin(x1) + theta(5)*theta(6)*sin(x1 + x3);
E_ = E - (theta(4) + theta(5))*theta(6);
det_D = theta(1)*theta(2) - (theta(3)*cos(x3))^2;

tau = -(Kd*FF + det_D*(x2 + Kp*x_1))/(det_D*Ke*E_ + Kd*theta(2));