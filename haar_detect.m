function outStruct = haar_detect(dataDir)
%% Perform detections on providen dataset using Haar detector

  detector  = vision.CascadeObjectDetector('signHaarDetector.xml');
  dataStore = imageDatastore(dataDir);
  imgsNum   = size(dataStore.Files, 1);
  % areaScale = 2;
  outStruct = [];

  for ii = 1:imgsNum
    readImg  = read(dataStore);
    bboxes   = step(detector, readImg);

    path2img = dataStore.Files(ii);
    path2img = path2img{1};
    if ispc, path2img = split(path2img, '\');
    else, path2img = split(path2img, '/');
    end
    path2img = string(path2img{end});

    outSign.Image = path2img;
    outSign.BoundingBox = [];

    % imgSize = size(readImg);
    for b=1:size(bboxes,1)
      bbparam = bboxes(b, :);
      x = bbparam(1);
      y = bbparam(2);
      w = bbparam(3);
      h = bbparam(4);

      % @TODO
      % x1 = max([1,x-w*areaScale]);
      % y1 = max([1,y-h*areaScale]);
      % x2 = min([imgSize(2),x+w*areaScale]);
      % y2 = min([imgSize(1),y+h*areaScale]);
      % window = readImg(y1:y2, x1:x2, :);
      approvalFlag = 1;

      if approvalFlag
        outSign.BoundingBox = [outSign.BoundingBox; x,y,w,h];
      end
    end
    outStruct = [outStruct; outSign];

  end
end