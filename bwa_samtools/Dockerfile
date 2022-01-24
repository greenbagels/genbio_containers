# BWA and Samtools app
# Image: registry.gitlab.com/roysomak4/genbio_containers/bwa-samtools

FROM registry.gitlab.com/roysomak4/genbio_containers/builder:c-cpp-v1 AS builder

USER bioseq
WORKDIR /home/bioseq

ENV BWA_VER=2.2.1 \
	SAMTOOLS_VER=1.13

# install bwa mem2 binaries
RUN wget "https://github.com/bwa-mem2/bwa-mem2/releases/download/v${BWA_VER}/bwa-mem2-${BWA_VER}_x64-linux.tar.bz2" && \
	tar -vxjf bwa-mem2-${BWA_VER}_x64-linux.tar.bz2 && \
	rm bwa-mem2-${BWA_VER}_x64-linux.tar.bz2 && \
	cd bwa-mem2-${BWA_VER}_x64-linux && \
	sudo cp bwa-mem2* /usr/local/bin/ && \
	# install samtools
	wget "https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VER}/samtools-${SAMTOOLS_VER}.tar.bz2" -O "samtools.tar.bz2" && \
	tar -vxjf samtools.tar.bz2 && \
	rm samtools.tar.bz2 && \
	cd samtools-${SAMTOOLS_VER} && \
	autoreconf && ./configure && \
	make -j 6 && \
	sudo make prefix=/usr/local install

# final image
FROM registry.gitlab.com/roysomak4/genbio_containers/genbio_base:bullseye

LABEL maintainer="Somak Roy<roysomak4@gmail.com>" \
    function="Docker image with bwa and samtools"

USER bioseq
WORKDIR /home/bioseq

ENV BWA_VER=2.2.1

COPY --from=builder /usr/local/bin/* /usr/local/bin/

RUN sudo install_packages libisal2 libdeflate0 parallel libcurl4-gnutls-dev