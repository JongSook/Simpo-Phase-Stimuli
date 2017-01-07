function pattern = mixGen(f, p, indices)
v = @(f, p, i) sin(2 * pi * f * (i / 120) + p);
pattern = [];
for ii = indices
  value = v(f, p, ii);
  
  if abs(value) < 9.5e-14 
    if ii == 0 
      res = v(f, p, 1) > 0;
    else
      
      res = v(f, p, ii - 1) < 0;
    end
  else 
    res = value > 0;
  end
  pattern = [pattern; res];
end
end