function removeLayer(obj, name)
%REMOVELAYER Remove a layer from the network
%  REMOVELAYER(OBJ, NAME) removes the layer NAME from the DagNN object
%  OBJ.

f = find(strcmp(name, {obj.layers.name})) ;
if isempty(f), error('There is no layer ''%s''.', name), end
layer = obj.layers(f) ;
obj.layers(f) = [] ;

for v = obj.getVarIndex(layer.inputs)
  obj.vars(v).fanout = obj.vars(v).fanout - 1 ;
end

for v = obj.getVarIndex(layer.outputs)
  obj.vars(v).fanin = obj.vars(v).fanin - 1 ;
end

for p = obj.getParamIndex(layer.params)
  obj.params(p).fanout = obj.params(p).fanout - 1 ;
end

obj.rebuild() ;