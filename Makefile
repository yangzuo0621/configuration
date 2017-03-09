git_src = /usr/local/src/git
git_obj = /usr/local/src/git.tar.gz
python_src = /usr/local/src/python
python_obj = /usr/local/src/python.tgz

all: init git python
init:
	yum install -y gcc gcc-c++ autoconf automake zlib-devel curl-devel 
git: perl
	curl -fSL https://github.com/git/git/archive/v2.12.0.tar.gz -o $(git_obj)
	if [ ! -d $(git_src) ]; then mkdir $(git_src) ; fi
	tar -xzC $(git_src) --strip-components=1 -f $(git_obj)
	cd $(git_src); make configure; ./configure; make install
	rm -rf $(git_src) $(git_obj)

perl:
	yum install -y perl cpan

python:
	curl -fSL https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz -o $(python_obj)
	if [ ! -d $(python_src) ]; then mkdir $(python_src) ; fi
	tar -xzC $(python_src) --strip-components=1 -f $(python_obj)
	cd $(python_src); ./configure --enable-optimizations; make; make install
	rm -rf $(python_src) $(python_obj)
