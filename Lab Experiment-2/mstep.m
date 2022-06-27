function [mean, covariance] = mstep(cluster_number, data, w, alpha, mean, covariance)
    for i = 1:cluster_number
        N=sum(w(:,i));
        N(i)=N;
        alpha(i)= N(i)/length(data);
        mean(i,:)= (1/N(i)) * sum(w(:,i).*data);
        covariance(:,:,i) = (1 / N(i)) * ((data - mean(i,:))'*(w(:,i).*(data - mean(i,:))));
    end
end
    

