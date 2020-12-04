function sm_outputs = softmax(outputs)
    scale = sum(exp(outputs),2);
    sm_outputs = exp(outputs) ./ scale;
end