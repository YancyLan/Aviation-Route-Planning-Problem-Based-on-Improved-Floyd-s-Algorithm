% 构造飞行时间邻接矩阵
A = zeros(49, 49);
for i = 1:71
    A(LL(i, 1), LL(i, 2)) = LL(i, 3); % LL为城市对矩阵加一列飞行时间
end

% 构造邻接矩阵
B = find(A == 0);
A(B) = inf;

% 设置对角线元素为0
for i = 1:49
    A(i, i) = 0;
end

% 构造起飞时间矩阵
A1 = zeros(49, 49);
for i = 1:71
    A1(LL2(i, 1), LL2(i, 2)) = LL2(i, 3); % LL2为起飞时间数据
end

B = find(A1 == 0);
A1(B) = inf;

for i = 1:49
    A1(i, i) = 0;
end

% 构造落地时间矩阵
A2 = zeros(49, 49);
for i = 1:71
    A2(LL3(i, 1), LL3(i, 2)) = LL3(i, 3); % LL3为落地时间数据
end

B = find(A2 == 0);
A2(B) = inf;

for i = 1:49
    A2(i, i) = 0;
end

% 第二题第（1）问
[D, path] = floyd(A, A1, A2);
[x, y] = find(D <= 360);
disp(['6小时之内可到达的线路:', num2str(size(x, 1) - 49)])

% 第二题第（2）问
[D, path, P] = floyd(A, A1, A2);
Q = find(P > 99999);
P(Q) = -1;
disp(['转机次数最多的线路中转机次数：', num2str(max(max(P)))])
[x1, x2] = find(P == max(max(P)));
disp(['转机次数最多的线路条数：', num2str(size(x1, 1))])

% 第二题第（3）问
[D, path, P] = floyd(A, A1, A2);
Q = find(D > 99999);
D(Q) = -1;
[v1, v2] = find(D == max(max(D)));
road(path, v1, v2)

% 改进的Floyd算法
function [D, path, P] = floyd(a, A1, A2)
    n = size(a, 1);
    P = ones(49, 49);
    D = a;
    path = zeros(n, n);

    % 初始化路径
    for i = 1:n
        for j = 1:n
            if D(i, j) ~= inf
                path(i, j) = j;
            end
        end
    end

    % 改进的Floyd算法
    for k = 1:n
        for i = 1:n
            for j = 1:n
                x = i;
                y = j;
                
                % 求k的前继
                while path(x, k) ~= k
                    x = path(x, k);
                    if x == 0
                        break;
                    end
                end
                
                % 求后继
                y = path(k, j);
                if y == 0
                    continue;
                end
                if x == 0
                    continue;
                end
                
                % 判断转机候机时间
                if A1(k, y) < 5000 && A2(x, k) < 5000 && A1(k, y) > 0 && A2(x, k) > 0
                    if A1(k, y) - A2(x, k) > 0
                        z = A1(k, y) - A2(x, k); % 转机候机时间
                        if z < 60
                            z = 24 * 60 + z;
                        end
                    else
                        z = 24 * 60 - A2(x, k) + A1(k, y);
                        if z < 60
                            z = 24 * 60 + z; % 如果不满足最低候机时间，则额外等一天
                        end
                    end
                else
                    z = 0;
                end
                
                % 更新距离和路径
                if D(i, k) + D(k, j) + z < D(i, j)
                    D(i, j) = D(i, k) + D(k, j) + z;
                    P(i, j) = P(i, k) + P(k, j);
                    path(i, j) = path(i, k);
                end
            end
        end
    end

    % 处理无穷大的情况
    M = find(D > 99999);
    P(M) = inf;
    P = P - 1;
end

% 定义路径函数
function pathway = road(path, v1, v2)
    pathway = v1;
    
    while path(pathway(end), v2) ~= v2
        if path(pathway(end), v2) == 0
            continue;
        end
        pathway = [pathway, path(pathway(end), v2)];
    end
    
    pathway
