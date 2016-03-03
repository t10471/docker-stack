## stack a 
FROM t10471/base:latest

MAINTAINER t10471 <t104711202@gmail.com>

RUN wget -q -O- https://s3.amazonaws.com/download.fpcomplete.com/ubuntu/fpco.key | sudo apt-key add -
RUN echo 'deb http://download.fpcomplete.com/ubuntu/trusty stable main'|sudo tee /etc/apt/sources.list.d/fpco.list
RUN apt-get update && sudo apt-get install stack -y
RUN stack install cabal-install \
                  alex \
                  happy \
                  yesod-bin \ 
                  ghc-mod   \ 
                  html-conduit \ 
                  http-conduit \
                  hasktags \
                  codex    \
                  hscope   \
                  pointfree \
                  pointful  \
                  hoogle    \
                  haddock   \
                  pandoc    \
                  stylish-haskell \
                  --install-ghc

RUN echo 'export PATH=$PATH:"/root/.local/bin"' >> /root/.bashrc

RUN apt-get install -y libpcre3-dev 

ENV SCALA_TARBALL http://www.scala-lang.org/files/archive/scala-2.11.7.deb 
ENV SBT_TARBALL   http://dl.bintray.com/sbt/debian/sbt-0.13.11.deb 

WORKDIR /root/tmp
RUN apt-get update
RUN apt-get install -y --force-yes --no-install-recommends ctags libghc-pcre-light-dev libpcrecpp0 maven zip
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get install -y --force-yes oracle-java8-installer oracle-java8-set-default
RUN wget http://apt.typesafe.com/repo-deb-build-0002.deb
RUN dpkg -i repo-deb-build-0002.deb
RUN apt-get update
RUN apt-get install -y --force-yes libjansi-java
RUN wget $SCALA_TARBALL 
RUN wget $SBT_TARBALL
RUN dpkg -i scala-*.deb  sbt-*.deb
RUN rm -f *.deb
RUN apt-get clean

ENV SPARK_VER  1.6.0
ENV HADOOP_VER 2.6

RUN wget http://ftp.jaist.ac.jp/pub/apache/spark/spark-${SPARK_VER}/spark-${SPARK_VER}-bin-hadoop${HADOOP_VER}.tgz
RUN tar zxvf spark-${SPARK_VER}-bin-hadoop${HADOOP_VER}.tgz -C /usr/local/lib/
RUN ln -s /usr/local/lib/spark-${SPARK_VER}-bin-hadoop${HADOOP_VER} /usr/local/lib/spark
RUN echo 'export SPARK_HOME=/usr/local/lib/spark' >> /etc/profile.d/spark.sh
RUN echo 'export PATH=$SPARK_HOME/bin:$PATH' >> /etc/profile.d/spark.sh
RUN source /etc/profile



