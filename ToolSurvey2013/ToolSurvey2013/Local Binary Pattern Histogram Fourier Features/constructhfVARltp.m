function [featurevectors1 featurevectors2 featurevectors3 featurevectors4 featurevectors5 featurevectors6 featurevectors7]=constructhf(inputvectors, map)
%construct rotation invariant features from uniform LBP histogram
%inputvectors: NxD array, N histograms of D bins each
%map: mapping struct from getmaphf
%
%EXAMPLE:
%I=imread('rice.png');
%I2=imrotate(I,90);
%mapping=getmaplbphf(8);
%h=lbp(I,1,8,mapping,'h');
%h=h/sum(h);
%histograms(1,:)=h;
%h=lbp(I2,1,8,mapping,'h');
%h=h/sum(h);
%histograms(2,:)=h;
%lbp_hf_features=constructhf(histograms,mapping);
%
%The two rows of lbp_hf_features now contain LBP
%histogram Fourier feature vectors of rice.png and
%its rotated version (with LBP radius 1 and 8 sampling
%points)


n=map.samples;
FVLEN=(n-1)*(floor(n/2)+1)+3;
featurevectors1=single(zeros(size(inputvectors,1),FVLEN));
II=inputvectors;
k=1;
for tp=1:2
    if tp==1
        inputvectors=II;
    else
        inputvectors=II(size(inputvectors,2)/2:size(inputvectors,2));
    end
    for j=1:length(map.orbits)
        b=inputvectors(:,map.orbits{j}+1);
        if(size(b,2) > 1)
            b=fft(b')';
            b=abs(b);
            b=b(:,1:(floor(size(b,2)/2)+1));
        end
        featurevectors1(:,k:k+size(b,2)-1)=single(b);
        k=k+size(b,2);
    end
end

k=1;
for tp=1:2
    if tp==1
        inputvectors=II;
    else
        inputvectors=II(size(inputvectors,2)/2:size(inputvectors,2));
    end
    for j=1:length(map.orbits)
        b=inputvectors(:,map.orbits{j}+1);
        if(size(b,2) > 1)
            b=dct(b')';
            b=abs(b);
            b=b(:,1:(floor(size(b,2)/2)+1));
        end
        featurevectors2(k:k+size(b,2)-1)=single(b);
        k=k+size(b,2);
    end
end

k=1;
for tp=1:2
    if tp==1
        inputvectors=II;
    else
        inputvectors=II(size(inputvectors,2)/2:size(inputvectors,2));
    end
    for j=1:length(map.orbits)
        b=inputvectors(:,map.orbits{j}+1);
        if(size(b,2) > 1)
            [b,cd] = dwt(b,'db4','mode','sym');
            b=fft(b')';
            b=abs(b);
            b=b(:,1:(floor(size(b,2)/2)+1));
        end
        featurevectors3(k:k+size(b,2)-1)=single(b);
        k=k+size(b,2);
    end
end

k=1;
for tp=1:2
    if tp==1
        inputvectors=II;
    else
        inputvectors=II(size(inputvectors,2)/2:size(inputvectors,2));
    end
    for j=1:length(map.orbits)
        b=inputvectors(:,map.orbits{j}+1);
        if(size(b,2) > 1)
            [b,cd] = dwt(b,'db4','mode','sym');
            b=dct(b')';
            b=abs(b);
            b=b(:,1:(floor(size(b,2)/2)+1));
        end
        featurevectors4(k:k+size(b,2)-1)=single(b);
        k=k+size(b,2);
    end
end

k=1;
for tp=1:2
    if tp==1
        inputvectors=II;
    else
        inputvectors=II(size(inputvectors,2)/2:size(inputvectors,2));
    end
    for j=1:length(map.orbits)
        b=inputvectors(:,map.orbits{j}+1);
        if(size(b,2) > 1)
            [b,cd] = dwt(b,'db4','mode','sym');
            b=fft(b')';
            b=abs(b);
        end
        featurevectors5(k:k+size(b,2)-1)=single(b);
        k=k+size(b,2);
    end
end

k=1;
for tp=1:2
    if tp==1
        inputvectors=II;
    else
        inputvectors=II(size(inputvectors,2)/2:size(inputvectors,2));
    end
    for j=1:length(map.orbits)
        b=inputvectors(:,map.orbits{j}+1);
        if(size(b,2) > 1)
            [b,cd] = dwt(b,'db4','mode','sym');
            b=dct(b')';
            b=abs(b);
        end
        featurevectors6(k:k+size(b,2)-1)=single(b);
        k=k+size(b,2);
    end
end

k=1;
for tp=1:2
    if tp==1
        inputvectors=II;
    else
        inputvectors=II(size(inputvectors,2)/2:size(inputvectors,2));
    end
    for j=1:length(map.orbits)
        b=inputvectors(:,map.orbits{j}+1);
        featurevectors7(k:k+size(b,2)-1)=single(b);
        k=k+size(b,2);
    end
end


