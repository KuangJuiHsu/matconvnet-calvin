function net = cnn_imagenet_init_bnorm(varargin)
% CNN_IMAGENET_INIT_BNORM  Baseline CNN model with batch normalization

opts.scale = 1 ;
opts.initBias = 0.1 ;
opts.weightDecay = 1 ;
opts = vl_argparse(opts, varargin) ;

net.layers = {} ;

% Block 1
net.layers{end+1} = struct('type', 'conv', 'name', 'conv1', ...
                           'filters', 0.01/opts.scale * randn(11, 11, 3, 96, 'single'), ...
                           'biases', [], ...
                           'stride', 4, ...
                           'pad', 0, ...
                           'filtersLearningRate', 1, ...
                           'biasesLearningRate', 2, ...
                           'filtersWeightDecay', opts.weightDecay, ...
                           'biasesWeightDecay', 0) ;
net.layers{end+1} = struct('type', 'bnorm', 'name', 'bn1', ...
                           'filters', ones(96, 1, 'single'), ...
                           'biases', zeros(96, 1, 'single'), ...
                           'biasesLearningRate', 2, ...
                           'filtersLearningRate', 1,...
                           'filtersWeightDecay', 0, ...
                           'biasesWeightDecay', 0) ;
net.layers{end+1} = struct('type', 'relu', 'name', 'relu1') ;
net.layers{end+1} = struct('type', 'pool', 'name', 'pool1', ...
                           'method', 'max', ...
                           'pool', [3 3], ...
                           'stride', 2, ...
                           'pad', 0) ;

% Block 2
net.layers{end+1} = struct('type', 'conv', 'name', 'conv2', ...
                           'filters', 0.01/opts.scale * randn(5, 5, 48, 256, 'single'), ...
                           'biases', [], ...
                           'stride', 1, ...
                           'pad', 2, ...
                           'filtersLearningRate', 1, ...
                           'biasesLearningRate', 2, ...
                           'filtersWeightDecay', opts.weightDecay, ...
                           'biasesWeightDecay', 0) ;
net.layers{end+1} = struct('type', 'bnorm', 'name', 'bn2', ...
                           'filters', ones(256, 1, 'single'), ...
                           'biases', opts.initBias*ones(256, 1, 'single'), ...
                           'biasesLearningRate', 2, ...
                           'filtersLearningRate', 1,...
                           'filtersWeightDecay', 0, ...
                           'biasesWeightDecay', 0) ;
net.layers{end+1} = struct('type', 'relu', 'name', 'relu2') ;
net.layers{end+1} = struct('type', 'pool', 'name', 'pool2', ...
                           'method', 'max', ...
                           'pool', [3 3], ...
                           'stride', 2, ...
                           'pad', 0) ;

% Block 3
net.layers{end+1} = struct('type', 'conv', 'name', 'conv3', ...
                           'filters', 0.01/opts.scale * randn(3,3,256,384,'single'), ...
                           'biases', [], ...
                           'stride', 1, ...
                           'pad', 1, ...
                           'filtersLearningRate', 1, ...
                           'biasesLearningRate', 2, ...
                           'filtersWeightDecay', opts.weightDecay, ...
                           'biasesWeightDecay', 0) ;
net.layers{end+1} = struct('type', 'bnorm', 'name', 'bn3', ...
                           'filters', ones(384, 1, 'single'), ...
                           'biases', opts.initBias*ones(384, 1, 'single'), ...
                           'biasesLearningRate', 2, ...
                           'filtersLearningRate', 1,...
                           'filtersWeightDecay', 0, ...
                           'biasesWeightDecay', 0) ;
net.layers{end+1} = struct('type', 'relu', 'name', 'relu3') ;

% Block 4
net.layers{end+1} = struct('type', 'conv', 'name', 'conv4', ...
                           'filters', 0.01/opts.scale * randn(3,3,192,384,'single'), ...
                           'biases', [], ...
                           'stride', 1, ...
                           'pad', 1, ...
                           'filtersLearningRate', 1, ...
                           'biasesLearningRate', 2, ...
                           'filtersWeightDecay', opts.weightDecay, ...
                           'biasesWeightDecay', 0) ;
