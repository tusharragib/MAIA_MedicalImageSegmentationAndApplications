function [p] = estep(cluster_number, data,alpha, mean, covariance)
 for k = 1:cluster_number
        multi_z(:, k) = multi_pdf_func(data, mean(k,:), covariance(:,:,k));
        p(:,k)=double(alpha(k)*multi_z(:, k)); 
 end
end
    

