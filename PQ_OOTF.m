function FD = PQ_OOTF(E)

    % E = {RS, GS, BS; YS; or IS} is the signal determined by scene light and scaled by camera exposure
    % The values E, RS, GS, BS, YS, IS are in the range [0:1]
    % E_prime is a non-linear representation of E
    % FD is the luminance of a displayed linear component (RD, GD, BD; YD; or ID)
    threshold = 0.0003024; 
    % 初始化 E' (G709 操作)
    E_prime = zeros(size(E));
    mask1 = E > threshold;
    E_prime(mask1) = 1.099 * (59.5208 * E(mask1)).^0.45 - 0.099;
    mask2 = ~mask1; 
    E_prime(mask2) = 267.84 * E(mask2);

    % G1886 操作 (FD)
    FD = 100 * E_prime.^2.4;
    
end
