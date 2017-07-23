lib=lib-git-ignore
plugin=plugin
REVEAL_JS_URL="https://github.com/hakimel/reveal.js.git"
REVEAL_JS_DIR=reveal.js
toc_progress_url="https://github.com/e-gor/Reveal.js-TOC-Progress.git"
toc_progress=Reveal.js-TOC-Progress
toc_progress_plugin=toc-progress

SRC_DIR=src
plugin_dir=${SRC_DIR}/plugin
LIB_DIR=${SRC_DIR}/${lib}
JQUERY_FILE=jquery-2.2.3.min.js
JQUERY_SITE= https://code.jquery.com

decktape=decktape-1.0.0

PWD=$(shell pwd)

all:   plugin lib pulls


plugin: 
	(mkdir -p ${plugin_dir})

lib:
	mkdir -p ${LIB_DIR}

pulls:  pull-reveal-js pull-toc-progress pull-jquery

clean-lib:
	rm -rf ${LIB_DIR}

pull-reveal-js:
	@echo "pulling reveal js"
ifeq ($(wildcard ${LIB_DIR}/reveal.js),)
	(mkdir -p ${LIB_DIR}; git clone ${REVEAL_JS_URL} ${LIB_DIR}/reveal.js)
else
	@echo "Reveal.js support code already present"
endif


pull-toc-progress:
	@echo "pulling  toc-progress"
ifeq ($(wildcard ${LIB_DIR}/${toc_progress}),)
	(mkdir -p ${LIB_DIR}; git clone ${toc_progress_url} ${LIB_DIR}/${toc_progress}; cd ${plugin_dir}; ln -s ../${lib}/${toc_progress}/plugin/${toc_progress_plugin}; cd -)
else
	@echo "${toc_progress} support code already present"
endif


pull-jquery:
	@echo "pulling jquery.js"
ifeq ($(wildcard ${LIB_DIR}/${JQUERY_FILE}),)
	(cd ${LIB_DIR}; wget ${JQUERY_SITE}/${JQUERY_FILE})
else
	@echo "${JQUERY_FILE} support code already present"
endif

pull-decktape:
	@echo "pulling decktape"
ifeq ($(wildcard ${LIB_DIR}/${DECKTAPE_FILE}),)
	(cd ${LIB_DIR}; wget ${DECKTAPE_SITE}/${DECKTAPE_FILE})
else
	@echo "${DECKTAPE_FILE} support code already present"
endif

pull-phantomjs:
	curl -L https://github.com/astefanutti/decktape/releases/download/v1.0.0/phantomjs-linux-x86-64 -o ${LIB_DIR}/phantomjs

# see https://github.com/astefanutti/decktape
pdf:
	@echo "converting to pdf"
	${LIB_DIR}/phantomjs ${LIB_DIR}/${decktape}/decktape.js reveal -s \
1280x760 src/index.html src/index.pdf

