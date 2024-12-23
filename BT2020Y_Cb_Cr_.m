function  YCbCr= BT2020Y_Cb_Cr_(RGB)

% RGB is the linear values of camera channels

% Non-linear transform
% alpha=1.099;
% beta=0.018;
% RGB_=zeros(size(RGB));
% RGB_(RGB<beta)=4.5*RGB;
% RGB_(RGB>=beta)=alpha*RGB.^0.45-(alpha-1);
RGB_=PQ_OETF(RGB);

% Derivation of YCbCr signals
YCbCr=zeros(size(RGB));
YCbCr(:,:,1)=0.2627*RGB_(:,:,1)+0.6780*RGB_(:,:,2)+0.0593*RGB_(:,:,3);
YCbCr(:,:,2)=(RGB_(:,:,3)-YCbCr(:,:,1))/1.8814;
YCbCr(:,:,3)=(RGB_(:,:,1)-YCbCr(:,:,1))/1.4746;

end

