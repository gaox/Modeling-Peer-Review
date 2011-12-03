%% plot the average paper quality
MAX_TIMESTEP = 500;

fig = figure();
set(gca, 'FontSize', 16);
load('../data/avg_quality_100_0_0', 'avg_quality');
plot(1:MAX_TIMESTEP, avg_quality);
xlabel('publication rounds');
ylabel('average quality');
ylim([90 140]);
saveas(fig, '../doc/figure/avg_quality_100_0_0.eps', 'psc2');

%% 
MAX_TIMESTEP = 500;

fig = figure();
set(gca, 'FontSize', 16);
load('../data/avg_quality_90_0_10', 'avg_quality');
plot(1:MAX_TIMESTEP, avg_quality);
xlabel('publication rounds');
ylabel('average quality');
ylim([90 140]);
saveas(fig, '../doc/figure/avg_quality_90_0_10.eps', 'psc2');

%% plot the distribution of paper quality
fig = figure();
set(gca, 'FontSize', 16);
xlabel('paper quality');
ylabel('quality distribution');
xlim([60 140]);
ylim([0 0.3]);
load('../data/accept_quality_90_0_10', 'quality_acceptted');
load('../data/submit_quality_90_0_10', 'quality_submitted');
hold on;
h=bar(quality_acceptted / sum(quality_acceptted), 'hist');
set(findobj(h), 'FaceColor', 'r');
plot(quality_submitted / sum(quality_submitted));
legend('Q_{accepted}', 'Q_{submitted}');
saveas(fig, '../doc/figure/accept_quality_90_0_10.eps', 'psc2');

%% 
fig = figure();
set(gca, 'FontSize', 16);
xlabel('paper quality');
ylabel('quality distribution');
xlim([60 140]);
ylim([0 0.3]);
load('../data/accept_quality_100_0_0', 'quality_acceptted');
load('../data/submit_quality_100_0_0', 'quality_submitted');
hold on;
h=bar(quality_acceptted / sum(quality_acceptted), 'hist');
set(findobj(h), 'FaceColor', 'r');
plot(quality_submitted / sum(quality_submitted));
legend('Q_{accepted}', 'Q_{submitted}');
saveas(fig, '../doc/figure/accept_quality_100_0_0.eps', 'psc2');

%%
f_random = [0, 0.1, 0.2];
f_rational = 0:0.1:0.7;

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
        filecode = [int2str((1 - i - j) * 100), '_', int2str(j * 100), '_', int2str(i * 100)];
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

%%
f_random = 0;
f_rational = 0:0.1:0.7;

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
        filecode = [int2str((1 - i - j) * 100), '_', int2str(j * 100), '_', int2str(i * 100)];
        folder = ['../data/nw_', filecode];
        load([folder, '/avg_quality_nw_', filecode], 'avg_quality_nw');
        load([folder, '/avg_quality_no_nw_', filecode], 'avg_quality_no_nw')
        errorbar(i, mean(avg_quality_nw), std(avg_quality_nw), 'or', 'MarkerFaceColor', 'r');
        errorbar(i, mean(avg_quality_no_nw), std(avg_quality_no_nw), 'sb', 'MarkerFaceColor', 'b');
        if i == 0.7
            legend('90% not in nw', '10% in nw');
        end
    end
end
saveas(fig, '../doc/figure/network_comparison.eps', 'psc2');

%%
f_random = 0;
f_rational = 0:0.1:0.7;
alpha = [1.0, 0];

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
        for k = alpha
            filecode = [int2str((1 - i - j) * 100), '_', int2str(j * 100), '_', int2str(i * 100), '_', int2str(k * 100)];
            folder = ['../data/journal_', filecode];
            load([folder, '/avg_quality_', filecode], 'avg_quality');
            if (k == 0)
                errorbar(i, mean(avg_quality), std(avg_quality), 'or', 'MarkerFaceColor', 'r');
            else
                errorbar(i, mean(avg_quality), std(avg_quality), 'sb', 'MarkerFaceColor', 'b');
            end
        end
        if i == 0.7
            legend('Journal: > avg', 'Journal: > avg + \delta');
        end
    end
end
saveas(fig, '../doc/figure/journal_comparison.eps', 'psc2');
