FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install --no-install-recommends --no-install-suggests -y \
        curl vim git \
        # Web サーバ
        apache2 \
        # 記事管理サービス
        gawk pandoc nkf \
        # 日本語設定
        manpages-ja manpages-ja-dev language-pack-ja \
        # 開発環境に必要なモジュール
        rsync ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 日本語設定
RUN update-locale LANG=ja_JP.UTF-8

# Apache 設定
COPY ./docker/ubuntu/apache/apache2.conf /etc/apache2/apache2.conf

## Apache に CGI 動作モジュールを有効化
ADD ./docker/ubuntu/apache/bashcms2.conf /etc/apache2/sites-available/bashcms2.conf
RUN rm /etc/apache2/sites-enabled/000-default.conf && \
    ln -s /etc/apache2/sites-available/bashcms2.conf /etc/apache2/sites-enabled/ && \
    a2enmod cgid

## /tmp ディレクトリ使用設定
COPY ./docker/ubuntu/apache/apache2.service /etc/systemd/system/multi-user.target.wants/apache2.service

ADD ./docker/ubuntu/apache/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
