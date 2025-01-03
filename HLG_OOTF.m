function [E_, F_D] = HLG_OOTF(E, LW)
    
% E is the linear signal.
% LW is the peak luminance of a display. 
% E_ is the displayed linear signal, in cd/m2.
% FD is the luminance of displayed linear signal.

    % 计算归一化场景亮度 Y_s
    Y_s = 0.2627 *E(:,:,1) + 0.6780 *E(:,:,2) + 0.0593 *E(:,:,3);
    gamma=1.2;
    if LW>=1000
        gamma=1.2+0.42*log10(LW/1000);
    end
    alpha=LW;
    E_=zeros(size(E));
    E_(:,:,1) = alpha * Y_s.^(gamma - 1) .*E(:,:,1);
    E_(:,:,2) = alpha * Y_s.^(gamma - 1) .* E(:,:,2);
    E_(:,:,3) = alpha * Y_s.^(gamma - 1) .* E(:,:,3);
    F_D = alpha * Y_s.^(gamma-1).*E;

end

