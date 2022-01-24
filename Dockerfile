from mcr.microsoft.com/playwright:v1.17.2-focal

RUN pip install --upgrade pip
RUN pip install --no-cache-dir --upgrade playwright
RUN pip install --no-cache-dir --upgrade pytest-playwright
RUN pip install --no-cache-dir --upgrade allure-pytest

RUN python -m playwright install

COPY ./sample-tests /sample-tests
WORKDIR /sample-tests

CMD python -m pytest --alluredir=allure-result-folder
