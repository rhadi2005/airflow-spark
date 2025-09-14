FROM python:3.11-bullseye
# default shell is sh
RUN apt-get update

RUN apt-get install -y unzip
RUN apt-get install -y --no-install-recommends openjdk-17-jdk
ENV JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
# RUN apt-get install -y --no-install-recommends openjdk-11-jdk
# ENV JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
ENV SPARK_HOME="/home/sparkuser/spark"
ENV PATH="${JAVA_HOME}:${SPARK_HOME}/bin:${SPARK_HOME}/sbin:${PATH}"
RUN mkdir -p ${SPARK_HOME}
WORKDIR ${SPARK_HOME}

# If it breaks in this step go to https://dlcdn.apache.org/spark/ and choose higher spark version instead
RUN curl https://dlcdn.apache.org/spark/spark-3.5.6/spark-3.5.6-bin-hadoop3-scala2.13.tgz -o spark-3.5.6-bin-hadoop3.tgz \
    && tar xvzf spark-3.5.6-bin-hadoop3.tgz --directory ${SPARK_HOME} --strip-components 1 \
    && rm -rf spark-3.5.6-bin-hadoop3.tgz
# Port master will be exposed
ENV SPARK_MASTER_PORT="7077"
# Name of master container and also counts as hostname
ENV SPARK_MASTER_HOST="spark-master"

# Install sbt using coursier (cs) to build jars (Comment these out if not needed to speed up image build)
# RUN curl -fL https://github.com/coursier/coursier/releases/latest/download/cs-x86_64-pc-linux.gz | gzip -d > cs && chmod +x cs
# ENV PATH="$PATH:/root/.local/share/coursier/bin"
# RUN export PATH="${JAVA_HOME}:${PATH}:/root/.local/share/coursier/bin" \
#     && ./cs setup

# COPY ./packages/tools/cs-x86_64-pc-linux.gz .
# RUN gzip -d cs-x86_64-pc-linux.gz \
#     && mv cs-x86_64-pc-linux cs \
#     && chmod +x cs 
# RUN export PATH="${JAVA_HOME}:${PATH}:/root/.local/share/coursier/bin" \
#     && ls -l cs \
#     && ./cs setup
# ENV PATH="$PATH:/root/.local/share/coursier/bin"

# RUN apt-get update \
#     && apt-get install -y apt-transport-https curl gnupg \
#     && echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list \
#     && echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee /etc/apt/sources.list.d/sbt_old.list \
#     && curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import \
#     && chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg 
# RUN apt-get update \
#     && apt-get install sbt

# RUN apt-get update \
#     && apt-get install -y unzip zip
# RUN curl -s "https://get.sdkman.io" | bash
# RUN sdk install sbt

# Download postgres jar and add it to spark jars
RUN wget -P ${SPARK_HOME}/jars/ https://jdbc.postgresql.org/download/postgresql-42.7.4.jar;

# Download aws jar and add it to spark jars
RUN wget -P ${SPARK_HOME}/jars/ https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.4/hadoop-aws-3.3.4.jar;
RUN wget -P ${SPARK_HOME}/jars/ https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.262/aws-java-sdk-bundle-1.12.262.jar;


RUN useradd -u 1000 -m -d /home/sparkuser sparkuser
ENV HOME="/home/sparkuser"
RUN chown -R 1000:1000 ${SPARK_HOME}
USER sparkuser

COPY ./spark-defaults.conf "${SPARK_HOME}/conf"

ENTRYPOINT ["/bin/bash"]





