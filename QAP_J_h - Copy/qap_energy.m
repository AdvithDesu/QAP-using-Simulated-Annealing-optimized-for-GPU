function energy = qap_energy(current_state,F,D,len)
    energy = 0;
    n = sqrt(len);
    spin = current_state;
    index = find(current_state == -1);
    spin(index) = 0;
    spin2 = reshape(spin',n,n);
    rowSums = sum(spin2, 2); % Sum along rows (2nd dimension)
    colSums = sum(spin2, 1); % Sum along columns (1st dimension)
    rowsAreOne = all(rowSums == 1);
    colsAreOne = all(colSums == 1);
    if rowsAreOne && colsAreOne
    [row, col] = find(spin2 == 1);
    state = [row, col]; % Combine into a 2D array
        % Compute the energy
        for i = 1:size(state, 1)
            flow_row = F(state(i, 2), state(:, 2)); % Row of flow matrix
            dist_row = D(state(i, 1), state(:, 1)); % Row of distance matrix
            energy = energy + sum(flow_row .* dist_row); % Dot product
        end
        % energy(k) = energy_app;
        % energy_app = 0;
    else
        energy = 100;
    end
end
