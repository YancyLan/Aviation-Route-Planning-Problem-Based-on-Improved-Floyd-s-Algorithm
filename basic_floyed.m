% 介绍：第一题第(1)问Matlab程序，求解恰一次转机的城市对数量
A = zeros(49, 49);

% 根据城市对矩阵 LL 填充邻接矩阵 A（LL 由于太长，此处不给出，详情见压缩文件）
for i = 1:150
    A(LL(i, 1), LL(i, 2)) = 1; % LL为城市对矩阵
end

% 将未连接的点设为无穷大
B = find(A == 0);
A(B) = inf;

% 对角线设置为 0（城市到自己的距离为 0）
for i = 1:49
    A(i, i) = 0;
end

% 使用 Floyd-Warshall 算法求解最短路径
[D, path] = floyd(A);

% 找到恰好一次转机的城市对
[m, n] = find(D == 2);
disp('城市对数')
disp(size(m, 1))

% 介绍：第一题第（2）问，Floyd算法和Dijkstra算法求最短路径
[D, path] = floyd(A);

% 找到最远的城市对
imax = max(max(D));
[m, n] = find(D == imax);

% 计算义乌与沈阳之间的最短路径（双向均成立）
[dist, path] = dijkstra(A, m(2), n(2));
disp('义乌与沈阳之间最短路径为(双向均成立)：');
disp(path)

% 计算义乌与大连之间的最短路径（双向均成立）
[dist, path] = dijkstra(A, m(1), n(1));
disp('义乌与大连之间最短路径为（双向均成立）：');
disp(path)

% Floyd-Warshall 算法实现
function [D, path] = floyd(a)
    n = size(a, 1);
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
    
    % Floyd-Warshall 算法更新最短路径
    for k = 1:n
        for i = 1:n
            for j = 1:n
                if D(i, k) + D(k, j) < D(i, j)
                    D(i, j) = D(i, k) + D(k, j);
                    path(i, j) = path(i, k);
                end
            end
        end
    end
end

% Dijkstra 算法实现
function [d, p] = dijkstra(adj, s, t)
    nodes_num = size(adj, 1);
    dist = inf(nodes_num, 1);
    previous = inf(nodes_num, 1);
    Q = (1:nodes_num)';
    
    % 找出每个节点的邻居
    neighbors = cell(nodes_num, 1);
    for i = 1:nodes_num
        neighbors{i} = find(adj(i, :) > 0);
    end
    
    dist(s) = 0;
    
    % 进行最短路径搜索
    while ~isempty(Q)
        [~, min_ind] = min(dist(Q));
        min_node = Q(min_ind);
        Q = setdiff(Q, min_node);
        
        if min_node == t
            d = dist(min_node);
            p = generate_path(previous, t);
            return;
        end
        
        for i = 1:length(neighbors{min_node})
            neighbor = neighbors{min_node}(i);
            alt = dist(min_node) + adj(min_node, neighbor);
            if alt < dist(neighbor)
                dist(neighbor) = alt;
                previous(neighbor) = min_node;
            end
        end
    end
    
    d = dist;
    p = cell(nodes_num, 1);
    for i = 1:nodes_num
        p{i} = generate_path(previous, i);
    end
end

% 生成路径函数
function path = generate_path(previous, t)
    path = [t];
    while previous(t) <= length(previous)
        path = [previous(t), path];
        t = previous(t);
    end
end
