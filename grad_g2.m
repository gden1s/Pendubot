function g2dx = grad_g2(x, y, z, m2, m4, theta)
    if abs(x) > m2
        x = 0;
    end
    if abs(z) > m4
        z = 0;
    end
 
    g2dx = ((theta(8).*(theta(2) + theta(3).*cos(y)) + 2.*theta(2).*theta(3).*x.*sin(y) + 2.*theta(2).*theta(3).*z.*sin(y)).^2./(theta(1).*theta(2) - theta(3).^2.*cos(y).^2).^2 + (2.*theta(3).^2.*x.*cos(y).*sin(y) - theta(7).*theta(2) + 2.*theta(2).*theta(3).*x.*sin(y) + 2.*theta(2).*theta(3).*z.*sin(y)).^2./(theta(1).*theta(2) - theta(3).^2.*cos(y).^2).^2 + ((theta(3).*(theta(2).*x.^2.*cos(y) - theta(8).*z.*sin(y) + theta(2).*z.^2.*cos(y) + theta(3).*x.^2.*(2.*cos(y).^2 - 1) + 2.*theta(2).*x.*z.*cos(y)))./(theta(1).*theta(2) - theta(3).^2.*cos(y).^2) - (2.*theta(3).^2.*cos(y).*sin(y).*(cos(y).*sin(y).*theta(3).^2.*x.^2 + theta(2).*sin(y).*theta(3).*x.^2 + 2.*theta(2).*sin(y).*theta(3).*x.*z + theta(2).*sin(y).*theta(3).*z.^2 + theta(8).*cos(y).*theta(3).*z - theta(7).*theta(2).*x + theta(8).*theta(2).*z))./(theta(1).*theta(2) - theta(3).^2.*cos(y).^2).^2).^2).^(1./2);
end