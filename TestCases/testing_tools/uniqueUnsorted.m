function [B]=uniqueUnsorted(A)
% function [B]=uniqueUnsorted(A)
% 
% Description:  unique rewrited 
% 
% Note : matlab has rewrited unique function:
%        Check if this function can be avoided

[~,b] = unique(A);
b = sort(b);
B = zeros(size(A,1),length(b));
for i = 1:length(b)
    B(i) = A(b(i));
end

