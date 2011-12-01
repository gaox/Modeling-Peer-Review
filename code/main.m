MAX_TIMESTEP = 500;

SCIENTIST_NUM = 1000;
MEAN_IQ = 100;
STDDEV_IQ = 10;
STDDEV_QUALITY = 5;

CORRECT_REFEREE = 1;
RANDOM_REFEREE = 2;
RATIONAL_REFEREE = 3;

F_CORRECT = 0.9;
F_RANDROM = 0.1;
F_RATIONAL = 1 - F_CORRECT - F_RANDROM;

REFEREE_PER_PAPER = 2;
MIN_QUALITY = 90;

lambda = 0.1;
alpha = 0;

author_type = zeros(1, 1000);
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

MA = zeros(1, 2);
std_quality = 0;
avg_quality = zeros(1, MAX_TIMESTEP);

for i = 1:MAX_TIMESTEP
    accept_num = 0;
    all_quality = zeros(1, SCIENTIST_NUM);
    for j = 1:SCIENTIST_NUM
        paper_quality = normrnd(IQ(j), STDDEV_QUALITY);
        referee = choose_referee(SCIENTIST_NUM, j);
        decision = 0;
        if (i > 1)
            MA(2) = MA(1) * lambda + (1 - lambda) * mean(avg_quality(1:i-1));
        else
            MA(2) = 0;
        end
        for k = 1:REFEREE_PER_PAPER
            qmin = MA(2) + alpha * std_quality;
            %fprintf('qmin %f\n', qmin);
            if (author_type(referee(k)) == CORRECT_REFEREE)
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
                accept_num = accept_num + 1;
                all_quality(accept_num) = paper_quality;
            end
        end
    end
    
    if (accept_num >= 1)
        accept_quality = all_quality(1:accept_num);
        avg_quality(i) = mean(accept_quality);
        std_quality = std(accept_quality);
    else
        avg_quality(i) = 0;
        std_quality = 0;
    end
    
    MA(1) = MA(2);
    %fprintf('avg_quality %f\n', avg_quality(i));
    %fprintf('std_quality %f\n', std_quality);
end

plot(1:MAX_TIMESTEP, avg_quality);
%hist(avg_quality);