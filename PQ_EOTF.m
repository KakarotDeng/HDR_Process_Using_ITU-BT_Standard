function FD=PQ_EOTF(E_)

% E_ is the non-linear value {R', G', B'} or { L', M', S'} in PQ space in the range [0:1]
% Y is the normalized linear colour value, in the range [0:1]
% FD is the luminance of a displayed linear component {RD, GD, BD} or YD or ID, in cd/m2.

    m1 = 2610 / (2^14);
    m2 = 2523 / (2^5);
    c1 = 3424 / (2^12);
    c2 = 2413 / (2^7);
    c3 = 2392 / (2^7);
    Ep = E_;
    test=(c2 - c3 * Ep .^ (1/m2));
    Y= (max((Ep .^ (1/m2) - c1),0) ./ (c2 - c3 * Ep .^ (1/m2))) .^ (1/m1); 
    FD=Y;
 
end
