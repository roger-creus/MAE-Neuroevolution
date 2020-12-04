function O = ReLU(x)
    O = x;
    O(x < 0) = 0;
end

