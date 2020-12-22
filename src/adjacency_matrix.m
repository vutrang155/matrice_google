function X = adjacency_matrix(nodes, edges)
  n = size(nodes, 1);
  X = zeros(n, n);
  for edge = edges.'
    X(edge(1), edge(2)) = 1;
  endfor
endfunction
