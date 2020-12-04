function plot_train_performance(mean_performance, max_performance)
    tiledlayout(2,1)
    nexttile
    plot(mean_performance)
    title('Mean Performance')
    nexttile
    plot(max_performance)
    title('Max Performance')
end


