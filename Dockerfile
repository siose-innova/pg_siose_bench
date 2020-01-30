FROM labgeo/siose_2005
MAINTAINER Benito Zaragozi <benizar@gmail.com>

#TODO: UPDATE CERTIFICATES
#Instructions here -> https://www.postgresql.org/about/news/1432/


# packages needed for compilation
RUN apt-get update && apt-get install -y --force-yes \
	build-essential \
	checkinstall \
	ca-certificates \ 
	git \
	postgresql-server-dev-9.5


# download and compile pg_siose_bench
#RUN git clone https://github.com/labgeo/pg_siose_bench.git &&\
#	cd pg_siose_bench &&\ 
#	make &&\ 
#	make install &&\
#	cd .. &&\
#	rm -Rf pg_siose_bench

COPY ./doc/ ./doc/
COPY ./data/ ./data/
COPY ./sql/ ./sql/
COPY ./Makefile ./Makefile
COPY ./pg_siose_bench.control ./pg_siose_bench.control
COPY ./META.json ./META.json


# install from the same repo
RUN make &&\ 
	make install

# clean packages
RUN apt-get remove -y build-essential checkinstall ca-certificates git postgresql-server-dev-9.5
