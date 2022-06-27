function [multi_z] = multi_pdf_func(datum, mean, sigma)
    multi_z = mvnpdf(datum, mean, sigma);
end

