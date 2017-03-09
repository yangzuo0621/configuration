hadoop-url = http://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-2.7.3/hadoop-2.7.3-src.tar.gz
hadoop-src = ~/hadoop-2.7.3-src
hadoop-obj = ~/hadoop.tar.gz

hadoop:
	if [ -d $(hadoop-src) ]; then rm -rf $(hadoop-src); fi; mkdir $(hadoop-src)
	curl -fSL $(hadoop-url) -o $(hadoop-obj)
	tar xzC $(hadoop-src) --strip-components=1 -f $(hadoop-obj)
	cd $(hadoop-src); mvn package -Pdist,native -DskipTests -Dtar
