#########################################################################
#    Dockerfile for FLT3_ITD_ext                                         #
#    registry.gitlab.com/roysomak4/genbio_containers/flt3-itd-ext        #
#########################################################################

# source alpine image
FROM alpine:3.15 AS builder


ENV BWA_VER=2.2.1 \
    SAMTOOLS_VER=1.15 \
    SUMACLUST_VER=1.0.36 \
    BBMAP_VER=38.96 \
    FGBIO_VER=2.0.0 \
    PICARD_VER=2.27.1 \
    BEDTOOLS_VER=2.30.0

RUN apk update && apk add --no-cache --virtual build_deps \
        wget \
        gcompat \
        ca-certificates \
        autoconf \
        automake \
	musl-dev \
	zlib-dev \
	libcurl \
	ncurses-dev \
	make \
	gcc \
	g++ \
	bzip2-dev \
	xz-dev \
        libressl-dev \
        python3 && \
        # create python symblink for bedtools script to help compile binary
        ln -s /usr/bin/python3.9 /usr/bin/python && \
        # download bwa2-mem binaries
        wget https://github.com/bwa-mem2/bwa-mem2/releases/download/v${BWA_VER}/bwa-mem2-${BWA_VER}_x64-linux.tar.bz2 && \
        tar -jxvf bwa-mem2-${BWA_VER}_x64-linux.tar.bz2 && \
        mv bwa-mem2-${BWA_VER}_x64-linux/bwa-mem2* /usr/local/bin/ && \
        # install samtools
        wget https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VER}/samtools-${SAMTOOLS_VER}.tar.bz2 -O samtools.tar.bz2 && \
        tar -jxvf samtools.tar.bz2 && \
        mv samtools-${SAMTOOLS_VER} samtools && \
        cd samtools && \
        # install samtools. Default install location /usr/local
        ./configure && \
        make -j 8 && make install && \
        cd htslib-1.15 && \
        ./configure && \
        make -j 8 && make install && \
        cd ../../ && \
        # install bedtools
        wget https://github.com/arq5x/bedtools2/releases/download/v${BEDTOOLS_VER}/bedtools.static.binary && \
        mv bedtools.static.binary bedtools && \
        chmod +x bedtools && \
        mv bedtools /usr/local/bin/ && \
        # install sumaclust
        wget https://git.metabarcoding.org/obitools/sumaclust/uploads/f17c763f8d727621fc92555d7bb52e6f/sumaclust_v${SUMACLUST_VER}.tar.gz && \
        tar -zxvf sumaclust_v${SUMACLUST_VER}.tar.gz && \
        cd sumaclust_v${SUMACLUST_VER} && \
        make -C sumalibs -j 10 install && make install && \
        cd ../ && \
        # install bbduk
        wget --no-check-certificate https://sourceforge.net/projects/bbmap/files/BBMap_${BBMAP_VER}.tar.gz/download -O bbmap.tar.gz && \
        tar -zxvf bbmap.tar.gz && \
        mv bbmap /usr/local/bin/ && \
        # install fgbio
        wget https://github.com/fulcrumgenomics/fgbio/releases/download/${FGBIO_VER}/fgbio-${FGBIO_VER}.jar -o fgbio.jar && \
        mv fgbio.jar /usr/local/bin/ && \
        # install picard
        wget https://github.com/broadinstitute/picard/releases/download/${PICARD_VER}/picard.jar -O /usr/local/bin/picard.jar

# Create final image
FROM alpine:3.15

# add label
LABEL maintainer="Somak Roy<roysomak4@gmail.com>" \
        function="Docker image for FLT3_ITD_ext using alpine base image"

RUN apk update && apk add --no-cache openjdk11-jre-headless perl xz libbz2 gcompat libcurl ncurses libstdc++ libgcc libgomp && \
        # clean up install mess
        rm -rf /var/cache/apk/*
# work in progress. The output from sumaclust is being sent to stdout instead of file.
COPY --from=builder /usr/local /usr/local
COPY FLT3_ITD_ext.pl /usr/local/bin/
