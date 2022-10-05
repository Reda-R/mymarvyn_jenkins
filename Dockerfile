FROM jenkins/jenkins:lts
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
ENV CASC_JENKINS_CONFIG /var/jenkins_home/my_marvin.yml
COPY ./my_marvin.yml /var/jenkins_home/my_marvin.yml
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
COPY ./job_dsl.groovy /job_dsl.groovy
ENV USER_CHOCOLATEEN_PASSWORD=hugo_pwd
ENV USER_VAUGIE_G_PASSWORD=garance_pwd
ENV USER_I_DONT_KNOW_PASSWORD=jeremy_pwd
ENV USER_NASSO_PASSWORD=nassim_pwd

# USER root
# RUN apt-get update && apt-get install -y lsb-release
# RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  # https://download.docker.com/linux/debian/gpg
# RUN echo "deb [arch=$(dpkg --print-architecture) \
  # signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  # https://download.docker.com/linux/debian \
  # $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
# RUN apt-get update && apt-get install -y docker-ce-cli
# USER jenkins
# RUN jenkins-plugin-cli --plugins "blueocean:1.25.3 docker-workflow:1.28"
