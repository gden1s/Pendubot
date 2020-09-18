%%% нахождение L, обеспечивающей АУ нулевого решения ур-я ошибки наблюдения
function [l0, L] = finding_l0(A, C, alpha, beta, norm_y, const_L, n_L, y_fminsearchstart)
% norm_y - ограничение нормы матрицы L (чтобы не были слишком большие компоненты)
% const_L - текущая константа Липшица для системы (для вывода информации)
% n_L - номер того значения alpha, которое используется в дальнейшем
% y_fminsearchstart как стартовая точка для fminsearch

if nargin == 7
    y_fminsearchstart = 20*rand(1, length(A(1,:))); % важный момент
end
if (length(norm_y) == 1) && (length(alpha) > 1)
    for i = 2:length(alpha)
    norm_y(1,i) = inf;
    end
end
if (length(y_fminsearchstart(:,1)) == 1) && (length(alpha) > 1)
    for i = 2:length(alpha)
    y_fminsearchstart(i,:) = y_fminsearchstart(1,:);
    end
end
for i = 1:length(alpha)
    alpha_ = alpha(i);
    norm_y_ = norm_y(i);
    % минимизируемая функция
    func = @(y)pole_del(A, C, y, alpha_, beta, norm_y_);
    % минимизируем методом Нелдера-Мида
    y0 = zeros(1, length(A(1,:))); % начальная точка
    y_opt = fminsearch(@(y)(-func(y)), y_fminsearchstart(i,:));
    % оптимальные l0 и L
    [l0_, L_] = pole_del(A, C, y_opt, alpha_, beta, norm_y_);
    if n_L == i
        L = L_;
        l0 = l0_;
    end
    disp([num2str(i),'. Степень устойчивости alpha = ', num2str(alpha_), ', beta = ', num2str(beta), ';']);
    disp(' ');
    disp(['   Константа Липшица для данной системы:   ', num2str(const_L), ';']);
%     disp(' ');
%     disp(['   Значение lyambda0 до начала оптимизационного процесса (y = [', num2str(y0), ']):   ',... 
%         num2str(pole_del(A, C, y0, alpha_, beta, norm_y_)),';',]);
%     disp(' ');
    disp(['   Значение lyambda0 найденное методом Нелдера-Мида:   ', num2str(l0_),';']);
%     disp(' ');
%     disp('   Матрица коэфф. наблюдателя: '); disp(L_);
%         eig_A0 = eig(A-L_*C);
%     disp(' ');
%     disp('   Собств. числа матрицы наблюдателя A0: '); disp(eig_A0);
%     disp(' '); disp(' ');
end
end