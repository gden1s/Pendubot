%%% пример использование lipschitz_const_chech %%%
% 
% % 2 и 4 компоненты локально-липшицевой вектор-функции g(t,x,u)
% dx2 = @(x,y,z)(1/(theta(1)*theta(2)-((theta(3))^2)*((cos(y))^2)))*(theta(2)*theta(3)*sin(y)*(x)^2 + ...
%              2*theta(2)*theta(3)*sin(y)*x*z + theta(2)*theta(3)*sin(y)*(z)^2 + ...
%              ((theta(3))^2)*sin(y)*cos(y)*(x)^2 - ...
%              theta(2)*theta(7)*x + (theta(2) + theta(3)*cos(y))*theta(8)*z);
%          
% dx4 = @(x,y,z)(1/(theta(1)*theta(2)-((theta(3))^2)*((cos(y))^2)))*(- ...
%              theta(1)*theta(3)*sin(y)*(x)^2 - theta(2)*theta(3)*sin(y)*(x)^2 - ...
%              theta(2)*theta(3)*sin(y)*(z)^2 - 2*theta(2)*theta(3)*sin(y)*x*z - ... 
%              (theta(3))^2*sin(y)*cos(y)*(2*(x)^2 + 2*x*z + (z)^2) + ...
%              (theta(2) + theta(3)*cos(y))*theta(7)*x - ...
%              (theta(1) + theta(2) + 2*theta(3)*cos(y))*theta(8)*z);
%        
% func_g = @(x,y,z)[0; dx2(x,y,z); 0; dx4(x,y,z)];
% % проверка константы Липшица
% res = lipschitz_const_check(func_g, 600, [-3*pi, 3*pi, -pi, pi, -3*pi, 3*pi], 10);
%
%%% ------------------------------------------ %%%

function [res, X0] = lipschitz_const_check(func,L,G,n)
    count = 0;
    L_max = 0;
    X0 = zeros(2,3);
%     for i = G(1):h:G(2)-h
%         for j = G(3):h:G(4)-h
%             for k = G(5):h:G(6)-h
%                 L_ = norm(func(i+h,j+h,k+h) - func(i,j,k))/(sqrt(3)*h);
%                 if L_ > L_max
%                     L_max = L_;
%                 end
%                 if L_ > L
%                     count = count + 1;
%                     X0(count,:) = [i,j,k];
%                 end
%             end
%         end
%     end
%     res = [L_max, count];
%     disp(['Численное значение константы Липшица: ', num2str(L_max)]);
%     disp(['Указанное значение константы Липшица: ', num2str(L)]);
%     disp(['Количество несоответствий для указанной константы Липшица: ', num2str(count)]);
    % res=0 - константа липшица верна
    % res=[1,k] - неверна, количество несоответствий
    % res=2 - неправильно задана область
    format longG
    dim = length(G);
    % проверка работает лишь для функций не более чем от 4 аргументов (лучше от 2х)
    if rem(dim,2) > 0 % функция rem вычисляет остаток от деления 
        res = 2;
    else
        cycles = dim/2;
        k = 0;
        switch cycles
            case 1
                % найдем шаг разбиения промежуткa
                h = (G(2)-G(1))/n;
                for x = G(1):h:G(2)
                    for y = G(1):h:G(2)
                        if norm(func(x)-func(y)) > L*abs(x-y)
                            k = k + 1;
                        end
                    end
                end

            case 2
                % найдем шаги разбиения промежутков
                h1 = (G(2)-G(1))/n;
                h2 = (G(4)-G(3))/n;
                for x1 = G(1):h1:G(2)
                    for x2 = G(3):h2:G(4)
                        for y1 = G(1):h1:G(2)
                            for y2 = G(3):h2:G(4)
                                if norm(func(x1,x2)-func(y1,y2)) > ...
                                        L*norm([x1,x2]-[y1,y2])
                                    k = k + 1;
                                end
                            end
                        end
                    end
                end
            % до такого лучше не доводить!!!
            case 3
                % найдем шаги разбиения промежутков
                h1 = (G(2)-G(1))/n;
                h2 = (G(4)-G(3))/n;
                h3 = (G(6)-G(5))/n;
                for x1 = G(1):h1:G(2)
                    for x2 = G(3):h2:G(4)
                        for x3 = G(5):h3:G(6)
                            for y1 = G(1):h1:G(2)
                                for y2 = G(3):h2:G(4)
                                    for y3 = G(5):h3:G(6)
                                        if (x1 ~= y1) && (x2 ~= y2) && (x3 ~= y3)
                                            L_ = norm(func(x1,x2,x3) - func(y1,y2,y3))/norm([x1,x2,x3]-[y1,y2,y3]);
                                            if L_ > L_max
                                                L_max = L_;
                                            end
                                            if L_ > L
                                                k = k + 1;
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            % остановись!!!
            case 4
                % найдем шаги разбиения промежутков
                h1 = (G(2)-G(1))/n;
                h2 = (G(4)-G(3))/n;
                h3 = (G(6)-G(5))/n;
                h4 = (G(8)-G(7))/n;
                for x1 = G(1):h1:G(2)
                    for x2 = G(3):h2:G(4)
                        for x3 = G(5):h3:G(6)
                            for x4 = G(7):h4:G(8)
                                for y1 = G(1):h1:G(2)
                                    for y2 = G(3):h2:G(4)
                                        for y3 = G(5):h3:G(6)
                                            for y4 = G(7):h4:G(8)
                                                if norm(func(x1,x2,x3,x4)-func(y1,y2,y3,y4)) > ...
                                                        L*norm([x1,x2,x3,x4]-[y1,y2,y3,y4])
                                                    k = k + 1;
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end 
        end
        if k > 0
            res = [1,k];
        else
            res = 0;
        end
    end
    disp(['Численное значение константы Липшица: ', num2str(L_max)]);
    disp(['Указанное значение константы Липшица: ', num2str(L)]);
    disp(['Количество несоответствий для указанной константы Липшица: ', num2str(k)]);
end