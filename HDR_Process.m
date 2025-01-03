clc

Input_hdr =hdrimread('D:\hdrs\hdr_wb_test\Lightbox_Table.hdr');

% PQ: Camera-(OOTF-EOTF^-1)[OETF]-EOTF-Display %
% HLG: Camera-OETF-(OETF^-1-OOTF)[EOTF]-Display %
% For Tone Mapping task, PQ source is adapted to the display by EETF
% For Tone Mapping task, HLG source is adapted to the display by OOTF

Signal_Type = 'PQ'; %'PQ' or 'HLG'

%% Linear HDR to NonLinear HDR
switch Signal_Type
    case 'PQ'
        Real_signal = Input_hdr; % The real value of scene
        nonlinear_hdr = PQ_OETF(Real_signal);
    case 'HLG'
        nonlinear_hdr = HLG_OETF(Input_hdr);
end

%% Tone Mapping Pipeline
% The key is calculating the EETF or OOTF  to adapt to the display
switch Signal_Type
    case 'PQ'
        Lmin=1/10000;
        Lmax=2000/10000;
        LB=min(Input_hdr(:));
        LW=max(Input_hdr(:));
        ColorSpace='YRGB';
        
        switch ColorSpace
            case 'YRGB'
                Y1=0.2627 * Input_hdr(:,:,1) + 0.6780 * Input_hdr(:,:,2) + 0.0593 * Input_hdr(:,:,3);
                Y2=PQ_EOTF(PQ_EETF(PQ_OETF(Y1),LB,LW,Lmin,Lmax));
                max(Y2(:))
                Corrected_hdr=Input_hdr.*(Y2./Y1);
                TMed_Img=PQ_OETF(Corrected_hdr);
            case 'R_G_B_'
                TMed_Img=PQ_EETF(nonlinear_hdr,LB,LW,Lmin,Lmax);
            case 'Y_Cb_Cr_'
                Y_Cb_Cr_=BT2020Y_Cb_Cr_(Input_hdr);
                Y1=Y_Cb_Cr_(:,:,1);
                Y2=PQ_EETF(Y1,LB,LW,Lmin,Lmax);
                core=min(Y2./Y1,Y1./Y2);
                Y_Cb_Cr_(:,:,1)=Y2;
                Y_Cb_Cr_(:,:,2:3)=core.*Y_Cb_Cr_(:,:,2:3);
                TMed_Img=PQ_OETF(BT2020Y_Cb_Cr_inverse(Y_Cb_Cr_));
        end
        
    case 'HLG'
        LW=1000;
        LB=0.01;

        TMed_Img=HLG_OOTF(HLG_EOTF(nonlinear_hdr,LW,LB)/LW,LW)/LW;
        %TMed_Img=HLG_EOTF(nonlinear_hdr,LW,LB)/LW;
        TMed_Img=HLG_OETF(TMed_Img);
        
end

% Save the image
% TMed_Img=uint16(65535*TMed_Img);
% imwrite(TMed_Img, 'E:\testimg\lightbox_2000.tiff')


%% Visualize

subplot(2, 2, 1); % 1 row, 3 columns, position 1
imshow(Input_hdr);
title('Linear HDR');

subplot(2, 2, 2); % 1 row, 3 columns, position 2
imshow(nonlinear_hdr);
title('Nonlinear HDR');

subplot(2, 2, 3); % 1 row, 3 columns, position 3
imshow(TMed_Img);
title('Image on the Target Display');

