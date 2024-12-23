function E_ = HLG_OETF(E)

% E is a signal for each colour component {RS, GS, BS} proportional to scene linear light normalized to the range [0:1].
% E_ is the resulting non-linear signal {R', G', B'} in the range [0:1].

    a=0.17883277;
    b=1-4*a;
    c = 0.5-a*log(4*a);
    threshold = 1/12; 
    E_ = zeros(size(E)); 
    mask1 = (E >= 0) & (E <= threshold); 
    E_(mask1) = sqrt(3 * E(mask1));
    mask2 = (E > threshold) & (E <= 1); 
    E_(mask2) = a * log(12 * E(mask2) - b) + c;
    
end

