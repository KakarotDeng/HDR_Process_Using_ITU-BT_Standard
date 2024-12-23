function FD = HLG_EOTF(E_prime, LW, LB)
    % HLG Reference EOTF Implementation
    % 
    % Inputs:
    %   E_prime - Non-linear input signal (range: [0, 1])
    %   LW      - Nominal peak luminance of the display in cd/m²
    %   LB      - Display luminance for black in cd/m²
    %   gamma   - System gamma (depends on LW, typically 1.2 for 1000 cd/m²)
    %
    % Output:
    %   FD - Displayed linear component luminance in cd/m²
    
    % Constants
    a=0.17883277;
    b=1-4*a;
    c = 0.5-a*log(4*a);
    gamma=1.2;
    if LW>=1000
        gamma=1.2+0.42*log10(LW/1000);
    end

    % Calculate β (user black level lift)
    beta = sqrt(3 * (LB / LW)^(1 / gamma));

    % Apply the max function to adjust the black level
    E_prime_adjusted = max(0, (1 - beta) * E_prime + beta);

    % Apply the inverse OETF
    E_linear = zeros(size(E_prime_adjusted));
    mask1 = (E_prime_adjusted <= 0.5); % Condition: 0 <= x <= 0.5
    mask2 = (E_prime_adjusted > 0.5);  % Condition: 0.5 < x <= 1

    E_linear(mask1) = (E_prime_adjusted(mask1).^2) / 3;
    E_linear(mask2) = (exp((E_prime_adjusted(mask2) - c) / a) + b) / 12;

    % Apply the OOTF (identity function in this case)
    FD = LW * E_linear; % Scale the linear signal by the display peak luminance
end