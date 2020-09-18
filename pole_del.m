% ���������� �.�. ��� ���������������� �����������
% ����� ������������� delta_pol
function [l0, L, max_eigenval, A0, P] = pole_del(A, C, y, alpha, beta, norm_y, param)

if nargin == 3
    pol = delta_pol(y);
    norm_y = inf;
    param = [];
elseif nargin == 4 
    pol = delta_pol(y,alpha);
    norm_y = inf;
    param = [];
elseif nargin == 5
    pol = delta_pol(y, alpha, beta);
    norm_y = inf;
    param = [];
elseif (nargin == 6)
    pol = delta_pol(y, alpha, beta);
    param = [];
elseif (nargin == 7)
    pol = delta_pol(y, alpha, beta);
else
    error('������� ������ ������� ���������');
end

if norm(y) < norm_y
    if isempty(param) == 1
        % ������ � ������ ������������ � ��� ����� ������� L*
        p = roots(pol);
        L = (place(A', C', p))';
    else
        % ������ ��� ������������ A � �
        A_ = [1        0         0        0;...
              param(3) 1        -param(1) 0;...
              param(4) param(3) -param(2) -param(1);...
              0        param(4)  0        -param(2)];
        B_ = pol(2:5)' - [param(3) param(4) 0 0]';
        L_ = A_\B_;
        for i = 1:4
            if (isnan(L_(i)) == 1) || (L_(i) == inf)
                L_(i) = 0;
                warning(['���������� L(', num2str(i), '1) ������� �������� NaN ���� inf.']);
            end
        end
        L = [L_ param'];
    end

    % ������ ��������� ��������� ��������
    A0 = A - L*C;
    P = lyap(A0', eye(4));
    % ���������� �.�. ������� �
    max_eigenval = max(eig(P));
    l0 = 1/(2*max_eigenval);
else
    l0 = 0;
    L = [];
    max_eigenval = [];
    A0 = [];
    P = [];
end