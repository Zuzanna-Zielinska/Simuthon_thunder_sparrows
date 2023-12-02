

time_min = 1.5;
time_max = 3.5;
d_time = 5e-5;

idx_min = (time_min/d_time)+5;
idx_max = (time_max/d_time)+5;


maxim = max(out.check.Data(idx_min : idx_max, 2))
minim = min(out.check.Data(idx_min : idx_max, 2))

accur = (maxim - minim) / maxim

% start



