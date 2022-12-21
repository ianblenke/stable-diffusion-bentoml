FROM nvcr.io/nvidia/pytorch:22.11-py3

ADD requirements.txt /requirements.txt

RUN apt-get update \
 && apt-get install -y python3.8-venv

RUN python3 -m venv venv \
 && . venv/bin/activate \
 && pip install -U pip \
 && pip install -r /requirements.txt \
 && pip install accelerate

COPY fp32/ /stable-diffusion-bentoml

WORKDIR /stable-diffusion-bentoml

ENTRYPOINT

ENV USE_TORCH=1 BENTOML_CONFIG=configuration.yaml

CMD [ "/bin/dash" , "-xc", ". /workspace/venv/bin/activate && BENTOML_CONFIG=configuration.yaml bentoml serve service:svc" ]

