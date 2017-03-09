local_src = /usr/local/src

git_src = /usr/local/src/git
git_obj = /usr/local/src/git.tar.gz
python_src = /usr/local/src/python
python_obj = /usr/local/src/python.tgz
vim_src = /usr/local/src/vim
emacs_src = /usr/local/src/emacs
emacs_obj = /usr/local/src/emacs.tar.gz
perl_src = /usr/local/src/perl
perl_obj = /usr/local/src/perl.tar.gz

git_url = https://github.com/git/git/archive/v2.12.0.tar.gz
python_url = https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz
emacs_url = http://ftp.gnu.org/gnu/emacs/emacs-25.1.tar.gz
perl_url = http://www.cpan.org/src/5.0/perl-5.24.1.tar.gz

all_obj = $(git_src) $(git_obj) $(python_src) $(python_obj) $(vim_src) $(emacs_src) $(emacs_obj) $(perl_src) $(perl_obj)

all: init git python vim emacs

init:
	yum install -y gcc gcc-c++ autoconf automake zlib-devel curl-devel ncurses-devel perl-ExtUtils-MakeMaker

git: perl
	curl -fSL $(git_url) -o $(git_obj)
	if [ ! -d $(git_src) ]; then mkdir $(git_src) ; fi
	tar -xzC $(git_src) --strip-components=1 -f $(git_obj)
	cd $(git_src); make configure; ./configure; make install

perl:
	curl -fSL $(perl_url) -o $(perl_obj)
	if [ ! -d $(perl_src) ]; then mkdir $(perl_src) ; fi
	tar -xzC $(perl_src) --strip-components=1 -f $(perl_obj)
	cd $(perl_src); sh Configure -de; make; make test; make install

python:
	curl -fSL $(python_url) -o $(python_obj)
	if [ ! -d $(python_src) ]; then mkdir $(python_src) ; fi
	tar -xzC $(python_src) --strip-components=1 -f $(python_obj)
	cd $(python_src); ./configure --enable-optimizations; make; make install

vim:
	if [ -d $(vim_src) ]; then rm -rf $(vim_src) ; fi
	cd $(local_src); git clone https://github.com/vim/vim.git
	cd $(vim_src); ./configure --with-features=huge --enable-multibyte --enable-rubyinterp=yes --enable-pythoninterp=yes --enable-perlinterp=yes --enable-luainterp=yes --enable-gui=gtk2 --enable-cscope --prefix=/usr
	cd $(vim_src); make VIMRUNTIMEDIR=/usr/share/vim/vim80; make install

emacs:
	curl -fSL $(emacs_url) -o $(emacs_obj)
	if [ ! -d $(emacs_src) ]; them mkdir $(emacs_src); fi
	tar -xzC $(emacs_src) --strip-components=1 -f $(emacs_obj)
	cd $(emacs_src); ./configure; make; make install

docker:
	yum remove docker docker-common container-selinux docker-selinux docker-engine
	yum install -y yum-utils
	yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
	yum makecache fast
	version=`yum list docker-ce.x86_64 --showduplicates | grep docker | sort -r | awk '{print $$2}' | sed -n '1p'`; yum install -y docker-ce-$$version
	systemctl start docker

clean:
	rm -rf $(all_obj)
