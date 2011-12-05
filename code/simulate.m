function simulate(MAX_TIMESTEP, SCIENTIST_NUM, F_RANDROM, F_RATIONAL, alpha)

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

STD_AC_NUM = 5;

JOURNAL_NUM = 4;
MEAN_AC_NUM = [50, 100, 200, 300];

threshold = [120, 110, 100, 0];

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

avg_quality = zeros(JOURNAL_NUM, MAX_TIMESTEP);

all_quality_acc = zeros(JOURNAL_NUM, SCIENTIST_NUM * MAX_TIMESTEP);
all_paper_acc_num = zeros(1, JOURNAL_NUM);
acc_num_r = zeros(JOURNAL_NUM, MAX_TIMESTEP);
max_ac_num = zeros(1, JOURNAL_NUM);

for i = 1:MAX_TIMESTEP
    accept_num = zeros(1, JOURNAL_NUM);
    papers = zeros(JOURNAL_NUM, SCIENTIST_NUM);
    for j = 1:JOURNAL_NUM
        max_ac_num(j) = ceil(normrnd(MEAN_AC_NUM(j), STD_AC_NUM));
    end
    
    for j = 1:SCIENTIST_NUM
        paper_quality = normrnd(IQ(j), STDDEV_QUALITY);
        referee = choose_referee(SCIENTIST_NUM, j);
        decision = 0;

        for k = 1:REFEREE_PER_PAPER
            qmin = IQ(referee(k));
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
            
            if (decision > REFEREE_PER_PAPER / 2)
                accept = 1;
            elseif (decision < REFEREE_PER_PAPER / 2)
                accept = 0;
            else
                accept = randi(2, 1) - 1;
            end
            
            if (accept == 1)
                for p = 1:JOURNAL_NUM
                    if (paper_quality >= threshold(p))
                        accept_num(p) = accept_num(p) + 1;
                        papers(p, accept_num(p)) = paper_quality;
                        break;
                    end
                end
            end
        end
    end
    
    for p = 1:JOURNAL_NUM
        if (accept_num(p) >= 1)
            sort(papers(p), 'descend');
            if (accept_num(p) > max_ac_num(p))
                accept_num(p) = max_ac_num(p);
            end
            accept_quality = papers(p, 1:accept_num(p));
            all_quality_acc(p, all_paper_acc_num(p) + 1:all_paper_acc_num(p) + accept_num(p)) = accept_quality;
            all_paper_acc_num(p) = all_paper_acc_num(p) + accept_num(p);
            avg_quality(p, i) = mean(accept_quality);
        else
            avg_quality(p, i) = 0;
        end
        acc_num_r(p, i) = accept_num(p);
    end
end

filecode = [int2str(F_CORRECT * 100), '_', int2str(F_RANDROM * 100), '_', int2str(F_RATIONAL * 100), '_', int2str(alpha * 100)];
folder = ['../data/mj_', filecode];
mkdir(folder);
save([folder, '/avg_quality_', filecode], 'avg_quality');
save([folder, '/acc_num_r_', filecode], 'acc_num_r');

end
