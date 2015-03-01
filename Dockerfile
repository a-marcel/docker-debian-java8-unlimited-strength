FROM debian:wheezy

RUN \
  apt-get update && \
  apt-get install -y wget unzip && \
  wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u31-b13/jre-8u31-linux-x64.tar.gz && \
  tar xzf jre-8u31-linux-x64.tar.gz && \
  wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jce/7/UnlimitedJCEPolicyJDK7.zip && \
  unzip UnlimitedJCEPolicyJDK7.zip && \
  mkdir /usr/lib/jvm/ && \
  mv jre1.8.0_31 /usr/lib/jvm/jre1.8.0_31 && \
  ln -snf jre1.8.0_31 usr/lib/jvm/java-8-oracle && \
  rm jre-8u31-linux-x64.tar.gz && \
  mv UnlimitedJCEPolicy/US_export_policy.jar usr/lib/jvm/java-8-oracle/lib/security/US_export_policy.jar && \
  mv UnlimitedJCEPolicy/local_policy.jar usr/lib/jvm/java-8-oracle/lib/security/local_policy.jar && \
  rm -Rf UnlimitedJCEPolicy && \
  rm -Rf UnlimitedJCEPolicyJDK7.zip

RUN echo "JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> etc/environment

RUN update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-8-oracle/bin/java 1
