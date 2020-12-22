# PATH
global DATA_PATH="../data/";

file_path = [DATA_PATH "ex1.txt"];

edges = dlmread(file_path, " ", 0, 0);
nodes = unique(edges);
adj_mat = adjacency_matrix(nodes, edges);
n = size(adj_mat, 1);
# Transition Matrix
T = transition_matrix(adj_mat);

% First constraint : 
%     Once arrived to sites where user can't go any further (absorbing state), 
%   we suppose that it is possible that he/she will access to other pages by 
%   typing its address on address bar. Therefore, the probability that he access
%   one page is 1/n
for i=1:n
  if T(i,i) == 1 % Check for absorbing states
    T(:,i) = 1/n; 
  endif
endfor

% Second constraint :
%     User has 2 possibilities, when he/she's on a site. It's possible for him
%   /her to : 
%     * Accessing on other sites via the site he/she is on, with the 
%       probability p.
%     * Accessing on other sites via adress bar, with the probability (1 - p).
p = 0.85; % By default, p is the probability Google chose
K = repmat(1/n, n, n); % Possibility user accesses other website on address bar
G = p.*T + (1-p).*K;

% Stationary Probability Vector
[V, D] = eig(G);
%   Finding index where eigenvalue = 1 (By definition, pi = G*pi <=> pi 
%   eigenvector of G, associates with eigenvalue 1)
idx = -1;
for i=1:n
  v = D(i,i);
  if (abs(v-1) < 1e4*eps(min(abs(v),abs(1)))) == 1
    idx = i;
  endif
endfor
pi = V(:,idx);
[~, rank] = sort(pi, 'descend');