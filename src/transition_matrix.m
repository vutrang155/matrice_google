function T = transition_matrix (adj_mat)
  T = repmat(adj_mat,1).';
  for ic = 1:size(T,2) #Iterate columns
    if T(:,ic) == 0
      T(ic, ic) = 1;
    endif
    T(:,ic) = T(:, ic) / sum(T(:,ic));
  endfor
  
endfunction