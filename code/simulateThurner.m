function simulateThurner(MAX_TIMESTEP, SCIENTIST_NUM, F_RANDROM, F_RATIONAL, alpha)

MEAN_IQ = 100;
STDDEV_IQ = 10;
STDDEV_QUALITY = 5;

CORRECT_REFEREE = 1;
RANDOM_REFEREE = 2;
RATIONAL_REFEREE = 3;

F_CORRECT = 1 - F_RANDROM - F_RATIONAL;

REFEREE_PER_PAPER = 2;
MIN_QUALITY = 90;

F_NETWORK = 0;

lambda = 0.1;

author_type = zeros(1, SCIENTIST_NUM);
IQ = zeros(1, SCIENTIST_NUM);
for i = 1:SCIENTIST_NUM
    IQ(i) = normrnd(MEAN_IQ, STDDEV_IQ);
    if (i <= F_CORRECT * SCIENTIST_NUM)
        author_type(i) = CORRECT_REFEREE;
    elseif (i <= (F_CORRECT + F_RANDROM) * SCIENTIST_NUM)
        author_type(i) = RANDOM_REFEREE;
    else
        author_type(i) = RATIONAL_REFEREE;
    end
end

in_network = zeros(1, SCIENTIST_NUM);

for i = 1:F_NETWORK * SCIENTIST_NUM
   in_network(i) = 1;
end

MA = zeros(1, 2);
std_quality = 0;
avg_quality = zeros(1, MAX_TIMESTEP);
avg_quality_nw = zeros(1, MAX_TIMESTEP);
avg_quality_no_nw =zeros(1, MAX_TIMESTEP);

quality_submitted = zeros(1, 160);
quality_acceptted = zeros(1, 160);
all_quality_acc = zeros(1, SCIENTIST_NUM * MAX_TIMESTEP);
all_quality_acc_nw = zeros(1, SCIENTIST_NUM * MAX_TIMESTEP);
all_quality_acc_no_nw = zeros(1, SCIENTIST_NUM * MAX_TIMESTEP);
all_paper_acc_num = 0;
all_paper_acc_num_nw = 0;
all_paper_acc_num_no_nw = 0;
acc_num = zeros(1, MAX_TIMESTEP);

for i = 1:MAX_TIMESTEP
    accept_num = 0;
    accept_num_nw = 0;
    accept_num_no_nw = 0;
    all_quality = zeros(1, SCIENTIST_NUM);
    all_quality_nw = zeros(1, SCIENTIST_NUM);
    all_quality_no_nw = zeros(1, SCIENTIST_NUM);
    for j = 1:SCIENTIST_NUM
        paper_quality = normrnd(IQ(j), STDDEV_QUALITY);
        quality_submitted(floor(paper_quality)) = quality_submitted(floor(paper_quality)) + 1;
        referee = choose_referee(SCIENTIST_NUM, j);
        decision = 0;
        if (i > 1)
            MA(2) = MA(1) * lambda + (1 - lambda) * mean(avg_quality(1:i-1));
        else
            MA(2) = 0;
        end
        for k = 1:REFEREE_PER_PAPER
            qmin = MA(2) + alpha * std_quality;
            if (in_network(referee(k)) == 1 && in_network(j) == 1)
                decision = decision + 1;
            elseif (author_type(referee(k)) == CORRECT_REFEREE)
                if (paper_quality >= qmin)
                    decision = decision + 1;
                end
            elseif (author_type(referee(k)) == RANDOM_REFEREE)
                decision = decision + randi(2, 1) - 1;
            else
                if (paper_quality >= MIN_QUALITY && paper_quality < IQ(referee(k)))
                    decision = decision + 1;
                end
            end
        end
        if (decision > REFEREE_PER_PAPER / 2)
            accept = 1;
        elseif (decision < REFEREE_PER_PAPER / 2)
            accept = 0;
        else
            accept = randi(2, 1) - 1;
        end

        if (accept == 1)
            accept_num = accept_num + 1;
            all_quality(accept_num) = paper_quality;
            quality_acceptted(floor(paper_quality)) = quality_acceptted(floor(paper_quality)) + 1;
            if (in_network(j))
                accept_num_nw = accept_num_nw + 1;
                all_quality_nw(accept_num_nw) = paper_quality;
            else
                accept_num_no_nw = accept_num_no_nw + 1;
                all_quality_no_nw(accept_num_no_nw) = paper_quality;
            end
        end
    end
    
    if (accept_num >= 1)
        accept_quality = all_quality(1:accept_num);
        all_quality_acc(all_paper_acc_num + 1:all_paper_acc_num + accept_num) = accept_quality;
        all_paper_acc_num = all_paper_acc_num + accept_num;
        avg_quality(i) = mean(accept_quality);
        std_quality = std(accept_quality);
    else
        avg_quality(i) = 0;
        std_quality = 0;
    end
    
    if (accept_num_nw >= 1)
        accept_quality_nw = all_quality_nw(1:accept_num_nw);
        all_quality_acc_nw(all_paper_acc_num_nw + 1:all_paper_acc_num_nw + accept_num_nw) = accept_quality_nw;
        all_paper_acc_num_nw = all_paper_acc_num_nw + accept_num_nw;
        avg_quality_nw(i) = mean(accept_quality_nw);
    else
        avg_quality_nw(i) = 0;
    end
    
    if (accept_num_no_nw >= 1)
        accept_quality_no_nw = all_quality_no_nw(1:accept_num_no_nw);
        all_quality_acc_no_nw(all_paper_acc_num_no_nw + 1:all_paper_acc_num_no_nw + accept_num_no_nw) = accept_quality_no_nw;
        all_paper_acc_num_no_nw = all_paper_acc_num_no_nw + accept_num_no_nw;
        avg_quality_no_nw(i) = mean(accept_quality_no_nw);
    else
        avg_quality_no_nw(i) = 0;
    end
    
    acc_num(i) = accept_num;
    MA(1) = MA(2);
end

%all_quality_acc = all_quality_acc(1:all_paper_acc_num);
%all_quality_acc_nw = all_quality_acc_nw(1:all_paper_acc_num_nw);
%all_quality_acc_no_nw = all_quality_acc_no_nw(1:all_paper_acc_num_no_nw);

filecode = [int2str(F_CORRECT * 100), '_', int2str(F_RANDROM * 100), '_', int2str(F_RATIONAL * 100), '_', int2str(alpha * 100)];
folder = ['../data/', filecode];
mkdir(folder);
save([folder, '/avg_quality_', filecode], 'avg_quality');
save([folder, '/accept_quality_', filecode], 'quality_acceptted');
save([folder, '/submit_quality_', filecode], 'quality_submitted');
save([folder, '/acc_num_', filecode], 'acc_num');
%save([folder, '/all_quality_acc_', filecode], 'all_quality_acc');
%save([folder, '/all_quality_acc_nw_', filecode], 'all_quality_acc_nw');
%save([folder, '/avg_quality_nw_', filecode], 'avg_quality_nw');
%save([folder, '/avg_quality_no_nw_', filecode], 'avg_quality_no_nw');

end
