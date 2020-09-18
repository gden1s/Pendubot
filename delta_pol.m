function pol = delta_pol(gamma, alpha, beta)
    if nargin == 1
        alpha = 1;
        beta = pi/2;
    elseif nargin == 2
        beta = pi/2;
    end
    % размерность пространства
    len = length(gamma);
    % формирование коэффициентов 
    a1 = @(a,b,g)(2*a + g(1)^2 + 2*abs(g(2))*cos(b));
    a2 = @(a,b,g)(a^2 + (g(1)^2)*a + 2*abs(g(2))*cos(b) + g(2)^2);
    % начальный полином и кол-во его коэффициентов
    pol = [1 a1(alpha,beta,gamma(1:2)) a2(alpha,beta,gamma(1:2))];
    k = 3;
    % процесс построения полинома
    d = fix(len*0.5);
    if d > 1
        for i = 2:d
            k = k + 2;
            % определение вспомогательных полиномов
            pol1 = zeros(1,k);
            pol2 = zeros(1,k);
            pol3 = zeros(1,k);
            pol1(1:k-2) = pol;
            pol2(2:k-1) = pol*a1(alpha,beta,gamma(k-2:k-1));
            pol3(3:k) = pol*a2(alpha,beta,gamma(k-2:k-1));
            % требуемый полином
            pol = pol1 + pol2 + pol3;
        end
    end
    if 2*d < len
        k = k + 1;
        pol1 = zeros(1,k);
        pol2 = zeros(1,k);
        a0 = gamma(len)^2 + alpha;
        pol1(1:k-1) = pol;
        pol2(2:k) = pol*a0;
        % требуемый полином 
        pol = pol1 + pol2;
    end
end