function RndObj = find_round_objects(boundary,area)
 delta_sq = diff(boundary).^2;    
  perimeter = sum(sqrt(sum(delta_sq,2)));
  RndObj = 4*pi*area/perimeter^2;
end
    