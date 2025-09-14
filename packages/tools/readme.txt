
# Install sbt using coursier (cs) to build jars 
curl -fL https://github.com/coursier/coursier/releases/latest/download/cs-x86_64-pc-linux.gz -o cs-x86_64-pc-linux.gz


# curl -s "https://get.sdkman.io"
wget --verbose -O sdkman.sh https://get.sdkman.io
chmod +x sdkman.sh

export SPARK_VERSION=3.5.6 
export HADOOP_VERSION=3
export SPARK_FILENAME="spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz"
export SPARK_DOWNLOAD_URL="https://dlcdn.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" 

wget --verbose -O ${SPARK_FILENAME} ${SPARK_DOWNLOAD_URL}

# curl https://dlcdn.apache.org/spark/spark-3.5.6/spark-3.5.6-bin-hadoop3.tgz -o spark-3.5.6-bin-hadoop3.tgz
