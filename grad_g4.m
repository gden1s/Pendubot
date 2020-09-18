function g4dx = grad_g4(x, y, z, m2, m4, theta)
    if abs(x) > m2
        x = 0;
    end
    if abs(z) > m4
        z = 0;
    end

    g4dx = (((theta(3).^2.*cos(y).^2.*(2.*x.^2 + 2.*x.*z + z.^2) - theta(3).^2.*sin(y).^2.*(2.*x.^2 + 2.*x.*z + z.^2) + theta(7).*theta(3).*x.*sin(y) - 2.*theta(8).*theta(3).*z.*sin(y) + theta(1).*theta(3).*x.^2.*cos(y) + theta(2).*theta(3).*x.^2.*cos(y) + theta(2).*theta(3).*z.^2.*cos(y) + 2.*theta(2).*theta(3).*x.*z.*cos(y))./(theta(1).*theta(2) - theta(3).^2.*cos(y).^2) - (2.*theta(3).^2.*cos(y).*sin(y).*(theta(8).*z.*(theta(1) + theta(2) + 2.*theta(3).*cos(y)) - theta(7).*x.*(theta(2) + theta(3).*cos(y)) + theta(1).*theta(3).*x.^2.*sin(y) + theta(2).*theta(3).*x.^2.*sin(y) + theta(2).*theta(3).*z.^2.*sin(y) + theta(3).^2.*cos(y).*sin(y).*(2.*x.^2 + 2.*x.*z + z.^2) + 2.*theta(2).*theta(3).*x.*z.*sin(y)))./(theta(1).*theta(2) - theta(3).^2.*cos(y).^2).^2).^2 + (theta(8).*(theta(1) + theta(2) + 2.*theta(3).*cos(y)) + theta(3).^2.*cos(y).*sin(y).*(2.*x + 2.*z) + 2.*theta(2).*theta(3).*x.*sin(y) + 2.*theta(2).*theta(3).*z.*sin(y)).^2./(theta(1).*theta(2) - theta(3).^2.*cos(y).^2).^2 + (theta(3).^2.*cos(y).*sin(y).*(4.*x + 2.*z) - theta(7).*(theta(2) + theta(3).*cos(y)) + 2.*theta(1).*theta(3).*x.*sin(y) + 2.*theta(2).*theta(3).*x.*sin(y) + 2.*theta(2).*theta(3).*z.*sin(y)).^2./(theta(1).*theta(2) - theta(3).^2.*cos(y).^2).^2).^(1./2);
end