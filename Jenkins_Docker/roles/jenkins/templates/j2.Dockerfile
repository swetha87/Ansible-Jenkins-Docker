FROM jenkins/jenkins:{{version}}

USER root
RUN curl -fsSLO https://download.docker.com/linux/static/stable/`uname -m`/docker-{{docker_cli_version}}.tgz \
  && tar --strip-components=1 -xvzf docker-{{docker_cli_version}}.tgz -C /usr/local/bin \
    && chmod +x /usr/local/bin/docker \
    && wget -O /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/{{docker_compose_version}}/docker-compose-`uname -s`-`uname -m` \
    && chmod +x /usr/local/bin/docker-compose \
    && addgroup --gid 999 docker \
    && usermod -a -G docker jenkins

RUN apt-get update && apt-get install ansible -y

USER jenkins


VOLUME /var/jenkins_home
EXPOSE 8080