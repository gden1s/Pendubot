%%% ���������� L, �������������� �� �������� ������� ��-� ������ ����������
function [l0, L] = finding_l0(A, C, alpha, beta, norm_y, const_L, n_L, y_fminsearchstart)
% norm_y - ����������� ����� ������� L (����� �� ���� ������� ������� ����������)
% const_L - ������� ��������� ������� ��� ������� (��� ������ ����������)
% n_L - ����� ���� �������� alpha, ������� ������������ � ����������
% y_fminsearchstart ��� ��������� ����� ��� fminsearch

if nargin == 7
    y_fminsearchstart = 20*rand(1, length(A(1,:))); % ������ ������
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
    % �������������� �������
    func = @(y)pole_del(A, C, y, alpha_, beta, norm_y_);
    % ������������ ������� �������-����
    y0 = zeros(1, length(A(1,:))); % ��������� �����
    y_opt = fminsearch(@(y)(-func(y)), y_fminsearchstart(i,:));
    % ����������� l0 � L
    [l0_, L_] = pole_del(A, C, y_opt, alpha_, beta, norm_y_);
    if n_L == i
        L = L_;
        l0 = l0_;
    end
    disp([num2str(i),'. ������� ������������ alpha = ', num2str(alpha_), ', beta = ', num2str(beta), ';']);
    disp(' ');
    disp(['   ��������� ������� ��� ������ �������:   ', num2str(const_L), ';']);
%     disp(' ');
%     disp(['   �������� lyambda0 �� ������ ���������������� �������� (y = [', num2str(y0), ']):   ',... 
%         num2str(pole_del(A, C, y0, alpha_, beta, norm_y_)),';',]);
%     disp(' ');
    disp(['   �������� lyambda0 ��������� ������� �������-����:   ', num2str(l0_),';']);
%     disp(' ');
%     disp('   ������� �����. �����������: '); disp(L_);
%         eig_A0 = eig(A-L_*C);
%     disp(' ');
%     disp('   ������. ����� ������� ����������� A0: '); disp(eig_A0);
%     disp(' '); disp(' ');
end
end