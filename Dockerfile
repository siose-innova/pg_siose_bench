FROM labgeo/siose_2005
MAINTAINER Benito Zaragozi <benizar@gmail.com>

#TODO: UPDATE CERTIFICATES and remove `--force-yes` from the installation.
#Instructions here -> https://www.postgresql.org/about/news/1432/


# packages needed for compilation
RUN apt-get update && apt-get install -y --force-yes \
	build-essential \
	checkinstall \
	ca-certificates \ 
	postgresql-server-dev-9.5

# Install the extension
WORKDIR /install-ext
COPY doc doc/
COPY data data/
COPY sql/ sql/
COPY Makefile Makefile
COPY pg_siose_bench.control pg_siose_bench.control
COPY ./META.json ./META.json

RUN make &&\ 
	make install

WORKDIR /
RUN rm -rf /install-ext

# Clean packages
RUN apt-get remove -y \
	build-essential \
	checkinstall \
	ca-certificates \
	postgresql-server-dev-9.5

# Setup the database and, maybe, automate any experiment.
ADD init-db.sh /docker-entrypoint-initdb.d/init-db.sh

