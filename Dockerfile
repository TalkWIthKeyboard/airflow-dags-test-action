FROM python:3.7

RUN pip install apache-airflow==1.10.15 \
  wtforms==2.3.3 \
  # ImportError: cannot import name 'soft_unicode' from 'markupsafe'
  # https://github.com/pallets/markupsafe/issues/284
  markupsafe==2.0.1 \
  # Install Airflow - ImportError: No module named clsregistry
  # https://stackoverflow.com/questions/66774109/install-airflow-importerror-no-module-named-clsregistry
  SQLAlchemy==1.3.23 \
  Flask-SQLAlchemy==2.4.4

ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

RUN airflow db init > /dev/null

ENTRYPOINT ["/entrypoint.sh"]
