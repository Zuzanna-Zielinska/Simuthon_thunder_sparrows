
find(out.check.Data(100:end, 1) > 1.0, 1);
out.check.Data(85973, 1);
find(out.check.Data(100:end, 1) > 2.0, 1);
out.check.Data(172015, 1);

maxim = max(out.check.Data(85973 : 172015, 2));
minim = min(out.check.Data(85973 : 172015, 2));

accur = (maxim - minim) / maxim

% start