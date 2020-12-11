function save_network(path,idx, W1, W2, W3, B1, B2, B3, W1p, W2p, W3p, B1p, B2p, B3p)
    writematrix(W1(:,:,idx),strcat(path, W1p));
    writematrix(W2(:,:,idx),strcat(path, W2p));
    writematrix(W3(:,:,idx),strcat(path, W3p));
    writematrix(B1(:,:,idx),strcat(path, B1p));
    writematrix(B2(:,:,idx),strcat(path, B2p));
    writematrix(B3(:,:,idx),strcat(path, B3p));
end