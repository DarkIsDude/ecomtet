FROM ruby:2.5

LABEL MAINTAINER="Edouard COMTET<edouard.comtet@gmail.com>"
LABEL version="1.0"

RUN apt-get update
RUN gem install jekyll
RUN apt-get update && apt-get -y autoremove && apt-get clean

RUN mkdir /app/
COPY . /app/
WORKDIR /app/

RUN bundle install

VOLUME "/app/"
EXPOSE 4000
