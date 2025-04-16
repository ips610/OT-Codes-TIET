cost = [11 13 17 14;
    16 18 14 10;
    21 24 13 10];

supply = [10 5 9];
demand = [8 7 5 4];

a = sum(supply);
b = sum(demand);

[m,n] = size(cost);

if a == b
    disp("Balanced");
elseif a < b
    cost(end+1, :) = zeros(1, n);
    supply(end+1) = b - a;
else
    cost(:, end+1) = zeros(m, 1);
    demand(end+1) = a - b;
end

[m,n] = size(cost);

x = zeros(m,n);
icost = cost;

while any(supply ~= 0) || any(demand ~= 0)
    
    minvalue = min(cost(:))
    [r,c] = find(cost == minvalue)

    y = min(supply(r), demand(c))

    [aloc, index] = max(y)

    rr = r(index)
    cc = c(index)

    x(rr, cc) = aloc

    supply(rr) = supply(rr) - aloc
    demand(cc) = demand(cc) - aloc
    
    cost(rr, cc) = inf

end

if nnz(x) == m+n-1
    disp("Non Degenerate");
else
    disp("Degenerate");
end

output = icost.*x;
final_output = sum(output(:))