% a is home
home(a).
% location of packages
loc(p1,a). loc(p2,a). loc(p3,a). loc(p4,a). 
% location of truck
loc(truck,a).  
% orders
order(c1,[p1,p2]). order(c2,[p3,p4]).
% location of customers
loc(c1,b). loc(c2,c).
thinks(andrew,loc(truck,a)).
