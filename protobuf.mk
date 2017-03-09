local_src = /usr/local/src

protobuf_src = /usr/local/src/protobuf
protobuf_v = v2.5.0

gtest_src = /usr/local/src/googletest
gtest_v = release-1.5.0

clean_obj = $(protobuf_src) $(gtest_src)

protobuf: gtest
	if [ -d $(protobuf_src) ]; then rm -rf $(protobuf_src) ; fi
	cd $(local_src); git clone https://github.com/google/protobuf.git
	cd $(protobuf_src); git checkout $(protobuf_v) 
	mv $(gtest_src) $(protobuf_src)/gtest
	cd $(protobuf_src); sh autogen.sh; ./configure; make; make check; make install

gtest:
	if [ -d $(gtest_src) ]; then rm -rf $(gtest_src) ; fi
	cd $(local_src); git clone https://github.com/google/googletest.git
	cd $(gtest_src); git checkout $(gtest_v)

clean:
	rm -rf $(clean_obj)
