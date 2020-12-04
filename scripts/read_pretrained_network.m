function [W1, W2, W3, B1, B2, B3] = read_pretrained_network(path, W1_path, W2_path, W3_path, B1_path, B2_path, B3_path)
    W1 = readmatrix(strcat(path, W1_path));
    W2 = readmatrix(strcat(path, W2_path));
    W3 = readmatrix(strcat(path, W3_path));
    B1 = readmatrix(strcat(path, B1_path));
    B2 = readmatrix(strcat(path, B2_path));
    B3 = readmatrix(strcat(path, B3_path));
end