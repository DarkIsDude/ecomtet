FROM jekyll/jekyll

LABEL MAINTAINER="Edouard COMTET<edouard.comtet@gmail.com>"
LABEL version="1.0"

COPY . /srv/jekyll
RUN bundle install

EXPOSE 4000

CMD [ "jekyll", "serve" ]