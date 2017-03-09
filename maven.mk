mvn-url = http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
mvn-src = ~/maven
mvn-obj = ~/maven.tar.gz

maven:
	curl -fSL $(mvn-url) -o $(mvn-obj)
	if [ -d $(mvn-src) ]; then rm -rf $(mvn-src); fi
	mkdir -p $(mvn-src); tar xzC $(mvn-src) --strip-components=1 -f $(mvn-obj)
	rm -rf $(mvn-obj)
