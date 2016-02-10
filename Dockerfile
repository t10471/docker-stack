## stack 
FROM t10471/base:latest

MAINTAINER t10471 <t104711202@gmail.com>

RUN wget -q -O- https://s3.amazonaws.com/download.fpcomplete.com/ubuntu/fpco.key | sudo apt-key add -
RUN echo 'deb http://download.fpcomplete.com/ubuntu/trusty stable main'|sudo tee /etc/apt/sources.list.d/fpco.list
RUN apt-get update && sudo apt-get install stack -y
RUN stack install cabal-install alex happy yesod-bin ghc-mod html-conduit http-conduit hasktags  codex hscope pointfree pointful hoogle haddock pandoc stylish-haskell --install-ghc
