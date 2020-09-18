function [L1, L2, L_brute] = lipschitzconst(theta, h2, h4)

grad2 = @(x, y, z)gg2(x, y, z, h2, h4, theta);
grad4 = @(x, y, z)gg4(x, y, z, h2, h4, theta);
[X0, L_2] = fminsearch(@(X)-grad2(X(1), X(2), X(3)), [h2 0 h4]);
[X0, L_4] = fminsearch(@(X)-grad4(X(1), X(2), X(3)), [h2 0 h4]);
L1 = sqrt(L_2^2 + L_4^2);

[X0, L2] = fminsearch(@(X)-sqrt(grad2(X(1), X(2), X(3))^2 + grad4(X(1), X(2), X(3))^2), [h2 0 h4]);
L2 = -L2;

L_brute = 0;
for x = 0:0.1:2*pi
    L_3_ = sqrt(grad2(h2, x, h4)^2 + grad4(h2, x, h4)^2);
    if L_3_ > L_brute
        L_brute = L_3_;
    end
end
end