net.layers{end+1} = struct('type', 'bnorm', 'name', 'bn4', ...
                           'filters', ones(384, 1, 'single'), ...
                           'biases', opts.initBias*ones(384, 1, 'single'), ...
                           'biasesLearningRate', 2, ...
                           'filtersLearningRate', 1,...
                           'filtersWeightDecay', 0, ...
                           'biasesWeightDecay', 0) ;
net.layers{end+1} = struct('type', 'relu', 'name', 'relu4') ;

% Block 5
net.layers{end+1} = struct('type', 'conv', 'name', 'conv5', ...
                           'filters', 0.01/opts.scale * randn(3,3,192,256,'single'), ...
                           'biases', [], ...
                           'stride', 1, ...
                           'pad', 1, ...
                           'filtersLearningRate', 1, ...
                           'biasesLearningRate', 2, ...
                           'filtersWeightDecay', opts.weightDecay, ...
                           'biasesWeightDecay', 0) ;
net.layers{end+1} = struct('type', 'bnorm', 'name', 'bn5', ...
                           'filters', ones(256, 1, 'single'), ...
                           'biases', opts.initBias*ones(256, 1, 'single'), ...
                           'biasesLearningRate', 2, ...
                           'filtersLearningRate', 1,...
                           'filtersWeightDecay', 0, ...
                           'biasesWeightDecay', 0) ;
net.layers{end+1} = struct('type', 'relu', 'name', 'relu5') ;
net.layers{end+1} = struct('type', 'pool', 'name', 'pool5', ...
                           'method', 'max', ...
                           'pool', [3 3], ...
                           'stride', 2, ...
                           'pad', 0) ;

% Block 6
net.layers{end+1} = struct('type', 'conv', 'name', 'fc6', ...
                           'filters', 0.01/opts.scale * randn(6,6,256,4096,'single'),...
                           'biases', [], ...
                           'stride', 1, ...
                           'pad', 0, ...
                           'filtersLearningRate', 1, ...
                           'biasesLearningRate', 2, ...
                           'filtersWeightDecay', opts.weightDecay, ...
                           'biasesWeightDecay', 0) ;
net.layers{end+1} = struct('type', 'bnorm', 'name', 'bn6', ...
                           'filters', ones(4096, 1, 'single'), ...
                           'biases', opts.initBias*ones(4096, 1, 'single'), ...
                           'biasesLearningRate', 2, ...
                           'filtersLearningRate', 1,...
                           'filtersWeightDecay', 0, ...
                           'biasesWeightDecay', 0) ;
net.layers{end+1} = struct('type', 'relu', 'name', 'relu6') ;

% Block 7
net.layers{end+1} = struct('type', 'conv', 'name', 'fc7', ...
                           'filters', 0.01/opts.scale * randn(1,1,4096,4096,'single'),...
                           'biases', [], ...
                           'stride', 1, ...
                           'pad', 0, ...
                           'filtersLearningRate', 1, ...
                           'biasesLearningRate', 2, ...
                           'filtersWeightDecay', opts.weightDecay, ...
                           'biasesWeightDecay', 0) ;
net.layers{end+1} = struct('type', 'bnorm', 'name', 'bn7', ...
                           'filters', ones(4096, 1, 'single'), ...
                           'biases', opts.initBias*ones(4096, 1, 'single'), ...
                           'biasesLearningRate', 2, ...
                           'filtersLearningRate', 1,...
                           'filtersWeightDecay', 0, ...
                           'biasesWeightDecay', 0) ;
net.layers{end+1} = struct('type', 'relu', 'name', 'relu7') ;

% Block 8
net.layers{end+1} = struct('type', 'conv', 'name', 'fc8', ...
                           'filters', 0.01/opts.scale * randn(1,1,4096,1000,'single'), ...
                           'biases', zeros(1, 1000, 'single'), ...
                           'stride', 1, ...
                           'pad', 0, ...
                           'filtersLearningRate', 1, ...
                           'biasesLearningRate', 2, ...
                           'filtersWeightDecay', opts.weightDecay, ...
                           'biasesWeightDecay', 0) ;

% Block 9
net.layers{end+1} = struct('type', 'softmaxloss', 'name', 'loss') ;

% Other details
net.normalization.imageSize = [227, 227, 3] ;
net.normalization.interpolation = 'bicubic' ;
net.normalization.border = 256 - net.normalization.imageSize(1:2) ;
net.normalization.averageImage = [] ;
net.normalization.keepAspect = true ;