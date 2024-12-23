function RGB= BT2020Y_Cb_Cr_inverse(Y_CB_CR_)

    RGB_=zeros(size(Y_CB_CR_));
    RGB_(:,:,3)=Y_CB_CR_(:,:,1)+1.8814*Y_CB_CR_(:,:,2);
    RGB_(:,:,1)=Y_CB_CR_(:,:,1)+1.4746*Y_CB_CR_(:,:,3);
    RGB_(:,:,2)=Y_CB_CR_(:,:,1)-0.9663*Y_CB_CR_(:,:,3)-0.1881*Y_CB_CR_(:,:,2);

    RGB=PQ_EOTF(RGB_);
end

