function E_ = PQ_OETF(E)

% E is the real value in the scene.
% E_ is the resulting non-linear signal {R', G', B'} in the range [0:1].

    m1 = 2610 / (2^14);
    m2 = 2523 / (2^5);
    c1 = 3424 / (2^12);
    c2 = 2413 / (2^7);
    c3 = 2392 / (2^7);
    E0 = E;
    E_ =real(((c1+c2*E0.^m1)./(1+c3*E0.^m1)).^m2);
    
end

