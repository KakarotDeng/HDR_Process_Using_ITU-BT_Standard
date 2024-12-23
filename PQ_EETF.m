function Target_Com = PQ_EETF(Ec,LB,LW,Lmin,Lmax)

% Ec is the corresponding mastering display black and white normalized PQ component.
% E_f is the PQ component after EETF transform.
    
    % E1 is the corresponding mastering display black and white normalized PQ component.
    E1=(Ec-PQ_OETF(LB))/(PQ_OETF(LW)-PQ_OETF(LB));
    
    % Mastering display black and white normalized PQ values
    minLum=(PQ_OETF(Lmin)-PQ_OETF(LB))/(PQ_OETF(LW)-PQ_OETF(LB));
    maxLum=(PQ_OETF(Lmax)-PQ_OETF(LB))/(PQ_OETF(LW)-PQ_OETF(LB));

     % The turning point KS
    KS = 1.5 * maxLum - 0.5;
    
    % EETF Transform
    E_0 = zeros(size(E1));
    E_0(E1 < KS) = E1(E1 < KS);  % 1:1映射
    E_0(E1 >= KS) = HermiteSpline(E1(E1 >= KS), KS, maxLum); % Spline映射
    E_f = E_0 + minLum * (1 - E_0).^4;

    %Visualize
    Vist=linspace(0,1,1000);
    Vist2=zeros(size(Vist));
    Vist2(Vist < KS) = Vist(Vist < KS);  % 1:1映射
    Vist2(Vist >= KS) = HermiteSpline(Vist(Vist >= KS), KS, maxLum); % Spline映射
    Vist3 =  Vist2 + minLum * (1 - Vist2).^4;
    figure(4);
    plot(Vist,Vist3)
    
    % Target display PQ values
    Target_Com=E_f*(PQ_OETF(LW)-PQ_OETF(LB))+PQ_OETF(LB);

end

