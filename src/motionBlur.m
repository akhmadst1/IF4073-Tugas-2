function imageMotionBlur = motionBlur(image, len, theta)
    % Melakukan motion blur
    PSF = fspecial('motion', len, theta);
    imageMotionBlur = imfilter(image, PSF, 'conv', 'circular');
end
