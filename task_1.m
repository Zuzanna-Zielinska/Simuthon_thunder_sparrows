function [path] = task_1(map, startPoint, stopPoint)
    % THUNDER SPARROWS
    % get the cost map from the map
    cost_map = map(:,:,1).*(map(:,:,2).*map(:,:,3) + map(:,:,4));
    
    % first layer defines the mat 0 indicates the cell is not a road and 1 indicates the cell is a road

    [row, col] = size(cost_map);
    % create a matrix to store the cost of each cell and a parent node
    path_map = zeros(row, col, 4);


    % add the start point to the search queue
    search_queue = [startPoint, startPoint, 0];


    neighbours = [-1, 0; 1, 0; 0, -1; 0, 1];
    neighbours_diagonal = [-1, -1; -1, 1; 1, -1; 1, 1];    
    
    % search the map using djiakstra algorithm

    % while queue is not empty
    while ~isempty(search_queue)
        % get the first element in the queue
        current_elem = search_queue(1, :);
        current_node = current_elem(1:2);
        parent = current_elem(3:4);
        cost = current_elem(5);
        % remove the first element in the queue
        search_queue(1, :) = [];
        % get the neighbours of the current node
        % if not visited
        if path_map(current_node(1), current_node(2), 1) == 0
            % mark as visited
            path_map(current_node(1), current_node(2), 1) = 1;
            path_map(current_node(1), current_node(2), 2:3) = parent;
            path_map(current_node(1), current_node(2), 4) = cost;
            
            % if the current node is the stop point
            if current_node == stopPoint
                % break the loop
                break
            end

            % get the indexes of neighbours of the current node
            neighbours_temp = neighbours + current_node;
            neighbours_temp = neighbours_temp(all(neighbours_temp > 0, 2), :);
            
            neighbours_temp_diagonal = neighbours_diagonal + current_node;
            neighbours_temp_diagonal = neighbours_temp_diagonal(all(neighbours_temp_diagonal > 0, 2), :);
            
            % for each neighbour
            for i = 1:4
                % if the neighbour is not visited and cost is not 0
                if path_map(neighbours_temp(i, 1), neighbours_temp(i, 2), 1) == 0 && cost_map(neighbours_temp(i, 1), neighbours_temp(i, 2)) ~= 0
                    % add the neighbour to the queue
                    search_queue = [search_queue; neighbours_temp(i, :), current_node, cost + cost_map(neighbours_temp(i, 1), neighbours_temp(i, 2))];
                end

                % if the diagonal neighbour is not visited and cost is not 0
                if path_map(neighbours_temp_diagonal(i, 1), neighbours_temp_diagonal(i, 2), 1) == 0 && cost_map(neighbours_temp_diagonal(i, 1), neighbours_temp_diagonal(i, 2)) ~= 0
                    % add the neighbour to the queue - multiply cost by sqrt(2)
                    search_queue = [search_queue; neighbours_temp_diagonal(i, :), current_node, cost + cost_map(neighbours_temp_diagonal(i, 1), neighbours_temp_diagonal(i, 2))*sqrt(2)];
                end
            end
        end

        % sort the queue
        search_queue = sortrows(search_queue, 5);
    end

    % get the path
    path = [];
    current_node = stopPoint;
    while current_node(1) ~= startPoint(1) || current_node(2) ~= startPoint(2)
        path = [current_node; path];
        current_node = [path_map(current_node(1), current_node(2), 2), path_map(current_node(1), current_node(2), 3)];
    end
    path = [startPoint; path];

end

