function [newHealth, index] = Poision(health)
    newHealth = health;
    index = randsample(length(health), 1);
    increaseOrdecrease = binornd(10, 0.5);
    factor = 20;
    if increaseOrdecrease == 1
        newHealth(index,:) = factor * health(index,:);
    else
        newHealth(index,:) = health(index,:) / factor;
    end
end

