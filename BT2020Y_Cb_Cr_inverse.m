function RGB= BT2020Y_Cb_Cr_inverse(Y_CB_CR_)

    RGB_=zeros(size(Y_CB_CR_));
    RGB_(:,:,3)=Y_CB_CR_(:,:,1)+1.8814*Y_CB_CR_(:,:,2);
    RGB_(:,:,1)=Y_CB_CR_(:,:,1)+1.4746*Y_CB_CR_(:,:,3);
    RGB_(:,:,2)=(Y_CB_CR_(:,:,1)-0.2627*RGB_(:,:,1)-0.0593*RGB_(:,:,3))/0.6780;
    RGB=PQ_EOTF(RGB_);
end

