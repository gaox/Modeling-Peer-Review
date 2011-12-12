function [relation] = generate_relationship(num_scientist, probability)
    relation = full(random_graph(num_scientist, probability));
end
