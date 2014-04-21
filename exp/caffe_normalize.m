function im = caffe_normalize(net,im)

% this cannot be undone
im = imresize(im, net.normalization.size) ;

if isfloat(im)
  % float in matlab means [0 1] interval by default
  im = single(255*im) ;
else
  im = single(im) ;
end

% take mean out
im = im - net.normalization.meanImage ;

% premute as needed
im = permute(im(:,:,net.normalization.channelPerm), ...
  net.normalization.dimensionPerm) ;

