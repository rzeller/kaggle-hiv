% Author: saskra
% Date: 2013-10-23
% Place: BO, Germany
%
% This small script calculates the Matthews correlation coefficient, see http://en.wikipedia.org/wiki/Matthews_correlation_coefficient
% It is identical to the Phi coefficient, which is in turn identical to the Pearson product-moment correlation coefficient for two binary variables.

function mcc=calcMatthews(one,two)

conf_mat=confusionmat(one,two);
tp=conf_mat(1,1); % True positives
fp=conf_mat(1,2); % False positives
fn=conf_mat(2,1); % False negatives
tn=conf_mat(2,2); % True negatives
mcc=(tp*tn-fp*fn)/sqrt((tp+fp)*(tp+fn)*(tn+fp)*(tn+fn));

end
