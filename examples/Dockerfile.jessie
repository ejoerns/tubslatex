FROM debian:jessie

# Required for building (latex)
RUN apt-get update && apt-get install -y \
  texlive \
  texlive-fonts-extra

# Required for building (base)
RUN apt-get update && apt-get install -y \
  make \
  git \
  wget \
  zip

# Required for building (latex continued)
RUN apt-get update && apt-get install -y \
  texlive-lang-german \
  lcdf-typetools

# Required to run regression tests
RUN apt-get update && apt-get install -y \
  imagemagick \
  poppler-utils \
  latexmk

RUN wget https://tug.org/fonts/getnonfreefonts/install-getnonfreefonts && \
  texlua install-getnonfreefonts && \
  getnonfreefonts --sys --verbose arial-urw

USER ${user}
