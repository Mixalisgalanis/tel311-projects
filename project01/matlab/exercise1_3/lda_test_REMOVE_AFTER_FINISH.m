S=[0.3 1.5; 1.5 9.0]; %Covariance
m1=[-1 0]; m2=[1 0]; %Means
N=200; %Num Samples from each class
X=[mvnrnd(m1,S,N);mvnrnd(m2,S,N)]; %Data
Labs=[ones(1,N), 2*ones(1,N)]; %Labels
figure(1)
plot(X(Labs==1,1),X(Labs==1,2),'r.',X(Labs==2,1),X(Labs==2,2),'bo')

mv_est(:,1)=mean(X(Labs==1,:)); %Estimate Mean for class1
mv_est(:,2)=mean(X(Labs==2,:)); %Estimate Mean for class2
%Within-class Scatter matrix S_w
Sw=zeros;
for i=1:2 %For all classes
P(i)=sum(Labs==i)/N;
disp(i)
disp(X(Labs==i,:))
covy = cov(X(Labs==i,:));
Sw=Sw+P(i)*covy;
end
%Projection
w=inv(Sw)*(mv_est(:,1)-mv_est(:,2));
Wnorm = w/norm(w); %Vector of unit norm

%Projected features
t1=w'*X(Labs==1,:)';
t2=w'*X(Labs==2,:)';
X_proj1=[t1;t1].*((w/(w'*w))*ones(1,length(t1)));
X_proj2=[t2;t2].*((w/(w'*w))*ones(1,length(t2)));

hold on
plot(X_proj1(1,:),X_proj1(2,:),'g.',X_proj2(1,:),X_proj2(2,:),'co')