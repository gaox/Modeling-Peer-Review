%% plot the paper accept number when referee consists of 100 percent correct referee
MAX_TIMESTEP = 500;

fig = figure();
set(gca, 'FontSize', 16);
load('../data/100_0_0_0/acc_num_100_0_0_0', 'acc_num');
load('../data/100_0_0_0/avg_quality_100_0_0_0', 'avg_quality');
subplot(2, 1, 1);
plot(1:MAX_TIMESTEP, avg_quality);
title('(a)');
xlabel('publication rounds');
ylabel('average quality');
ylim([90 140]);
subplot(2, 1, 2);
plot(1:MAX_TIMESTEP, acc_num, 'r');
title('(b)');
xlabel('publication rounds');
ylabel('accepted paper');
xlim([0 500]);
ylim([0 250]);
saveas(fig, '../doc/figure/acc_num_100_0_0_0.eps', 'psc2');

%% plot the average paper quality when referee consists of 
% 90 percent correct referee and 10 percent rational referee
MAX_TIMESTEP = 500;

fig = figure();
set(gca, 'FontSize', 16);
load('../data/90_0_10_0/avg_quality_90_0_10_0', 'avg_quality');
plot(1:MAX_TIMESTEP, avg_quality);
xlabel('publication rounds');
ylabel('average quality');
ylim([90 140]);
saveas(fig, '../doc/figure/avg_quality_90_0_10_0.eps', 'psc2');

%% plot the average quality with without network
f_random = [0, 0.1, 0.2];
f_rational = 0:0.1:0.7;
alpha = 0;

fig = figure();
set(gca, 'FontSize', 16);
xlabel('fraction rational referees');
ylabel('average paper quality');
xlim([-0.1 0.8]);
hold on;
for i = f_rational
    for j = f_random
        if (i + j > 1)
            continue;
        end
        filecode = [int2str((1 - i - j) * 100), '_', int2str(j * 100), '_', int2str(i * 100), '_', int2str(alpha * 100)];
        folder = ['../data/', filecode];
        load([folder, '/avg_quality_', filecode], 'avg_quality');
        if j == 0
            errorbar(i, mean(avg_quality), std(avg_quality), 'or', 'MarkerFaceColor', 'r');
        elseif j == 0.1
            errorbar(i, mean(avg_quality), std(avg_quality), 'sb', 'MarkerFaceColor', 'b');
        else
            errorbar(i, mean(avg_quality), std(avg_quality), 'vg', 'MarkerFaceColor', 'g');
        end
        if i == 0.7
            legend('f_{rnd} = 0', 'f_{rnd} = 0.1', 'f_{rnd} = 0.2');
        end
    end
end
saveas(fig, '../doc/figure/no_network_comparison.eps', 'psc2');

%% plot the paper accept number and qualities when there are many journals
JOURNAL_NUM = 4;
threshold = [110, 100, 90, 80];

load('../data/mj_100_0_0_0/acc_num_r_100_0_0_0', 'acc_num_r');
load('../data/mj_100_0_0_0/avg_quality_100_0_0_0', 'avg_quality');
fig = figure();
set(gca, 'FontSize', 16);
hold on;

y = zeros(1, JOURNAL_NUM);
for i = 1:JOURNAL_NUM
    y(i) = mean(avg_quality(i));
end

bar(y);
for i = 1:JOURNAL_NUM
    line([i - 0.4, i + 0.4], [threshold(i), threshold(i)], 'Color', 'g', 'LineWidth', 2, 'LineStyle', '--');
    %plot(x, threshold(i), '-r', 'LineWidth', 10);
end
set(gca,'xtick',1:4);
xlabel('journal');
ylabel('average quality');
xlim([0 5]);
ylim([60 140]);

saveas(fig, '../doc/figure/mj_avg_quality_100_0_0_0.eps', 'psc2');

%% plot the paper accept number and qualities when there are many journals
%  now include relationship of scientists
MAX_TIMESTEP = 500;
JOURNAL_NUM = 4;
threshold = [110, 100, 90, 80];

load('../data/mj_rela_100_0_0_0/acc_num_r_100_0_0_0_50', 'acc_num_r');
load('../data/mj_rela_100_0_0_0/avg_quality_100_0_0_0_50', 'avg_quality');
fig = figure();
set(gca, 'FontSize', 16);
hold on;

y = zeros(1, JOURNAL_NUM);
for i = 1:JOURNAL_NUM
    y(i) = mean(avg_quality(i));
end

bar(y);
for i = 1:JOURNAL_NUM
    line([i - 0.4, i + 0.4], [threshold(i), threshold(i)], 'Color', 'g', 'LineWidth', 2, 'LineStyle', '--');
    %plot(x, threshold(i), '-r', 'LineWidth', 10);
end
set(gca,'xtick',1:4);
xlabel('journal');
ylabel('average quality');
xlim([0 5]);
ylim([60 140]);

saveas(fig, '../doc/figure/mj_rela_avg_quality_100_0_0_0_50.eps', 'psc2');