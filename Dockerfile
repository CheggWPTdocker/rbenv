FROM cheggwpt/alpine:3.5

RUN mkdir -p /app
WORKDIR /app

ENV PATH /usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH
ENV RBENV_ROOT /usr/local/rbenv
ENV RUBY_VERSION 2.2.3
ENV CONFIGURE_OPTS --disable-install-doc

RUN apk add --update --no-cache --virtual .ruby-builddeps \
	autoconf \
	bison \
	bzip2 \
	bzip2-dev \
	ca-certificates \
	coreutils \
	gcc \
	gdbm-dev \
	glib-dev \
	imagemagick-dev \
	libc-dev \
	libffi-dev \
	libxml2-dev \
	libxslt-dev \
	linux-headers \
	make \
	mariadb-dev \
	mysql-client \
	ncurses-dev \
	nodejs \
	openssl \
	openssl-dev \
	procps \
	qt-dev \
	qt-webkit \
	qt5-qtwebkit \
	readline-dev \
	ruby \
	tar \
	tzdata \
	xvfb \
	yaml-dev \
	zlib-dev \
	&& \
	update-ca-certificates && \
	rm -rf /var/cache/apk/*

RUN git clone --depth 1 git://github.com/sstephenson/rbenv.git ${RBENV_ROOT} \
&&  git clone --depth 1 https://github.com/sstephenson/ruby-build.git ${RBENV_ROOT}/plugins/ruby-build \
&&  git clone --depth 1 git://github.com/jf/rbenv-gemset.git ${RBENV_ROOT}/plugins/rbenv-gemset \
&&  ${RBENV_ROOT}/plugins/ruby-build/install.sh

RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh && \
	echo 'eval "$(rbenv init -)"' >> /root/.bashrc

RUN rbenv install $RUBY_VERSION \
	rbenv global $RUBY_VERSION && \
	bundle config git.allow_insecure true

RUN gem install bundler
