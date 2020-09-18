function grad = gg2(x, y, z, h2, h4, theta)
    if abs(x) > h2
        x = 0;
    end
    if abs(z) > h4
        z = 0;
    end
%     for i = 1 : length(x)
%         if abs(x(i)) > h2
%             x(i) = 0;
%         end
%     end
%     for i = 1 : length(z)
%         if abs(z(i)) > h4
%             z(i) = 0;
%         end
%     end

    grad = ((theta(3).^4 .* x.^2 .* cos(y).^2 + theta(8) .* theta(3).^3 .* z .* (sin(y) - sin(y).^3) + 2 .* theta(2) .* theta(3).^3 .* x.^2 .* cos(y) + 2 .* theta(2) .* theta(3).^3 .* z.^2 .* cos(y) - theta(2) .* theta(3).^3 .* x.^2 .* cos(y).^3 - theta(2) .* theta(3).^3 .* z.^2 .* cos(y).^3 + theta(1) .* theta(2) .* theta(3).^2 .* x.^2 - 2 .* theta(1) .* theta(2) .* theta(3).^2 .* x.^2 .* cos(y).^2 + 4 .* theta(2) .* theta(3).^3 .* x .* z .* cos(y) - theta(7) .* theta(2) .* theta(3).^2 .* x .* sin(2 .* y) + theta(8) .* theta(2) .* theta(3).^2 .* z .* sin(2 .* y) - theta(1) .* theta(2).^2 .* theta(3) .* x.^2 .* cos(y) - theta(1) .* theta(2).^2 .* theta(3) .* z.^2 .* cos(y) - 2 .* theta(2) .* theta(3).^3 .* x .* z .* cos(y).^3 + theta(8) .* theta(1) .* theta(2) .* theta(3) .* z .* sin(y) - 2 .* theta(1) .* theta(2).^2 .* theta(3) .* x .* z .* cos(y)).^2 ./ (theta(1) .* theta(2) - theta(3).^2 .* cos(y).^2).^4 + (theta(3).^2 .* (theta(8) .* theta(3).^2 .* cos(y) + theta(8) .* theta(1) .* theta(2) + theta(8) .* theta(2) .* theta(3) - theta(8) .* theta(3).^2 .* cos(y).^2 - 2 .* theta(1) .* theta(2).^2 .* x .* sin(y) + 2 .* theta(2) .* theta(3).^2 .* x .* sin(y) - 2 .* theta(1) .* theta(2).^2 .* z .* sin(y) + 2 .* theta(2) .* theta(3).^2 .* z .* sin(y) - theta(8) .* theta(1) .* theta(2) .* cos(y) - theta(8) .* theta(2) .* theta(3) .* cos(y).^2).^2) ./ ((theta(1) .* theta(2) - theta(3).^2 .* cos(y).^2).^2 .* (theta(1) .* theta(2) - theta(3).^2).^2) + (theta(3).^2 .* ((theta(7) .* theta(2) .* theta(3)) ./ 2 - theta(3).^3 .* x .* sin(2 .* y) + 2 .* theta(1) .* theta(2).^2 .* x .* sin(y) - 2 .* theta(2) .* theta(3).^2 .* x .* sin(y) + 2 .* theta(1) .* theta(2).^2 .* z .* sin(y) - 2 .* theta(2) .* theta(3).^2 .* z .* sin(y) - (theta(7) .* theta(2) .* theta(3) .* cos(2 .* y)) ./ 2 + theta(1) .* theta(2) .* theta(3) .* x .* sin(2 .* y)).^2) ./ ((theta(1) .* theta(2) - theta(3).^2 .* cos(y).^2).^2 .* (theta(1) .* theta(2) - theta(3).^2).^2)).^(1 ./ 2);
end