function P = HermiteSpline(E1, KS, maxLum)
    % Hermite样条插值
    T = (E1 - KS) / (1 - KS);
    P = (2*T.^3 - 3*T.^2 + 1)*KS + ...
        (T.^3 - 2*T.^2 + T)*(1 - KS) + ...
        (-2*T.^3 + 3*T.^2)*maxLum;
end